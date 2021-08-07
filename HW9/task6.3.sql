USE shop;
/* 
Зазача 6.3 Пусть имеется таблица с календарным полем created_at. В ней размещены разряженые 
календарные записи за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17. 
Составьте запрос, который выводит полный список дат за август, выставляя в соседнем поле значение 1, 
если дата присутствует в исходном таблице и 0, если она отсутствует.
*/

DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (
 id int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
 created_at date);
INSERT INTO table1 (created_at) 
VALUES ('2018-08-01'), ('2018-08-04'), ('2018-08-16'), ('2018-08-17');
-- SELECT * FROM table1;

DROP TABLE IF EXISTS days_aug;
CREATE TEMPORARY TABLE days_aug (days int);

INSERT INTO days_aug VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10), 
							(11), (12),(13),(14), (15), (16), (17), (18), (19), (20),
                            (21), (22), (23), (24), (25), (26), (27), (28), (29), (30), (31);
                            
SELECT '2018-07-31' + INTERVAL days DAY AS date_aug,
	CASE 
		WHEN table1.created_at is NULL THEN 0 ELSE 1 
    END AS vars
FROM days_aug
	LEFT JOIN table1 ON '2018-07-31' + INTERVAL days DAY = table1.created_at
ORDER BY date_aug;