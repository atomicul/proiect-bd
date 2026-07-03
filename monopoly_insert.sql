REM ********************************************************************
REM Illustrative seed data for the Monopoly schema.

Prompt ******  Inserting into SETS ....

insert into sets values ('Brown', 50);
insert into sets values ('Light Blue', 50);
insert into sets values ('Pink', 100);
insert into sets values ('Orange', 100);
insert into sets values ('Red', 150);
insert into sets values ('Yellow', 150);
insert into sets values ('Green', 200);
insert into sets values ('Dark Blue', 200);

Prompt ******  Inserting into PROPERTIES ....

insert into properties values (1, 'Brown', 'Mediterranean Avenue', 60);
insert into properties values (2, 'Brown', 'Baltic Avenue', 60);
insert into properties values (3, 'Light Blue', 'Oriental Avenue', 100);
insert into properties values (4, 'Light Blue', 'Vermont Avenue', 100);
insert into properties values (5, 'Light Blue', 'Connecticut Avenue', 120);
insert into properties values (6, 'Pink', 'St. Charles Place', 140);
insert into properties values (7, 'Pink', 'States Avenue', 140);
insert into properties values (8, 'Pink', 'Virginia Avenue', 160);
insert into properties values (9, 'Orange', 'St. James Place', 180);
insert into properties values (10, 'Orange', 'Tennessee Avenue', 180);
insert into properties values (11, 'Orange', 'New York Avenue', 200);
insert into properties values (12, 'Red', 'Kentucky Avenue', 220);
insert into properties values (13, 'Red', 'Indiana Avenue', 220);
insert into properties values (14, 'Red', 'Illinois Avenue', 240);
insert into properties values (15, 'Yellow', 'Atlantic Avenue', 260);
insert into properties values (16, 'Yellow', 'Ventnor Avenue', 260);
insert into properties values (17, 'Yellow', 'Marvin Gardens', 280);
insert into properties values (18, 'Green', 'Pacific Avenue', 300);
insert into properties values (19, 'Green', 'North Carolina Avenue', 300);
insert into properties values (20, 'Green', 'Pennsylvania Avenue', 320);
insert into properties values (21, 'Dark Blue', 'Park Place', 350);
insert into properties values (22, 'Dark Blue', 'Boardwalk', 400);

Prompt ******  Inserting into GAMES ....

insert into games values (1, 424242, 'Friday Night Game');
insert into games values (2, 131313, 'Sunday Rematch');
insert into games values (3, 777001, 'Office Tournament');
insert into games values (4, 555222, 'Family Game');
insert into games values (5, 909090, 'Online Blitz');

Prompt ******  Inserting into PLAYERS ....

insert into players values (1, 1, 0, 'alice');
insert into players values (1, 2, 5, 'bob');
insert into players values (1, 3, 12, NULL);
insert into players values (2, 1, 0, 'carol');
insert into players values (2, 2, 8, 'dave');
insert into players values (3, 1, 3, 'erin');
insert into players values (3, 2, 0, 'frank');
insert into players values (4, 1, 0, 'grace');
insert into players values (5, 1, 0, 'heidi');

REM  items.type: 0 = property item, 1 = cashbag item
Prompt ******  Inserting into ITEMS ....

insert into items values (1, 0);
insert into items values (2, 0);
insert into items values (3, 0);
insert into items values (4, 1);
insert into items values (5, 1);
insert into items values (6, 1);
insert into items values (7, 0);
insert into items values (8, 0);
insert into items values (9, 1);
insert into items values (10, 1);

Prompt ******  Inserting into PROPERTY_ITEMS ....

insert into property_items values (1, 1);
insert into property_items values (2, 21);
insert into property_items values (3, 9);
insert into property_items values (7, 5);
insert into property_items values (8, 14);

Prompt ******  Inserting into CASHBAG_ITEMS ....

insert into cashbag_items values (4, 200);
insert into cashbag_items values (5, 50);
insert into cashbag_items values (6, 1500);
insert into cashbag_items values (9, 300);
insert into cashbag_items values (10, 75);

REM  from_pawn NULL models a movement originating from the bank.
Prompt ******  Inserting into TRANSACTIONS ....

insert into transactions values (1, 1, NULL, 1, 6, NULL);
insert into transactions values (2, 1, NULL, 2, 1, NULL);
insert into transactions values (3, 1, NULL, 1, 2, NULL);
insert into transactions values (4, 1, 1, 3, 2, 1000);
insert into transactions values (5, 1, 3, 1, 4, 1001);

Prompt ******  Inserting into BOARD_SQUARES ....

insert into board_squares values (0, 'Go', 'GO', NULL);
insert into board_squares values (1, 'Mediterranean Avenue', 'PROPERTY', 1);
insert into board_squares values (2, 'Community Chest', 'COMMUNITY_CHEST', NULL);
insert into board_squares values (3, 'Baltic Avenue', 'PROPERTY', 2);
insert into board_squares values (4, 'Income Tax', 'TAX', NULL);
insert into board_squares values (5, 'Reading Railroad', 'RAILROAD', NULL);
insert into board_squares values (6, 'Oriental Avenue', 'PROPERTY', 3);
insert into board_squares values (7, 'Chance', 'CHANCE', NULL);
insert into board_squares values (10, 'Jail', 'JAIL', NULL);
insert into board_squares values (11, 'St. Charles Place', 'PROPERTY', 6);
insert into board_squares values (20, 'Free Parking', 'FREE_PARKING', NULL);
insert into board_squares values (30, 'Go To Jail', 'GO_TO_JAIL', NULL);

Prompt ******  Inserting into CARDS ....

insert into cards values (1, 'COMMUNITY_CHEST', 'Bank error in your favor. Collect $200', 200);
insert into cards values (2, 'CHANCE', 'Advance to Boardwalk', 0);
insert into cards values (3, 'CHANCE', 'Pay poor tax of $15', -15);
insert into cards values (4, 'COMMUNITY_CHEST', 'Doctor''s fee. Pay $50', -50);
insert into cards values (5, 'CHANCE', 'Your building loan matures. Collect $150', 150);
insert into cards values (6, 'COMMUNITY_CHEST', 'Go directly to Jail', 0);

Prompt ******  Inserting into DICE_ROLLS ....

insert into dice_rolls values (1, 1, 1, 3, 4);
insert into dice_rolls values (1, 1, 2, 6, 2);
insert into dice_rolls values (1, 2, 1, 5, 5);
insert into dice_rolls values (1, 3, 1, 1, 2);
insert into dice_rolls values (2, 1, 1, 4, 3);
insert into dice_rolls values (2, 2, 1, 6, 6);

Prompt ******  Inserting into CARD_DRAWS ....

insert into card_draws values (1, 1, 1, 1, 1);
insert into card_draws values (2, 1, 2, 3, 1);
insert into card_draws values (3, 1, 3, 2, 1);
insert into card_draws values (4, 2, 1, 4, 1);
insert into card_draws values (5, 2, 2, 5, 1);
