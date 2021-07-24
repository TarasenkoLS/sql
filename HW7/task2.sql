/* 
Зазача 2.Выведите список товаров products и разделов catalogs, который соответствует товару.
*/
USE shop;
SELECT p.name as product_name, ct.name as catalog_name
FROM products p
	JOIN catalogs ct ON (ct.id = p.catalog_id)
ORDER BY p.id;