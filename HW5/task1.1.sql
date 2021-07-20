USE test1;
INSERT INTO users_1 (first_name)
VALUES ('Vasya'),
	('Irina'),
	('Yana'),
	('Viktoria'),
	('Andrey'),
	('Alex'),
	('Piter'),
	('Nikolas'),
	('Genry'),
	('Kate'),
	('Glorya'),
	('Fima'),
	('Lisa');
UPDATE users_1
SET created_at = now(),
    updated_at = now();