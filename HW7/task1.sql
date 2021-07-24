USE shop;
INSERT INTO orders (user_id)
VALUE (3), (5), (6), (2), (1), (2), (3), (2);
/* 
Зазача 1.Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
*/
SELECT u.id, COUNT(*)
FROM orders o
	JOIN users u ON (u.id = o.user_id)
GROUP BY u.id;
-- вариант 2
SELECT DISTINCT u.id
FROM orders o
	JOIN users u ON (u.id = o.user_id);