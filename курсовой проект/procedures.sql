/* 
Создаем таблицу logs типа Archive. При каждом создании записи в таблицах 
contracts и projects в таблицу logs помещается время и дата создания записи, название таблицы, 
идентификатор первичного ключа и содержимое поля name.
*/
USE pm_db;
DROP TABLE IF EXISTS `logs`;
CREATE TABLE `logs`(
create_at datetime DEFAULT NOW(), 
`table_name` varchar(65) NOT NULL, 
table_id INT UNSIGNED NOT NULL, 
name_value varchar(145)) engine=ARCHIVE;

-- ----------------- contracts --------------------------------

USE pm_db;
DROP TRIGGER IF EXISTS log_contracts_after_insert; 
DELIMITER ||

CREATE TRIGGER log_contracts_after_insert AFTER INSERT ON `contracts` 
FOR EACH ROW 
	BEGIN
		INSERT INTO pm_db.logs (create_at,`table_name`, table_id, name_value)
		VALUES (now(), 'pm_db.contracts', NEW.id, NEW.name);
	END ||
DELIMITER ;

-- --------------------- projects-------------------------------
DROP TRIGGER IF EXISTS log_projects_after_insert;
DELIMITER ||
CREATE TRIGGER log_projects_after_insert AFTER INSERT ON `projects` 
FOR EACH ROW
	BEGIN
		INSERT INTO shop.logs (create_at, `table_name`, table_id, name_value)
		VALUES (now(), 'pm_db.projects', new.id, new.name);
	END ||
DELIMITER ;

/* активные текущие задачи */
DROP PROCEDURE IF EXISTS sp_aсtive_task_user;

DELIMITER //

CREATE PROCEDURE sp_aсtive_task_user(IN for_user_id BIGINT UNSIGNED)
	BEGIN
		SELECT id, task, date_start, date_finish
		FROM `tasks`
		WHERE (date_start <= (now()) AND (now()) <= date_finish) 
				AND task_completed = 0 
                AND user_id = for_user_id;
	END //
	
DELIMITER ;

CALL sp_aсtive_task_user(125)
