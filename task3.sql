SELECT * FROM media_types;
-- заменим значения типов медиафайлов 
UPDATE media_types 
SET name = 'audio'
WHERE id = 1;
UPDATE media_types 
SET name = 'video'
WHERE id = 2;
UPDATE media_types 
SET name = 'image'
WHERE id = 3;
UPDATE media_types 
SET name = 'document'
WHERE id = 4;

-- удалим заявки в друзья самому себе
DELETE FROM friend_requests WHERE from_user_id = to_user_id;


