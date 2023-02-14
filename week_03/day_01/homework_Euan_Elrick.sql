/* MVP */
/* Q1 */

SELECT *
FROM employees 
WHERE department = 'Human Resources';

/* Q2 */

SELECT 
    first_name,
    last_name,
    country
FROM employees 
WHERE department = 'Legal';


/* Q3 */
SELECT COUNT(*) AS total_portugal_employees
FROM employees 
WHERE country = 'Portugal';


/* Q4 */
SELECT count(*) AS total_portugal_or_spain
FROM employees 
WHERE (country = 'Portugal' 
    OR country = 'Spain');
    

/* Q5 */
SELECT COUNT(*) AS total_missing_accounts
FROM pay_details
WHERE local_account_no IS NULL;



/* Q6 */
SELECT count(*) AS missing_iban_and_account_no
FROM pay_details 
WHERE (local_account_no IS NULL
AND iban IS NULL);
-- No pay details missing both iban number and local account number



/* Q7 */
SELECT 
    first_name,
    last_name
FROM employees 
ORDER BY last_name ASC 
NULLS LAST;


/* Q8 */
SELECT 
    first_name,
    last_name,
    country
FROM employees 
ORDER BY 
    country ASC NULLS LAST,
    last_name ASC NULLS LAST;


/* Q9 */
SELECT *
FROM employees
ORDER BY salary DESC NULLS LAST  
LIMIT 10;


/* Q10 */
SELECT 
    first_name,
    last_name,
    salary
FROM employees 
WHERE country = 'Hungary'
ORDER BY salary ASC NULLS LAST 
LIMIT 1;

/* Q11 */
SELECT count(*)
FROM employees 
WHERE first_name LIKE 'F%';


/* Q12 */
SELECT *
FROM employees 
WHERE email LIKE '%@yahoo%';


/* Q13 */

SELECT COUNT(*)
FROM employees 
WHERE ((country != 'France' and country != 'Germany')
        AND (pension_enrol = TRUE));
    
    
    
/* Q14 */
SELECT *
FROM employees 
WHERE (department = 'Engineering'
        AND fte_hours = 1)
ORDER BY salary DESC NULLS LAST 
LIMIT 1;


/* Q15 */
SELECT 
    first_name,
    last_name,
    fte_hours,
    salary,
    salary * fte_hours AS effective_yearly_salary
FROM employees;


/* Extension */
/* Q16 */


SELECT 
CONCAT(first_name, ' ', last_name, ' - ', department) AS badge_label
FROM employees;


/* Q17 */

SELECT 
CONCAT(first_name, ' ', last_name, ' - ', department, ' (joined ', 
EXTRACT(YEAR FROM start_date), ')') AS badge_label
FROM employees;






