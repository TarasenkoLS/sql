use test1;
CREATE TABLE `storehouses_products` (
  id bigint unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
  product_name varchar(145) NOT NULL, 
  `value` bigint unsigned);
  INSERT INTO storehouses_products 
  VALUES (DEFAULT, 'afsdf', '10'),
	(DEFAULT, 'asevs', '340'),
    (DEFAULT, 'sfds', '3450'),
    (DEFAULT, 'dzdhfgk', '864'),
    (DEFAULT, 'dilk', '0'),
    (DEFAULT, 'sfzdgg', '34553'),
    (DEFAULT, 'mjkhnh', '0'),
    (DEFAULT, 'djluol', '765'),
    (DEFAULT, 'fgcdk', '97');

SELECT 
    value
FROM
    storehouses_products ORDER BY IF(value > 0, 0, 1), value;

