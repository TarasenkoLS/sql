/*pm_db - база данных корпоративной системы управления проектами IT компании.
В данном представлении содержит мимнимальный набор таблиц(справочниов), 
позволяющих вести учет проектов и проектной деятельности Компании.
*/
USE pm_db;
CREATE TABLE counterparties 
(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    shot_name VARCHAR (50) UNIQUE NOT NULL,
    full_name VARCHAR (256),
	inn decimal(10,0) ZEROFILL DEFAULT NULL,
	kpp decimal(10,0) ZEROFILL DEFAULT NULL,
	customer tinyint(1) DEFAULT '0',
	contractor tinyint(1) DEFAULT '0',
    created_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY shot_name_ctrp (shot_name),
    KEY inn (inn),
    KEY kpp (kpp)
    );

CREATE TABLE sistems
(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    shot_name VARCHAR (50) UNIQUE NOT NULL,
    created_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY shot_name_sist (shot_name)
    );
    
CREATE TABLE grades
(
	grade INT UNSIGNED UNIQUE NOT NULL PRIMARY KEY,
    cost_hour FLOAT DEFAULT '0',
    created_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP 
    );

CREATE TABLE roles
(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `role` VARCHAR (80) UNIQUE NOT NULL,
    created_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

CREATE TABLE departments
(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    shot_name VARCHAR (50) UNIQUE NOT NULL,
    full_name VARCHAR (256),
    created_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );
    
CREATE TABLE type_works
(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    type_work VARCHAR (100) UNIQUE NOT NULL,
    code_type VARCHAR (50) UNIQUE NOT NULL,
    created_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );
    
    CREATE TABLE status_projects
(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    status_pj VARCHAR (50) UNIQUE NOT NULL,
    created_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );
    
	CREATE TABLE status_contracts
(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    status_ctr VARCHAR (50) UNIQUE NOT NULL,
    created_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );
    
CREATE TABLE users
(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	first_name VARCHAR (80) NOT NULL,
	last_name VARCHAR (80) NOT NULL,
	patronymic VARCHAR (80) NOT NULL,
	birthday date DEFAULT NULL,
	gender enum('м','ж','') NOT NULL DEFAULT '',
	role_id INT UNSIGNED NOT NULL,
	department_id INT UNSIGNED NOT NULL,
	grade INT UNSIGNED UNIQUE NOT NULL,
    created_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY user_ln (last_name),
    KEY user_fn (first_name),
	KEY user_ptr (patronymic),
    CONSTRAINT `fk_user_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`),
    CONSTRAINT `fk_user_department` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`),
    CONSTRAINT `fk_user_grade` FOREIGN KEY (`grade`) REFERENCES `grades` (`grade`)
    );
    
CREATE TABLE contracts
(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name text NOT NULL,
 	status_id INT UNSIGNED NOT NULL, 
	num_contracts VARCHAR (150),
	date_of_signing date,
	cost FLOAT,
	payment INT UNSIGNED DEFAULT 40,
    created_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY num_contracts (num_contracts),
    CONSTRAINT `fk_contract_status` FOREIGN KEY (`status_id`) REFERENCES `status_contracts` (`id`)
    );
    
CREATE TABLE projects
(    
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR (250) NOT NULL,
	status_id INT UNSIGNED NOT NULL, 
	description text NOT NULL,
	sistem_id INT UNSIGNED NOT NULL,
	customer_id INT UNSIGNED NOT NULL,
	type_works_id INT UNSIGNED NOT NULL,
	pm INT UNSIGNED NOT NULL,
	department_id INT UNSIGNED NOT NULL,
	date_start date,
	date_finish date,
	contract_id INT UNSIGNED,
	date_of_completion date,
	cost FLOAT,
    created_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY project_name (name),
    KEY fk_project_sistems (sistems_id),
    KEY fk_project_customer (customer_id),
    KEY fk_project_pm (pm),
    KEY fk_project_department (department_id),
    KEY fk_project_contract (contract_id),
    CONSTRAINT `fk_project_status` FOREIGN KEY (`status_id`) REFERENCES `status_projects` (`id`),
    CONSTRAINT `fk_project_sistems` FOREIGN KEY (`sistem_id`) REFERENCES `sistems` (`id`),
    CONSTRAINT `fk_project_customer` FOREIGN KEY (`customer_id`) REFERENCES `counterparties` (`id`),
    CONSTRAINT `fk_project_type_works` FOREIGN KEY (`type_works_id`) REFERENCES `type_works` (`id`),
    CONSTRAINT `fk_project_pm` FOREIGN KEY (`pm`) REFERENCES `users` (`id`),
    CONSTRAINT `fk_project_department` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`),
    CONSTRAINT `fk_project_contract` FOREIGN KEY (`contract_id`) REFERENCES `contracts` (`id`)
);

CREATE TABLE tasks
(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    task text NOT NULL,
	date_start date,
	date_finish date,
    task_completed tinyint(1) DEFAULT '0',
	hours FLOAT,
	user_id INT UNSIGNED NOT NULL,
	project_id INT UNSIGNED NOT NULL,
    created_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY fk_task_user (user_id),
    KEY fk_task_project (project_id),
    CONSTRAINT `fk_task_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
    CONSTRAINT `fk_task_project` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`)
	);

    