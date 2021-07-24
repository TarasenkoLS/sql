USE vk;

ALTER TABLE friend_requests
ADD CONSTRAINT sender_not_recierver_check
CHECK (from_user_id != to_user_id);

ALTER TABLE users 
ADD CONSTRAINT phone_check
CHECK (REGEXP_LIKE(phone, '^[0-9]{11}$'));

ALTER TABLE profiles 
ADD CONSTRAINT fk_profiles_media
FOREIGN KEY (photo_id) REFERENCES media (id);

-- добавляем пользователя
INSERT INTO users (id, first_name, last_name, email, phone, password_hash)
VALUES (DEFAULT, 'Alex', 'Stepanov', 'alex@mail.com', '89213546566', 'aaa');

SELECT * FROM users;

-- добавляем повторно того же пользователя, ошибка не возникает
INSERT IGNORE users (id, first_name, last_name, email, phone, password_hash)
VALUES (DEFAULT, 'Alex', 'Stepanov', 'alex@mail.com', '89213546566', 'aaa');

-- не указываем default значения
INSERT users (first_name, last_name, email, phone)
VALUES ('Lena', 'Stepanova', 'lena@mail.com', '89213546568');

-- не указываем названия колонок
INSERT users 
VALUES (DEFAULT, 'Chris', 'Ivanov', 'chris@mail.com', '89213546560', DEFAULT, DEFAULT);

-- явно задаем id
INSERT INTO users (id, first_name, last_name, email, phone)
VALUES (55, 'Jane', 'Kvanov', 'jane@mail.com', '89293546560');

-- пробуем добавить id меньше текущего
INSERT INTO users (id, first_name, last_name, email, phone) VALUES 
(45, 'Jane', 'Night', 'jane_n@mail.com', '89293946560');

-- добавляем несколько пользователей
INSERT INTO users (first_name, last_name, email, phone)
VALUES ('Igor', 'Petrov', 'igor@mail.com', '89213549560'),
		('Oksana', 'Petrova', 'oksana@mail.com', '89213549561');


-- добавляем через SET
INSERT INTO users 
SET first_name = 'Iren',
	last_name = 'Sidorova',
	email = 'iren@mail.com',
	phone  = '89213541560';

-- получаем код создания таблицы users
SHOW CREATE TABLE users;
-- код создания таблицы users
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(145) NOT NULL,
  `last_name` varchar(145) NOT NULL,
  `email` varchar(145) NOT NULL,
  `phone` char(11) NOT NULL,
  `password_hash` char(65) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `phone` (`phone`),
  KEY `email_2` (`email`)
);

-- переключаемся к БД test2 и добавляем в неё таблицу users
USE test1;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(145) NOT NULL,
  `last_name` varchar(145) NOT NULL,
  `email` varchar(145) NOT NULL,
  `phone` char(11) NOT NULL,
  `password_hash` char(65) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
);
-- Добавляем данные в test1 
INSERT INTO users (first_name, last_name, email, phone)
VALUES ('Alina', 'Kobrina', 'alina@mail.com', '89210549561');

-- Переключаемся обратно к БД vk
USE vk;
-- Выполняем INSERT ... SELECT 
INSERT users (first_name, last_name, email, phone)
SELECT first_name, last_name, email, phone FROM test1.users;

SELECT 'hello!';

SELECT 1+10;

-- выбираем все поля users

SELECT * FROM users;

-- выбираем только имена users

SELECT first_name FROM users;

-- выбираем только уникальные имена

SELECT DISTINCT first_name FROM users;


SELECT * FROM users WHERE last_name = 'Petrov';

SELECT * FROM users WHERE id <= 10;

SELECT * FROM users WHERE id BETWEEN 3 AND 7;

-- выбираем пользователей, у которых нет hash пароля 
SELECT * FROM users WHERE password_hash IS NULL;

-- выбираем пользователей, у которых есть hash пароля 

SELECT * FROM users WHERE password_hash IS NOT NULL;

-- выбираем четырех пользователей
SELECT * FROM users Limit 4;


-- выбираем четырех последних пользователей
SELECT * FROM users ORDER BY id DESC Limit 4;

-- выбираем четвертого пользователя (четвертый номер id по порядку)

SELECT * FROM users ORDER BY id LIMIT 1 OFFSET 3;

SELECT * FROM users ORDER BY id LIMIT 3,1;

-- очистим таблицы перед загрузкой данных
TRUNCATE TABLE messages;
TRUNCATE TABLE like_user;
TRUNCATE TABLE likes_media;
TRUNCATE TABLE likes_posts;
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE communities;
TRUNCATE TABLE communities_users;
TRUNCATE TABLE posts;
TRUNCATE TABLE communities_users;
TRUNCATE TABLE media_types;
TRUNCATE TABLE media;
TRUNCATE TABLE profiles;
TRUNCATE TABLE users;

ALTER TABLE profiles 
ADD `user_status` varchar(30) DEFAULT NULL;

SELECT COUNT(id) from users;




