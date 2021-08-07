-- Практическое задание по теме «Операторы, фильтрация, сортировка и ограничение»
-- 1 Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.
UPDATE users_1
SET created_at = now(),
    updated_at = now();

-- 2 Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате 20.10.2017 8:10. Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения.
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

-- Практическое задание теме «Агрегация данных»
-- 1 Подсчитайте средний возраст пользователей в таблице users.
SELECT AVG(TIMESTAMPDIFF(YEAR, birthday, NOW())) AS avg_age
FROM vk.profiles;

-- 2 Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
-- Следует учесть, что необходимы дни недели текущего года, а не года рождения.
-- определяем даты дней рождения в текущем году
SELECT DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday), DAY(birthday))) AS date_birthday FROM vk.profiles;
-- определяем дни недели дней рождения в текущем году
SELECT DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday), DAY(birthday))), '%W') AS weekday FROM vk.profiles;
-- итоговый запрос
SELECT
	DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday), DAY(birthday))), '%W') AS weekday,
    COUNT(*) AS total
FROM
	vk.profiles
GROUP BY
	weekday;
    
-- 3    (по желанию) Подсчитайте произведение чисел в столбце таблицы.
 SELECT ROUND(exp(SUM(ln(value))), 0) AS rezult FROM tbl
