/* 
Практическое задание по теме “Оптимизация запросов”
Зазача 1 Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, 
catalogs и products в таблицу logs помещается время и дата создания записи, название таблицы, 
идентификатор первичного ключа и содержимое поля name.
*/
USE shop;
DROP TABLE IF EXISTS `logs`;
CREATE TABLE `logs`(
create_at datetime DEFAULT NOW(), 
`table_name` varchar(45) NOT NULL, 
table_id INT UNSIGNED NOT NULL, 
name_value varchar(45)) engine=ARCHIVE;

-- ----------------- users --------------------------------

USE shop;
DROP TRIGGER IF EXISTS log_users_after_insert; 
DELIMITER ||

CREATE TRIGGER log_users_after_insert AFTER INSERT ON `users` 
FOR EACH ROW 
	BEGIN
		INSERT INTO shop.logs (create_at,`table_name`, table_id, name_value)
		VALUES (now(), 'shop.users', NEW.id, NEW.name);
	END ||
DELIMITER ;

SELECT * FROM users;
SELECT * FROM `logs`;

INSERT INTO users (name, birthday_at)
VALUES ('Halk', '1981-01-01');

-- --------------------- catalogs-------------------------------
DROP TRIGGER IF EXISTS log_catalogs_after_insert;
DELIMITER ||
CREATE TRIGGER log_catalogs_after_insert AFTER INSERT ON `catalogs` 
FOR EACH ROW
	BEGIN
		INSERT INTO shop.logs (create_at, `table_name`, table_id, name_value)
		VALUES (now(), 'shop.catalogs', new.id, new.name);
	END ||
DELIMITER ;

SELECT * FROM catalogs;
SELECT * FROM `logs`;

INSERT INTO catalogs (name)
VALUES ('Мониторы');

-- ---------------------products--------------------------------
DROP TRIGGER IF EXISTS log_products_after_insert;
DELIMITER ||
CREATE TRIGGER log_products_after_insert AFTER INSERT ON `products` 
FOR EACH ROW
	BEGIN
		INSERT INTO shop.logs (create_at, `table_name`, table_id, name_value)
		VALUES (now(), 'shop.products', new.id, new.name);
	END ||
DELIMITER ;

SELECT * FROM products;
SELECT * FROM `logs`;

INSERT INTO products (name, description, price, catalog_id)
VALUES ('SONY_F', 'МОНИТОР_GFC', 8000.00, 8);
