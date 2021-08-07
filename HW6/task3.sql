/* 
Зазача 3.Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.
*/
-- выводим количество всех лайков всех пользователей
SELECT COUNT(*), user_id 
FROM vk_db_data.posts_likes 
WHERE like_type = 1
GROUP BY user_id;

-- выбираем 10 самых молодых пользователей
SELECT 
	user_id
FROM profiles
WHERE TIMESTAMPDIFF(YEAR, birthday, NOW())
		ORDER BY TIMESTAMPDIFF(YEAR, birthday, NOW())
		LIMIT 10;
        
-- объединяем в 1 запрос
SELECT COUNT(*) AS count_likes_all
FROM posts_likes 
WHERE like_type = 1 AND user_id IN (SELECT *FROM (SELECT user_id
		FROM profiles
		WHERE TIMESTAMPDIFF(YEAR, birthday, NOW())
		ORDER BY TIMESTAMPDIFF(YEAR, birthday, NOW())
		LIMIT 10) AS id);
