/* MVP */

/* Q1 */
/* a */

SELECT  e.first_name,
        e.last_name,
        t.name
FROM teams AS t LEFT JOIN employees AS e 
ON t.id = e.team_id;

/* b */

SELECT  e.first_name,
        e.last_name,
        t.name
FROM teams AS t LEFT JOIN employees AS e 
ON t.id = e.team_id
WHERE e.pension_enrol IS TRUE;

/* c */

SELECT  e.first_name,
        e.last_name,
        t.name
FROM teams AS t left JOIN employees AS e 
ON t.id = e.team_id
WHERE CAST(t.charge_cost AS NUMERIC) > 80;


/* Q2 */
/* a */

SELECT e.*,
        pd.local_account_no,
        pd.local_sort_code
FROM employees AS e LEFT JOIN pay_details AS pd 
ON e.id = pd.id;


/* b */
SELECT e.*,
        pd.local_account_no,
        pd.local_sort_code,
        t.name
FROM teams AS t RIGHT JOIN (employees AS e LEFT JOIN pay_details AS pd 
                            ON e.id = pd.id)
        ON t.id = e.team_id;
    
    
/* Q3 */
/* a */

SELECT e.id,
        t.name
FROM employees AS e INNER JOIN teams AS t 
        ON e.team_id = t.id;
    
/* b */  

SELECT count(e.id),
        t.name
FROM employees AS e INNER JOIN teams AS t 
        ON e.team_id = t.id
GROUP BY t."name" ;


/* c */
SELECT count(e.id) AS n_employees,
        t.name
FROM employees AS e INNER JOIN teams AS t 
        ON e.team_id = t.id
GROUP BY t."name" 
ORDER BY n_employees ASC;


/* Q4 */
/* a */

SELECT  t.id,
        t.name,
        count(e.id) AS n_employees
FROM employees AS e INNER JOIN teams AS t 
        ON e.team_id = t.id
GROUP BY t."name", t.id
ORDER BY t.id ASC;

/* b */
SELECT  t.id,
        t.name,
        count(e.id) AS n_employees,
        (count(e.id) * CAST(t.charge_cost AS numeric)) AS total_day_charge 
FROM employees AS e INNER JOIN teams AS t 
        ON e.team_id = t.id
GROUP BY t.id
ORDER BY t.id ASC;

/* c */

SELECT  t.id,
        t.name,
        count(e.id) AS n_employees,
        (count(e.id) * CAST(t.charge_cost AS numeric)) AS total_day_charge 
FROM employees AS e INNER JOIN teams AS t 
        ON e.team_id = t.id
GROUP BY t.id
HAVING (count(e.id) * CAST(t.charge_cost AS numeric)) > 5000
ORDER BY total_day_charge DESC;


/* Extension */
/* Q5 */

SELECT ec.employee_id  
FROM employees_committees AS ec
GROUP BY ec.employee_id
HAVING count(committee_id) > 1;


/* Q6 */
SELECT count(e.id)
FROM employees AS e left JOIN employees_committees AS ec
    ON e.id = ec.employee_id 
WHERE ec.employee_id IS NULL;






