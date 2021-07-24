-- Пусть задан некоторый пользователь. 
-- Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.
USE vk_db_data;
-- выбираем пользоваетелей с прочитанными прользоветелем с id = 5 сообщениями
SELECT from_user_id, COUNT(*)
FROM messages 
WHERE to_user_id = 5
	AND is_delivered = TRUE 
GROUP BY from_user_id;

-- выбираем друзей 
SELECT id, first_name, last_name
FROM users 
WHERE id IN (
		SELECT to_user_id FROM friend_requests WHERE from_user_id = 5 AND request_type = 
				(SELECT id FROM friend_requests_types WHERE name = 'accepted')
			UNION
		SELECT from_user_id FROM friend_requests WHERE to_user_id = 5 AND request_type = 
				(SELECT id FROM friend_requests_types WHERE name = 'accepted')
	);
-- объединяем запросы
SELECT from_user_id, COUNT(*)
FROM messages 
WHERE to_user_id = 5
	AND is_delivered = TRUE 
    AND from_user_id IN (
		SELECT to_user_id FROM friend_requests WHERE from_user_id = 5 AND request_type = 
				(SELECT id FROM friend_requests_types WHERE name = 'accepted')
			UNION
		SELECT from_user_id FROM friend_requests WHERE to_user_id = 5 AND request_type = 
				(SELECT id FROM friend_requests_types WHERE name = 'accepted')
	)
GROUP BY from_user_id;
-- выбираем пользователя с ниабольшим количесвом прочитанных сообщений
SELECT from_user_id
FROM messages 
WHERE to_user_id = 5
	AND is_delivered = TRUE 
    AND from_user_id IN (
		SELECT to_user_id FROM friend_requests WHERE from_user_id = 5 AND request_type = 
				(SELECT id FROM friend_requests_types WHERE name = 'accepted')
			UNION
		SELECT from_user_id FROM friend_requests WHERE to_user_id = 5 AND request_type = 
				(SELECT id FROM friend_requests_types WHERE name = 'accepted')
	)
GROUP BY from_user_id
ORDER BY COUNT(*) DESC
LIMIT 1;

-- выводим имя и фамилилию найденого пользователя
SELECT CONCAT(first_name, ' ', last_name) AS name
FROM users 
WHERE id = (
		SELECT from_user_id
		FROM messages 
		WHERE to_user_id = 5
			AND is_delivered = TRUE 
			AND from_user_id IN (
				SELECT to_user_id FROM friend_requests WHERE from_user_id = 5 AND request_type = 
						(SELECT id FROM friend_requests_types WHERE name = 'accepted')
					UNION
				SELECT from_user_id FROM friend_requests WHERE to_user_id = 5 AND request_type = 
						(SELECT id FROM friend_requests_types WHERE name = 'accepted')
			)	
		GROUP BY from_user_id
		ORDER BY COUNT(*) DESC
		LIMIT 1
		);

