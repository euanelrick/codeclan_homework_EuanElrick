/* MVP
 * Q1
 */

SELECT count(id) AS n_employees_no_salary_or_grade
FROM employees
WHERE (grade IS NULL) AND (salary IS NUll);

/*Q2*/

SELECT 
        department,
        concat(first_name, ' ', last_name) AS full_name
FROM employees
ORDER BY 
        department,
        last_name 
        NULLS LAST ;
            
/*Q3*/
    
SELECT *
FROM employees 
WHERE last_name ILIKE 'A%'
ORDER BY salary DESC NULLS LAST 
LIMIT 10;

/*Q4*/

SELECT 
        count(id) AS n_2003_employees,
        department
FROM employees 
WHERE extract(YEAR FROM start_date) = '2003'
GROUP BY department;

/* Q5 */

SELECT 
        department,
        fte_hours,
        count(id) AS n_employees_by_fte_and_department
FROM employees 
GROUP BY department, fte_hours 
ORDER BY department, fte_hours NULLS last;

/* Q6 */
SELECT 
        count(id) AS n_employees,
        pension_enrol
FROM employees
GROUP BY pension_enrol;


/* Q7 */

SELECT *
FROM employees 
WHERE (pension_enrol IS NULL OR pension_enrol IS FALSE)
        AND department = 'Accounting'
ORDER BY salary DESC NULLS LAST 
LIMIT 1;

/* Q8 */

SELECT 
        country ,
        count(id) AS n_employees,
        avg(salary) AS average_salary
FROM employees
GROUP BY country 
HAVING count(id) > 30
ORDER BY average_salary DESC;

/* Q9 */

SELECT 
        first_name,
        last_name,
        fte_hours,
        salary,
        (fte_hours * salary) AS effective_yearly_salary
FROM employees 
WHERE (fte_hours * salary) > 30000;

/* Q10 */

SELECT 
        e.*,
        t.name
FROM employees AS e INNER JOIN teams AS t 
        ON e.team_id = t.id 
WHERE (t."name" = 'Data Team 1')
        OR (t."name" = 'Data Team 2');
    
/* Q11 */

SELECT 
        e.first_name,
        e.last_name
FROM employees AS e FULL JOIN pay_details AS pd 
        ON e.pay_detail_id = pd.id
WHERE pd.local_tax_code IS NULL;

/* Q12 */
SELECT 
        e.first_name,
        e.last_name,
        (((48 * 35 * CAST(t.charge_cost AS numeric)) - e.salary) * e.fte_hours)
        AS expected_profit
FROM employees AS e FULL JOIN teams AS t 
        ON e.team_id = t.id;
    
/* Q13 */

SELECT 
        fte_hours
FROM employees 
GROUP BY fte_hours 
ORDER BY count(id) ASC
LIMIT 1;

SELECT 
        first_name,
        last_name,
        salary
FROM 
        employees 
WHERE 
        (country = 'Japan')
        AND (fte_hours = (SELECT 
                                fte_hours
                            FROM 
                                employees 
                            GROUP BY 
                                fte_hours 
                            ORDER BY 
                                count(id) ASC
                            LIMIT 
                                1)
                            )
ORDER BY 
        salary NULLS LAST 
LIMIT 
        1;
    

/* Q14 */
    
SELECT 
        count(id) AS n_employees,
        department
FROM 
        employees
WHERE 
        first_name IS NULL 
GROUP BY 
        department
HAVING 
        count(id) >= 2
ORDER BY 
        n_employees DESC,
        department;
    

/* Q15 */

SELECT 
        first_name,
        count(id) AS n_employees_with_name
FROM 
        employees
WHERE 
        first_name IS NOT NULL 
GROUP BY 
        first_name 
ORDER BY
        count(id) DESC,
        first_name ;
    
/* Q16 */
    
SELECT
        count(id) AS grade_1_employees,
        department
FROM 
        employees
WHERE 
        grade = 1
GROUP BY 
        department;

SELECT 
        count(id) AS grade_0_N_employees,
        department
FROM
        employees
WHERE 
        grade = 0
        OR grade IS null
GROUP BY 
        department;
    
SELECT 
        g1.department,
        (CAST(g1.grade_1_employees AS NUMERIC) / 
        CAST(g0.grade_0_N_employees AS NUMERIC)) 
        AS proportion_of_grade_1_employees
FROM 
        (
SELECT
        count(id) AS grade_1_employees,
        department
FROM 
        employees
WHERE 
        grade = 1
GROUP BY 
        department) AS g1 
FULL JOIN 
        (
SELECT 
        count(id) AS grade_0_N_employees,
        department
FROM
        employees
WHERE 
        grade = 0
        OR grade IS null
GROUP BY 
        department) AS g0
ON g1.department = g0.department;



/* Extension */
/* Q1 */

--- biggest department
SELECT 
        department 
FROM 
        employees 
GROUP BY 
        department 
ORDER BY 
        count(id) DESC
LIMIT 
        1;
    
--- sal/fte table
    
    
SELECT
        department,
        avg(salary) AS average_department_salary,
        avg(fte_hours) AS average_fte_hours
FROM 
        employees 
GROUP BY
        department;

--- e
    
SELECT 
        e.id,
        e.first_name,
        e.last_name,
        e.department,
        e.salary,
        e.fte_hours,
        (e.salary / sal.average_department_salary) AS salary_ratio,
        (e.fte_hours / sal.average_fte_hours) AS fte_hrs_ratio
FROM 
        employees AS e 
INNER JOIN
(SELECT
        department,
        avg(salary) AS average_department_salary,
        avg(fte_hours) AS average_fte_hours
FROM 
        employees 
GROUP BY
        department) AS sal
ON 
        e.department = sal.department
WHERE 
        e.department = (SELECT 
        department 
FROM 
        employees 
GROUP BY 
        department 
ORDER BY 
        count(id) DESC
LIMIT 
        1);
    
    
    
/* Q2 */
    
SELECT 
        count(id) AS n_employees,
        COALESCE(CAST(pension_enrol AS varchar), 'Unknown')
FROM 
        employees
GROUP BY 
        pension_enrol;


/* Q3 */


SELECT 
        e.first_name,
        e.last_name,
        e.email,
        e.start_date
FROM
        (employees AS e full JOIN employees_committees AS ec 
        ON e.id = ec.employee_id)
        LEFT JOIN committees AS c 
        ON ec.committee_id = c.id
WHERE 
        c.name = 'Equality and Diversity'
ORDER BY 
        start_date ASC NULLS LAST;
    

/* Q4 */
    
SELECT 
    CASE 
        WHEN salary < 40000 THEN 'low'
        WHEN salary >= 40000 THEN 'high'
        ELSE 'none'
    END AS salary_class,
        count(DISTINCT(e.id)) AS n_committee_members
FROM
        (employees AS e right JOIN employees_committees AS ec 
        ON e.id = ec.employee_id)
        LEFT JOIN committees AS c 
        ON ec.committee_id = c.id
GROUP BY salary_class;

        
    


        
        
        

    

    
    














