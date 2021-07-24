/* 
Зазача 5. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.
*/
-- соберем все активности пользователей: посты, лайки, медиа, сообщения, запросы дружбы и создание и участие в группах
SELECT user_id, COUNT(*) AS activ FROM posts GROUP BY user_id
	UNION
SELECT user_id, COUNT(*) AS activ FROM media GROUP BY user_id
	UNION 
SELECT user_id, COUNT(*) AS activ FROM posts_likes GROUP BY user_id
	UNION
SELECT from_user_id, COUNT(*) AS activ FROM messages GROUP BY from_user_id
	UNION
SELECT from_user_id, COUNT(*) AS activ FROM friend_requests GROUP BY from_user_id
	UNION
SELECT admin_id, COUNT(*) AS activ FROM communities GROUP BY admin_id
	UNION
SELECT user_id, COUNT(*) AS activ FROM communities_users GROUP BY user_id;

SELECT id, 
	CONCAT(first_name, ' ', last_name) AS name, 
	(SELECT sum(sum_act) FROM (SELECT sum(activity) as sum_act, user_id
		FROM (SELECT user_id, COUNT(*) AS activity FROM posts GROUP BY user_id
			UNION
		SELECT user_id, COUNT(*) AS activity FROM media GROUP BY user_id
			UNION 
		SELECT user_id, COUNT(*) AS activity FROM posts_likes GROUP BY user_id
			UNION
		SELECT from_user_id AS user_id, COUNT(*) AS activity FROM messages GROUP BY from_user_id
			UNION
		SELECT from_user_id AS user_id, COUNT(*) AS activity FROM friend_requests GROUP BY from_user_id
			UNION
		SELECT admin_id AS user_id, COUNT(*) AS activity FROM communities GROUP BY admin_id
			UNION
		SELECT user_id, COUNT(*) AS activity FROM communities_users GROUP BY user_id) as qt GROUP BY user_id) as qqt WHERE user_id =users.id) AS activityes
FROM users
ORDER BY activityes
LIMIT 10;

