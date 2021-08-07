USE sample;
CREATE TABLE  flights (
	id int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
	point_from VARCHAR (100) NOT NULL,
	point_to VARCHAR (100) NOT NULL
    );
INSERT INTO flights (point_from, point_to)
VALUE ('moscow', 'omsk'), ('novgorod', 'kazan'), ('irkutsk', 'moscow'), ('tomsk', 'novgorod'), ('moscow', 'kazan');

CREATE TABLE  cities (
	lable VARCHAR (100) NOT NULL,
	`name` VARCHAR (100) NOT NULL
    );
INSERT INTO cities 
VALUE ('moscow', 'Москва'), ('novgorod', 'Новгород'), ('irkutsk', 'Иркутск'), ('tomsk', 'Томск'), ('kazan', 'Казань');
INSERT INTO cities 
VALUE ('omsk', 'Oмск');
/* 
Зазача 3.(по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
Поля from, to и label содержат английские названия городов, поле name — русское. 
Выведите список рейсов flights с русскими названиями городов.
*/
-- названия полей немного изменила
SELECT f.id, c_f.name as cities_from, c_t.name as cities_to
FROM flights f
	JOIN cities c_f ON (f.point_from = c_f.lable)
    JOIN cities c_t ON (f.point_to = c_t.lable)
ORDER BY f.id;
