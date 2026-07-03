SET FEEDBACK 1
SET NUMWIDTH 10
SET LINESIZE 80
SET TRIMSPOOL ON
SET TAB OFF
SET PAGESIZE 100
SET ECHO OFF

REM ********************************************************************
REM Monopoly schema.
REM The ERD attribute `properties.set` is mapped to the column
REM `set_color` here, because `SET` is a reserved word in Oracle SQL.

REM ********************************************************************
REM SETS holds the color groups and the price of a house on that group.

Prompt ******  Creating SETS table ....

CREATE TABLE sets
    ( color         VARCHAR2(255)
    , house_price   INTEGER
    , CONSTRAINT sets_pk PRIMARY KEY (color)
    );

REM ********************************************************************
REM GAMES holds a single game of Monopoly.

Prompt ******  Creating GAMES table ....

CREATE TABLE games
    ( id            INTEGER
    , rng_seed      INTEGER
    , friendly_name NVARCHAR2(255)
    , CONSTRAINT games_pk PRIMARY KEY (id)
    );

REM ********************************************************************
REM ITEMS is the supertype for anything that can be owned/traded.
REM `type` discriminates between the PROPERTY_ITEMS and CASHBAG_ITEMS
REM subtypes.

Prompt ******  Creating ITEMS table ....

CREATE TABLE items
    ( id            INTEGER
    , type          INTEGER
    , CONSTRAINT items_pk PRIMARY KEY (id)
    );

REM ********************************************************************
REM PROPERTIES holds the buyable board squares, grouped into a SET.

Prompt ******  Creating PROPERTIES table ....

CREATE TABLE properties
    ( id            INTEGER
    , set_color     VARCHAR2(255)
    , name          VARCHAR2(255)
    , price         INTEGER
    , CONSTRAINT properties_pk PRIMARY KEY (id)
    );

ALTER TABLE properties
ADD ( CONSTRAINT properties_set_fk
        FOREIGN KEY (set_color)
        REFERENCES sets (color)
    );

REM ********************************************************************
REM PLAYERS is a pawn taking part in a GAME. Identified by the game it
REM belongs to plus its pawn number.

Prompt ******  Creating PLAYERS table ....

CREATE TABLE players
    ( game             INTEGER
    , pawn             INTEGER
    , current_position INTEGER
    , username         VARCHAR2(255)
    , CONSTRAINT players_pk PRIMARY KEY (game, pawn)
    );

ALTER TABLE players
ADD ( CONSTRAINT players_game_fk
        FOREIGN KEY (game)
        REFERENCES games (id)
    );

REM ********************************************************************
REM PROPERTY_ITEMS is a subtype of ITEMS: an item that represents the
REM ownership of a PROPERTY. Its id is shared 1:1 with ITEMS.

Prompt ******  Creating PROPERTY_ITEMS table ....

CREATE TABLE property_items
    ( id            INTEGER
    , property      INTEGER
    , CONSTRAINT property_items_pk PRIMARY KEY (id)
    );

ALTER TABLE property_items
ADD ( CONSTRAINT property_items_item_fk
        FOREIGN KEY (id)
        REFERENCES items (id)
    , CONSTRAINT property_items_property_fk
        FOREIGN KEY (property)
        REFERENCES properties (id)
    );

REM ********************************************************************
REM CASHBAG_ITEMS is a subtype of ITEMS: an item that holds an amount
REM of cash. Its id is shared 1:1 with ITEMS.

Prompt ******  Creating CASHBAG_ITEMS table ....

CREATE TABLE cashbag_items
    ( id            INTEGER
    , count         INTEGER
    , CONSTRAINT cashbag_items_pk PRIMARY KEY (id)
    );

ALTER TABLE cashbag_items
ADD ( CONSTRAINT cashbag_items_item_fk
        FOREIGN KEY (id)
        REFERENCES items (id)
    );

REM ********************************************************************
REM TRANSACTIONS records an ITEM moving between pawns within a GAME.
REM from_pawn is NULL for movements originating from the bank.
REM Paired trades share a common trade_key.

Prompt ******  Creating TRANSACTIONS table ....

CREATE TABLE transactions
    ( id            INTEGER
    , game          INTEGER
    , from_pawn     INTEGER
    , to_pawn       INTEGER
    , item          INTEGER
    , trade_key     INTEGER
    , CONSTRAINT transactions_pk PRIMARY KEY (id)
    , CONSTRAINT transactions_trade_key_uk UNIQUE (trade_key)
    );

ALTER TABLE transactions
ADD ( CONSTRAINT transactions_game_fk
        FOREIGN KEY (game)
        REFERENCES games (id)
    , CONSTRAINT transactions_item_fk
        FOREIGN KEY (item)
        REFERENCES items (id)
    , CONSTRAINT transactions_from_fk
        FOREIGN KEY (game, from_pawn)
        REFERENCES players (game, pawn)
    , CONSTRAINT transactions_to_fk
        FOREIGN KEY (game, to_pawn)
        REFERENCES players (game, pawn)
    );
