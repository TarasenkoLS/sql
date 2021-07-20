USE test1;
CREATE TABLE users_1 (
  id bigint unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
  first_name varchar(145) NOT NULL);
ALTER TABLE users_1 ADD COLUMN created_at VARCHAR(255) NOT NULL;
ALTER TABLE users_1 ADD COLUMN updated_at VARCHAR(255) NOT NULL;
INSERT INTO users_1 (first_name, created_at, updated_at)
VALUES ('Vasya', '5.3.2019 22:16', '5.3.2019 22:16'),
	('Irina', '28.6.2019 15:57', '28.6.2019 15:57'),
	('Yana', '12.5.2019 11:36', '12.5.2019 11:36'),
	('Viktoria', '17.6.2020 23:29', '17.6.2020 23:29'),
	('Andrey', '10.2.2019 19:34', '10.2.2019 19:34'),
	('Alex', '27.11.2020 12:48', '27.11.2020 12:48'),
	('Piter', '2.12.2019 18:30', '2.12.2019 18:30'),
	('Nikolas', '15.1.2019 23:29', '15.1.2019 23:29'),
	('Genry', '18.12.2020 5:6', '18.12.2020 5:6'),
	('Kate', '26.11.2020 18:20', '26.11.2020 18:20'),
	('Glorya', '16.3.2019 22:58', '16.3.2019 22:58'),
	('Fima', '8.7.2020 4:48', '8.7.2020 4:48'),
	('Lisa', '17.3.2019 15:42', '17.3.2019 15:42');
SELECT * FROM users_1;
SET SQL_SAFE_UPDATES = 0;
ALTER TABLE users_1 ADD created_at_dt DATETIME;
ALTER TABLE users_1 ADD updated_at_dt DATETIME;
UPDATE users_1
SET created_at_dt = STR_TO_DATE(created_at, '%d.%m.%Y %H:%i'),
    updated_at_dt = STR_TO_DATE(updated_at, '%d.%m.%Y %H:%i');
ALTER TABLE users_1 
    DROP created_at, DROP updated_at, 
    RENAME COLUMN created_at_dt TO created_at, RENAME COLUMN updated_at_dt TO updated_at;
    
 --  3 В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. Однако нулевые запасы должны выводиться в конце, после всех записей.
  
    SELECT 
    value
FROM
    storehouses_products ORDER BY IF(value > 0, 0, 1), value;
    
-- 4.(по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. 
-- Месяцы заданы в виде списка английских названий (may, august)
SELECT
    name,  birthday_at,
	CASE 
        WHEN DATE_FORMAT(birthday_at, '%m') = 05 THEN 'may'
        WHEN DATE_FORMAT(birthday_at, '%m') = 08 THEN 'august'
    END AS mounth
FROM
    users
WHERE DATE_FORMAT(birthday_at, '%m') in (05, 08);

-- 5 (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); 
-- Отсортируйте записи в порядке, заданном в списке IN.
SELECT* FROM products WHERE id IN (5, 1, 2) ORDER BY FIELD(id, 5, 1, 2);