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

Prompt ******  Inserting into PLAYERS ....

insert into players values (1, 1, 0, 'alice');
insert into players values (1, 2, 5, 'bob');
insert into players values (1, 3, 12, NULL);

REM  items.type: 0 = property item, 1 = cashbag item
Prompt ******  Inserting into ITEMS ....

insert into items values (1, 0);
insert into items values (2, 0);
insert into items values (3, 0);
insert into items values (4, 1);
insert into items values (5, 1);
insert into items values (6, 1);

Prompt ******  Inserting into PROPERTY_ITEMS ....

insert into property_items values (1, 1);
insert into property_items values (2, 21);
insert into property_items values (3, 9);

Prompt ******  Inserting into CASHBAG_ITEMS ....

insert into cashbag_items values (4, 200);
insert into cashbag_items values (5, 50);
insert into cashbag_items values (6, 1500);

REM  from_pawn NULL models a movement originating from the bank.
Prompt ******  Inserting into TRANSACTIONS ....

insert into transactions values (1, 1, NULL, 1, 6, NULL);
insert into transactions values (2, 1, NULL, 2, 1, NULL);
insert into transactions values (3, 1, NULL, 1, 2, NULL);
insert into transactions values (4, 1, 1, 3, 2, 1000);
insert into transactions values (5, 1, 3, 1, 4, 1001);
