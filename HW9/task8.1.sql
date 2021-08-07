/* 
Зазача 8.1 Создайте хранимую функцию hello(), которая будет возвращать приветствие, 
в зависимости от текущего времени суток. С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", 
с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", 
с 00:00 до 6:00 — "Доброй ночи".
*/

DROP FUNCTION IF EXISTS hello;
delimiter //
CREATE FUNCTION hello()
RETURNS TEXT DETERMINISTIC
BEGIN
	IF(CURTIME() BETWEEN '06:00:00' AND '11:59:59') THEN
		RETURN 'Доброе утро';
	ELSEIF(CURTIME() BETWEEN '12:00:00' AND '17:59:59') THEN
		RETURN 'Добрый день';
	ELSEIF(CURTIME() BETWEEN '18:00:00' AND '23:59:59') THEN
		RETURN 'Добрый вечер';
	ELSE
		RETURN 'Доброй ночи';
	END IF;
END //
delimiter ;

SELECT hello();
