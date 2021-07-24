/* 
Зазача 4.Определить кто больше поставил лайков (всего) - мужчины или женщины?.
*/
USE vk_db_data;
-- определяем пол пользователей
SELECT user_id, 
	CASE (gender)
		WHEN 'f' THEN 'female'
		WHEN 'm' THEN 'male'
		WHEN 'x' THEN 'not defined'
	END AS gender    
FROM profiles;

-- выводим количество всех лайков всех пользователей
SELECT 
	CASE (gender)
		WHEN 'f' THEN 'female'
		WHEN 'm' THEN 'male'
		WHEN 'x' THEN 'not defined'
	END AS gender,
		(SELECT COUNT(*)
		FROM posts_likes 
		WHERE user_id = profiles.user_id AND like_type = 1
		GROUP BY user_id) AS sum_likes	
FROM profiles;

-- ;
SELECT gender,
SUM(sum_likes)
FROM (SELECT 
	CASE (gender)
		WHEN 'f' THEN 'female'
		WHEN 'm' THEN 'male'
		WHEN 'x' THEN 'not defined'
	END AS gender,
		(SELECT COUNT(*)
		FROM posts_likes 
		WHERE user_id = profiles.user_id AND like_type = 1
		GROUP BY user_id) AS sum_likes	
FROM profiles) as t
WHERE gender != 'not defined'
GROUP BY gender
ORDER BY SUM(sum_likes) DESC
LIMIT 1;
        
