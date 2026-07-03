"""Server-side rendered viewer for Monopoly game state."""

from flask import Flask, abort, render_template

import db

app = Flask(__name__)


@app.route("/")
def index():
    with db.connect() as conn:
        games = db.list_games(conn)
    return render_template("index.html", games=games)


@app.route("/games/<int:game_id>")
def game(game_id: int):
    with db.connect() as conn:
        game = db.get_game(conn, game_id)
        if game is None:
            abort(404)
        players = db.get_players(conn, game_id)
    return render_template("game.html", game=game, players=players)
