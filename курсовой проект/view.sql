CREATE or replace VIEW view_activ_projects /* показывает аналитические данные проектов действующих в текущем году (можно использовать при построении отчетов)*/
AS
SELECT pj.id, pj.name, pj.description, s.shot_name AS sistem, sp.status_pj AS status, cp.full_name AS customer, tw.type_work, 
CONCAT(u.first_name, ' ', u.last_name) AS pm, d.shot_name AS department, pj.date_start, pj.date_finish, ca.num_contracts AS contract,
sc.status_ctr, pj.date_of_completion, pj.cost
FROM projects pj
	JOIN status_projects sp ON sp.id = pj.status_id
	JOIN departments d ON d.id = pj.department_id
	JOIN status_contracts sc ON sc.id = pj.status_id
	JOIN contracts ca ON ca.id = pj.contract_id
    JOIN counterparties cp ON cp.id = pj.customer_id
    JOIN sistems s ON s.id = pj.sistem_id
    JOIN type_works tw ON tw.id = pj.type_works_id
    JOIN users u ON u.id = pj.pm   
WHERE (YEAR(pj.date_start) <= YEAR(now())) AND (YEAR(pj.date_finish) >= YEAR(now()));

CREATE or replace VIEW view_task_expenses /* трудозатраты задач в денежном выражении */
AS
SELECT t.id AS id, t.task AS task, t.user_id AS user_id, t.project_id AS project_id, t.hours AS hours, g.cost_hour, t.hours*g.cost_hour AS expenses
FROM tasks t
    JOIN users u ON u.id = t.user_id
	JOIN grades g ON g.grade = u.grade;
    
CREATE or replace VIEW view_priject_profit /* рентабельность проектов */
AS
SELECT pj.id, pj.name, cp.full_name AS customer, tw.type_work, 
CONCAT(u.first_name, ' ', u.last_name) AS pm, pj.cost AS budget, SUM(vte.expenses) AS expenses_pj, round(pj.cost-SUM(vte.expenses),0) AS profit
FROM projects pj
	JOIN counterparties cp ON cp.id = pj.customer_id
    JOIN type_works tw ON tw.id = pj.type_works_id
    JOIN users u ON u.id = pj.pm  
    JOIN view_task_expenses vte ON vte.user_id = pj.id;
