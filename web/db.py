"""Data access for the Monopoly game-state viewer.

Holdings are not stored directly; an item's current holder in a game is the
`to_pawn` of its highest-id transaction for that (game, item). Everything here
derives game state from that append-only log.
"""

import os
import time
from dataclasses import dataclass, field

import oracledb


def _dsn() -> str:
    host = os.environ.get("DB_HOST", "oracle")
    port = os.environ.get("DB_PORT", "1521")
    service = os.environ["ORACLE_DATABASE"]
    return f"{host}:{port}/{service}"


def connect(retries: int = 30, delay: float = 2.0) -> oracledb.Connection:
    """Connect in thin mode, retrying while the database finishes booting."""
    user = os.environ["APP_USER"]
    password = os.environ["APP_USER_PASSWORD"]
    dsn = _dsn()

    last_error: Exception | None = None
    for _ in range(retries):
        try:
            return oracledb.connect(user=user, password=password, dsn=dsn)
        except oracledb.Error as error:
            last_error = error
            time.sleep(delay)
    raise RuntimeError(f"could not connect to {dsn}") from last_error


@dataclass
class Game:
    id: int
    friendly_name: str | None
    player_count: int


@dataclass
class Property:
    name: str
    price: int
    set_color: str


@dataclass
class Player:
    pawn: int
    current_position: int
    username: str | None
    properties: list[Property] = field(default_factory=list)
    cash: int = 0


def list_games(conn: oracledb.Connection) -> list[Game]:
    sql = """
        SELECT g.id, g.friendly_name, COUNT(p.pawn)
        FROM games g
        LEFT JOIN players p ON p.game = g.id
        GROUP BY g.id, g.friendly_name
        ORDER BY g.id
    """
    with conn.cursor() as cursor:
        cursor.execute(sql)
        return [
            Game(id=row[0], friendly_name=row[1], player_count=row[2]) for row in cursor
        ]


def get_game(conn: oracledb.Connection, game_id: int) -> Game | None:
    sql = """
        SELECT g.id, g.friendly_name, COUNT(p.pawn)
        FROM games g
        LEFT JOIN players p ON p.game = g.id
        WHERE g.id = :game
        GROUP BY g.id, g.friendly_name
    """
    with conn.cursor() as cursor:
        cursor.execute(sql, game=game_id)
        row = cursor.fetchone()
    if row is None:
        return None
    return Game(id=row[0], friendly_name=row[1], player_count=row[2])


def get_players(conn: oracledb.Connection, game_id: int) -> list[Player]:
    """Players of a game, each with their currently held properties and cash."""
    players: dict[int, Player] = {}
    with conn.cursor() as cursor:
        cursor.execute(
            """
            SELECT pawn, current_position, username
            FROM players
            WHERE game = :game
            ORDER BY pawn
            """,
            game=game_id,
        )
        for pawn, position, username in cursor:
            players[pawn] = Player(
                pawn=pawn, current_position=position, username=username
            )

    for pawn, prop in _current_properties(conn, game_id):
        if pawn in players:
            players[pawn].properties.append(prop)

    for pawn, cash in _current_cash(conn, game_id):
        if pawn in players:
            players[pawn].cash = cash

    return list(players.values())


def _current_holdings_cte() -> str:
    """Sub-query yielding the current holder of every item in a game."""
    return """
        SELECT t.item AS item, t.to_pawn AS pawn
        FROM transactions t
        WHERE t.game = :game
          AND t.id = (SELECT MAX(t2.id) FROM transactions t2
                      WHERE t2.game = t.game AND t2.item = t.item)
    """


def _current_properties(conn, game_id):
    sql = f"""
        SELECT h.pawn, p.name, p.price, p.set_color
        FROM ({_current_holdings_cte()}) h
        JOIN property_items pi ON pi.id = h.item
        JOIN properties p ON p.id = pi.property
        ORDER BY h.pawn, p.name
    """
    with conn.cursor() as cursor:
        cursor.execute(sql, game=game_id)
        for pawn, name, price, set_color in cursor:
            yield pawn, Property(name=name, price=price, set_color=set_color)


def _current_cash(conn, game_id):
    sql = f"""
        SELECT h.pawn, SUM(c.count)
        FROM ({_current_holdings_cte()}) h
        JOIN cashbag_items c ON c.id = h.item
        GROUP BY h.pawn
    """
    with conn.cursor() as cursor:
        cursor.execute(sql, game=game_id)
        yield from cursor
