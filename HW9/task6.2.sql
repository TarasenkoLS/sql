/* 
Зазача 6.2. Создайте представление, которое выводит название name товарной позиции из таблицы products 
и соответствующее название каталога name из таблицы catalogs.
*/
USE shop;
CREATE VIEW prod_view(prod_name, cat_name) AS
SELECT p.name AS prod_name, cat.name
FROM products AS p
LEFT JOIN catalogs AS cat
ON p.catalog_id = cat.id;
SELECT * FROM prod_view;