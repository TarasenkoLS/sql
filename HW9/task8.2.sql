/* 
Зазача 8.2 В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
Допустимо присутствие обоих полей или одно из них. 
Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
При попытке присвоить полям NULL-значение необходимо отменить операцию.
*/
    
USE shop;
DROP TRIGGER IF EXISTS check_prod_before_insert;

DELIMITER //

CREATE TRIGGER check_prod_before_insert BEFORE INSERT ON products
FOR EACH ROW
	BEGIN
		IF NEW.name IS NULL AND NEW.description IS NULL THEN 
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insert Canceled. Name and description must not be Null';
		END IF;
	END //
	
DELIMITER ;
-- неудача с добавлением товара с пустым значением полей 
INSERT INTO products (name, description, price, catalog_id) VALUES 
	(NULL, NULL, '7120.00', '1');

INSERT INTO products (name, description, price, catalog_id) VALUES 
	('AMD FX-8350', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD', '7120.00', '1');


