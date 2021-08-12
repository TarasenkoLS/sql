USE pm_db;
/*
 * Посчитать количество проектов у каждого РП в разрезе статусов
*/
SELECT 
	(SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = pm) AS pm_name,
    (SELECT status_pj FROM status_projects WHERE id = status_id) AS status_pj, 
	COUNT(*) AS count_pj,
    round(SUM(cost),2) AS revenue
FROM projects
GROUP BY pm_name, status_pj 
ORDER BY pm_name;

/*
 * Посчитать количество проектов, закрепленных за каждым производственным подразделением.
*/
SELECT d.shot_name AS department, sp.status_pj AS status, COUNT(*) AS count_pj, round(SUM(pj.cost),2) AS revenue
FROM projects pj
	JOIN status_projects sp ON sp.id = pj.status_id
	JOIN departments d ON d.id = pj.department_id
GROUP BY department, status 
ORDER BY department;

/*
 * Показать количество подписанных доходных договоров и общую сумму стоимости работ в них.
*/
SELECT cp.full_name, round(SUM(pj.cost),2) AS revenue, COUNT(*) AS count_contracts 
FROM contracts ca
	JOIN status_contracts sc ON sc.id = ca.status_id
	JOIN projects pj ON ca.id = pj.contract_id
    JOIN counterparties cp ON cp.id = pj.customer_id
WHERE sc.status_ctr = "Подписан"
GROUP BY cp.full_name
ORDER BY revenue DESC;

/*
 * Показать назания 10 наиболее трудоемких проектов
*/
SELECT pj.name, sp.status_pj AS status, SUM(t.hours)
FROM projects pj
	JOIN status_projects sp ON sp.id = pj.status_id
	JOIN tasks t ON t.project_id = pj.id
GROUP BY pj.name
ORDER BY SUM(t.Hours) DESC
LIMIT 10;