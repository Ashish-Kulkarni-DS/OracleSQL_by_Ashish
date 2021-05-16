-- to describe a table
DESC employees;

DESC departments;

-- select statement
SELECT *
FROM employees;

SELECT *
FROM employees
FETCH NEXT 5 ROWS ONLY;

SELECT *
FROM employees
OFFSET 10 ROWS
FETCH NEXT 5 ROWS ONLY;

SELECT first_name, last_name, job_id, salary AS sal
FROM employees;

SELECT first_name, last_name, job_id, salary AS monthly_salary, salary*12 AS annual_salary
FROM employees;

SELECT *
FROM departments;

SELECT *
FROM jobs;

-- select statement alongwith distinct and count clause
SELECT COUNT(*)
FROM jobs;

SELECT COUNT(DISTINCT job_title)
FROM jobs;

-- where clause
-- retrieve all employees in department 90
SELECT employee_id, first_name, last_name, email, department_id
FROM employees
WHERE department_id = 90;

-- retrieve the info of employee having last name as 'Whalen'
SELECT employee_id, first_name, email
FROM employees
WHERE last_name = 'Whalen';

------- comparison operators using where clause ----------
-- employees having salary less than or equal to 3000
SELECT first_name, last_name, salary
FROM employees
WHERE salary <= 3000;

-- salary between 2500 and 3500
SELECT first_name, last_name, salary
FROM employees
WHERE salary BETWEEN 2500 AND 3500;

SELECT last_name 
FROM employees
WHERE last_name BETWEEN 'King' AND 'Smith';

-------- IN condition --------
SELECT employee_id, first_name, last_name, salary--, manager_id
FROM employees
WHERE manager_id IN(100,101,201);

------- LIKE condition ---------
SELECT first_name, last_name
FROM employees
WHERE first_name LIKE 'S%';

SELECT first_name, last_name, hire_date
FROM  employees
WHERE hire_date LIKE '%03';

SELECT first_name, last_name
FROM employees
WHERE last_name LIKE '_o%';

------- NULL conditions --------
SELECT first_name, last_name, manager_id
FROM employees
WHERE manager_id IS NULL;

SELECT first_name, last_name
FROM employees
WHERE commission_pct IS NULL;

------- LOGICAL conditions --------
-- AND
SELECT first_name, last_name, job_id
FROM employees
WHERE salary >= 10000
AND job_id LIKE '%MAN%';

-- OR
SELECT first_name, last_name, job_id, salary
FROM employees
WHERE salary >= 10000
OR job_id LIKE '%MAN%';

-- NOT IN
SELECT first_name, last_name, job_id
FROM employees
WHERE job_id NOT IN ('IT_PROG','PU_CLERK','ST_MAN');

-- ORDER BY clause
-- ASC: for ascending order, default
-- DESC: for descending order
SELECT first_name, last_name, hire_date, employee_id
FROM employees
ORDER BY hire_date;

SELECT employee_id, first_name, last_name, salary*12 AS annual_sal
FROM employees
ORDER BY annual_sal;

SELECT first_name, last_name, department_id, salary
FROM employees
ORDER BY department_id, salary DESC;

--------- SUBSTITUTION VARIABLES ------------
SELECT first_name, last_name, job_id
FROM employees
WHERE job_id = '&job_title';

-- multiple substitutions
SELECT employee_id, first_name, hire_date, &column_name   -- salary
FROM employees
WHERE &condition                                          -- salary > 15000
ORDER BY &order_columns;                                  -- last_name

-- to reuse the same variable without prompting the user
SELECT first_name, last_name, &&column_name               -- job_id
FROM employees
ORDER BY &column_name;

-- DEFINE AND UNDEFINE functions
DEFINE emp_num = 200;

SELECT first_name, last_name, employee_id
FROM employees
WHERE employee_id = &emp_num;

UNDEFINE emp_num;

-- VERIFY command
SET VERIFY ON
SELECT first_name, last_name, salary, department_id
FROM employees
WHERE employee_id = &emp_num;

-------- CASE MANIPULATION FUNCTION -----------
SELECT 'The job_id for ' || UPPER(last_name) || ' is ' || LOWER(job_id) AS EMPLOYEE_DETAILS
FROM employees;
-- or
SELECT 'The job_id for ' || INITCAP(last_name) || ' is ' || LOWER(job_id) AS EMPLOYEE_DETAILS
FROM employees;

SELECT employee_id, last_name, department_id
FROM employees
WHERE last_name = 'higgins';                  -- this won't work as H is capital. To make it general, lower the case or upper the case.

SELECT employee_id, last_name, department_id
FROM employees
WHERE LOWER(last_name) = 'higgins'; 
-- or
SELECT employee_id, last_name, department_id
FROM employees
WHERE INITCAP(last_name) = 'Higgins';

--------- CAHARCTER MANIPULATION FUNCTIONS -----------
SELECT CONCAT('Hello ', 'World' )
FROM dual;

SELECT SUBSTR('HelloWorld',1,5)
FROM dual;

SELECT LENGTH('HelloWorld')
FROM dual;
--
SELECT first_name, LENGTH(first_name) AS name_characters
FROM employees;

SELECT INSTR('HelloWorld', 'W')
FROM dual;

SELECT LPAD(salary, 10, '*')
FROM employees;

SELECT RPAD(salary, 10, '*')
FROM employees;

SELECT REPLACE('JACK and JUE', 'J', 'BL')
FROM dual;

SELECT TRIM('H' FROM 'HelloWorld')              -- you cannot remove more than one characters using TRIM
FROM dual;

SELECT employee_id, first_name || ' ' || last_name AS NAME, LENGTH(last_name), INSTR(last_name,'a') AS "Contains'a'?"
FROM employees
WHERE SUBSTR(last_name, -1, 1) = 'n';

SELECT employee_id, first_name || ' ' || last_name AS NAME, LENGTH(last_name), job_id, INSTR(last_name,'a') AS "Contains'a'?"
FROM employees
WHERE SUBSTR(job_id, 4) = 'REP';

------------ NUMBER FUNCTIONS --------------
SELECT ROUND(92.658, 2)
FROM dual;

SELECT TRUNC(92.658, 2)
FROM dual;

SELECT MOD(1600, 300)     -- returns the remainder of 1600 divided by 300
FROM dual;

SELECT ROUND(51.85), TRUNC(51.85), MOD(1500,300)
FROM dual;

SELECT first_name, employee_id, salary, MOD(salary, 5000)
FROM employees
WHERE job_id = 'SA_REP';

---------- WORKING WITH DATES ------------
SELECT SYSDATE
FROM dual;

SELECT MAX(hire_date), MIN(hire_date)
FROM employees;

SELECT first_name, hire_date
FROM employees
WHERE hire_date < '01-Feb-06';

SELECT first_name, hire_date
FROM employees
WHERE hire_date BETWEEN '01-Feb-02' AND '1-Feb-06';

-------------- ARITHMETIC WITH DATES ---------------
SELECT first_name, last_name, (SYSDATE-hire_date)/7 AS weeks
FROM employees
WHERE department_id = 90;

-------------- DATE FUNCTIONS ----------------
SELECT MONTHS_BETWEEN('01-SEP-2022', '05-JAN-2021')
FROM dual;

SELECT ROUND(MONTHS_BETWEEN('01-SEP-2022', '05-JAN-2021'))
FROM dual;

SELECT TRUNC(MONTHS_BETWEEN('01-SEP-2022', '05-JAN-2021'),2)
FROM dual;

SELECT ADD_MONTHS('05-MAY-2021', 7)
FROM dual;

SELECT NEXT_DAY('05-MAY-2021','FRIDAY')
FROM dual;

SELECT LAST_DAY('05-MAY-2021')
FROM dual;

SELECT employee_id, hire_date, MONTHS_BETWEEN(SYSDATE, hire_date) AS tenure,
       ADD_MONTHS(hire_date, 6) AS review, NEXT_DAY(hire_date, 'FRIDAY'), LAST_DAY(hire_date)
FROM employees
WHERE MONTHS_BETWEEN(SYSDATE, hire_date) < 200;

SELECT ROUND(SYSDATE, 'MONTH')
FROM dual;

SELECT ROUND(SYSDATE, 'YEAR')
FROM dual;

SELECT TRUNC(SYSDATE, 'MONTH')
FROM dual;

SELECT TRUNC(SYSDATE, 'YEAR')
FROM dual;

--------- DATA CONVERSION ----------
-- TO_CHAR function with Date -- TO_CHAR(date, 'format_model')
SELECT employee_id, hire_date, TO_CHAR(hire_date, 'MM/YYYY') AS month_hired    
FROM employees;

SELECT employee_id, hire_date, TO_CHAR(hire_date, 'Month/YY') AS month_hired
FROM employees;

SELECT employee_id, hire_date, TO_CHAR(hire_date, 'Month/Year') AS month_hired
FROM employees;

-- TO_CHAR function with Number -- TO_CHAR(number, 'format_model')
SELECT  employee_id, salary, TO_CHAR(salary, '$99,999.0') sal_in_dollars
FROM employees;

-- TO_NUMBER(char[, 'format_model'])

-- TO_DATE(char[, 'format_model'])

----------- NESTING FUNCTIONS -------------
SELECT employee_id, first_name, last_name,
       UPPER(CONCAT(SUBSTR(last_name, 1,8), '_US')) AS Posting
FROM employees;

----------- GENERAL FUNCTIONS -------------
SELECT *
FROM employees;

-- NVL(expr1, expr2)
-- Converts a null value to an actual value
SELECT first_name, salary, NVL(commission_pct, 0),
       (salary*12) + (salary*12*NVL(commission_pct, 0)) AS AN_SAL
FROM employees;

-- NVL2(expr1, expr2, expr3)
-- if expr1 is not null, then NVL2 returns expr2. If expr1 is null, then NVL2 returns expr3
SELECT first_name, last_name, commission_pct, NVL2(commission_pct, 'SAL+COM', 'SAL') AS income
FROM employees;

-- NULLIF(expr1, expr2)
-- compares two expressions and returns null if they are equal; returns the first expression if they are not equal
SELECT first_name, LENGTH(first_name) AS expr1,
       last_name, LENGTH(last_name) AS expr2,
       NULLIF(LENGTH(first_name), LENGTH(last_name)) AS result
FROM employees;

-- COALESCE(expr1, expr2,..., exprn)
-- returns the first non-null expression in the expression list
SELECT first_name, last_name, manager_id, commission_pct,
       COALESCE(manager_id, commission_pct, -1)
FROM employees;

------------ CONDITIONAL STATEMENTS (IF-THEN-ELSE)---------------
-- There are two methods by which we can perform conditional operations
-- 1. CASE
-- 2. DECODE

-- 1. CASE 
SELECT employee_id, first_name, job_id, salary,
       CASE job_id WHEN 'IT_PROG' THEN 1.10*salary
                   WHEN 'ST_CLERK' THEN 1.15*salary
                   WHEN 'SA_REP' THEN 1.20*salary
       ELSE salary END AS revised_salary
FROM employees;

SELECT employee_id, first_name,
       CASE WHEN salary < 5000 THEN 'low'
            WHEN salary < 10000 THEN 'medium'
            WHEN salary < 20000 THEN 'good'
       ELSE 'excellent' END AS qualified_salary
FROM employees;

-- 2. DECODE
SELECT employee_id, first_name, job_id, salary,
       DECODE (job_id, 'IT_PROG', 1.10*salary,
                       'ST_CLERK', 1.15*salary,
                       'SA_REP', 1.20*salary,
       salary)
       revised_salary
FROM employees;

SELECT employee_id, first_name,
       DECODE (TRUNC(salary/5000, 0), 
                       1 , 'low',
                       2 , 'medium',
                       4 , 'good',
                         , 'excellent') qualified_salary
FROM employees;                                             -- it is a wrong statement but good for understanding

------------ AGGREGATE DATA USING GROUP FUNCTIONS --------------
-- AVG, COUNT, MIN, MAX, STDDEV, SUM, VARIANCE
SELECT ROUND(AVG(salary),2), MIN(salary), MAX(salary), SUM(salary)
FROM employees;

SELECT MIN(hire_date), MAX(hire_date)
FROM employees;

SELECT ROUND(AVG(salary),2), MIN(salary), MAX(salary), SUM(salary)
FROM employees
WHERE department_id = 90;

SELECT NVL(department_id,0), ROUND(AVG(salary),2), MIN(salary), MAX(salary), SUM(salary)
FROM employees
GROUP BY department_id;

-- COUNT function
SELECT COUNT(*)
FROM employees
WHERE department_id = 80;

SELECT COUNT(commission_pct)
FROM employees
WHERE department_id = 80;

SELECT COUNT(DISTINCT commission_pct)
FROM employees
WHERE department_id = 80;

-- DISTINCT clause
SELECT COUNT(DISTINCT department_id)
FROM employees;

-- group functions and null values
SELECT ROUND(AVG(commission_pct),2)        -- this is ignoring the null values
FROM employees;

SELECT ROUND(AVG(NVL(commission_pct,0)),2)  -- this is considering null values i.e. 0
FROM employees;

-- GROUP BY clause
SELECT department_id , ROUND(AVG(salary),2)
FROM employees
GROUP BY department_id;

SELECT NVL(department_id,0) , ROUND(AVG(salary),2)
FROM employees
GROUP BY department_id
ORDER BY AVG(salary);

-- GROUP BY multiple columns
SELECT NVL(department_id,0), job_id, SUM(salary)
FROM employees
GROUP BY department_id, job_id;

SELECT NVL(department_id,0), COUNT(last_name)
FROM employees
GROUP BY department_id;

-- HAVING clause
SELECT department_id, MAX(salary)
FROM employees
GROUP BY department_id
HAVING MAX(salary) > 10000;

SELECT department_id, ROUND(AVG(salary),2)
FROM employees
GROUP BY department_id
HAVING MAX(salary) > 10000;

SELECT job_id, SUM(salary) AS payroll
FROM employees
WHERE job_id NOT LIKE '%REP%'
GROUP BY job_id
HAVING SUM(salary) > 13000
ORDER BY SUM(salary);

-- nesting GROUP functions
SELECT ROUND(MAX(AVG(salary)),2)
FROM employees
GROUP BY department_id;

----------- DISPLAYING DATA FROM MULTIPLE TABLES ------------
SELECT e.first_name, e.department_id, d.department_name
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id
AND e.department_id = 40;                 -- you can also use WHERE

SELECT e.first_name ||' '|| e. last_name || ' belongs to ' || d.department_name || ' department'
FROM employees e
INNER JOIN departments d
ON e.department_id =d.department_id;

SELECT e.first_name ||' '|| e. last_name || ' belongs to ' || d.department_name || ' department'
FROM employees e
INNER JOIN departments d
USING(department_id);

-- INNER JOIN on multiple tables
SELECT e.first_name||' '||e.last_name AS full_name, d.department_name
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id
INNER JOIN locations l
ON d.location_id = l.location_id
WHERE city = 'Seattle';

-- NATURAL JOIN
SELECT department_id, department_name, location_id, city
FROM departments
NATURAL JOIN locations;                             -- it automatically joinned two tables by location_id column

-- natural join with WHERE clause
SELECT department_id, department_name, location_id, city
FROM departments
NATURAL JOIN locations
WHERE department_id IN (20,50);

-- USING clause
-- If several columns have the same names but the data types do not match, the NATURAL JOIN clause can be modified with the USING clause
-- to specify the columns that should be used for an equijoin.
-- Use the USING clause to match only one column when more than one column matches
-- The NATURAL JOIN and USING clauses are mutually exclusive
SELECT l.city, d.department_name
FROM locations l
JOIN departments d
USING (location_id)
WHERE location_id = 1400;

SELECT l.city, d.department_name
FROM locations l
JOIN departments d
USING (location_id)
WHERE d.location_id = 1400;
-- error:- "column part of USING clause cannot have qualifier" (d.location_id = 1400) i.e. 'd.' shouldn't be there
-- same restrictions are also applied to NATURAL JOIN.
-- therefore, columns that have same name in both the tables must be used without any qualifiers.

SELECT e.employee_id, e.first_name, e.last_name, d.location_id, department_id
FROM employees e
JOIN departments d
USING (department_id);

SELECT e.employee_id, e.first_name, e.last_name, d.location_id, department_id
FROM employees e
JOIN departments d
USING (department_id)
WHERE department_id = 30;

-- creating JOIN with ON clause
SELECT e.employee_id, e.first_name, e.last_name, e.department_id, d.department_id, d.location_id
FROM employees e
JOIN departments d
ON e.department_id = d.department_id;

-- SELF JOIN
SELECT e.first_name, e.last_name AS emp, m.last_name AS mngr     --, e.employee_id, m.employee_id
FROM employees e
JOIN employees m
ON e.manager_id = m.manager_id;

SELECT e.first_name, e.last_name AS emp, m.last_name AS mngr
FROM employees e
JOIN employees m
ON e.manager_id = m.manager_id
AND e.manager_id = 149;

-- three way joins with ON clause
SELECT employee_id, city, department_name
FROM employees e
JOIN departments d
ON d.department_id = e.department_id
JOIN locations l
ON d.location_id = l.location_id;



-- NON-EQUIJOINS
SELECT e.first_name, e.last_name, e.salary, j.job_id
FROM employees e
JOIN jobs j
ON e.salary
BETWEEN j.min_salary AND j.max_salary;

-------- OUTER JOINS --------
-- LEFT OUTER JOIN
SELECT e.last_name, e.department_id, d.department_name
FROM employees e
LEFT OUTER JOIN departments d
ON e.department_id = d.department_id;

SELECT e.last_name, e.department_id, d.department_name
FROM employees e
RIGHT OUTER JOIN departments d
ON e.department_id = d.department_id;

SELECT e.last_name, e.department_id, d.department_name
FROM employees e
FULL OUTER JOIN departments d
ON e.department_id = d.department_id;

-- CROSS JOIN
SELECT first_name, department_name
FROM employees
CROSS JOIN departments;

-------- SUBQUERY ----------
SELECT last_name
FROM employees
WHERE salary > (SELECT salary
                FROM employees
                WHERE last_name = 'Abel');

-- Single row subqueries:- A single-row subquery is the one that returns one row from the inner SELECT statement
SELECT last_name, job_id, salary
FROM employees
WHERE job_id = (SELECT job_id
                FROM employees
                WHERE employee_id = 141)
AND salary > (SELECT salary
              FROM employees
              WHERE employee_id = 143);

-- GROUP functions with subqueries
SELECT last_name, job_id, salary
FROM employees
WHERE salary = (SELECT MIN(salary)
                FROM employees);


-- HAVING clause with subqueries
SELECT department_id, MIN(salary)
FROM employees
GROUP BY department_id
HAVING MIN(salary) > (SELECT MIN(salary)
                      FROM employees
                      WHERE department_id = 50);

-- Multiple-row subqueries
SELECT last_name, salary, department_id
FROM employees
WHERE salary IN (SELECT MIN(salary)
                 FROM employees
                 GROUP BY department_id);

SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary < ANY(SELECT salary
                   FROM employees
                   WHERE job_id = 'IT_PROG')
AND job_id <> 'IT_PROG';

SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary < ALL(SELECT salary
                   FROM employees
                   WHERE job_id = 'IT_PROG')
AND job_id <> 'IT_PROG';

------------ SET OPERATORS -------------
-- UNION:- All distinct rows are selected by either query.
-- UNION ALL:- All rows are selected by either query, including all duplicates.
-- INTERSECT:- All distinct rows selected by both queries.
-- MINUS:- All distinct rows that are selected by the first SELECT statement and not selected in the second SELECT statement.

-- the UNION operator returns results from both queries after eliminating duplicates.
SELECT *
FROM employees
UNION
SELECT *
FROM job_history;
-- above query will throw an error:- "query block has incorrect number of result columns".
-- this means, in both the select statement, you should have identical columns/same columns.

SELECT employee_id, job_id, department_id
FROM employees
UNION
SELECT employee_id, job_id, department_id
FROM job_history;

-- the UNION ALL operator returns results from both the queries, including all the duplicates.
SELECT employee_id, job_id, department_id
FROM employees
UNION ALL
SELECT employee_id, job_id, department_id
FROM job_history
ORDER BY employee_id;

-- the INTERSECT operator returns rows that are common to both queries. 
SELECT employee_id, job_id, department_id
FROM employees
INTERSECT
SELECT employee_id, job_id, department_id
FROM job_history;

-- the MINUS operator retirns the rows in the first query that are not present in second query.
SELECT employee_id, job_id
FROM employees
MINUS
SELECT employee_id, job_id
FROM job_history;

------------- DATA MANIPULATION LANGUAGE ---------------
-- INSERT statement
INSERT INTO departments (department_id, department_name, manager_id, location_id)
VALUES (70, 'Public Relations', 100, 1700);

-- create a script
INSERT INTO departments (department_id, department_name, location_id)
VALUES ('&department_id', '&department_name', '&location_id');

-- Copy rows from another table
INSERT INTO sales_reps(id, name, salary, commisssion_pct)
  SELECT employee_id, last_name, salary, commission_pct
  FROM employees
  WHERE job_id LIKE '%REP%';

-- Update statement --
-- to update a specific row or rows
UPDATE employees
SET department_id = 70
WHERE employee_id = 113;

-- to update all the rows
UPDATE copy_emp
SET department_id = 110;

-- Updating two columns with a subquery
UPDATE employees
SET job_id = (SELECT job_id
              FROM employees
              WHERE employee_id = 205),
    salary = (SELECT salary
              FROM employees
              WHERE employee_id = 205)
WHERE employee_id = 114;

-- Updating rows based on another table
UPDATE copy_emp
SET department_id = (SELECT department_id
                     FROM employees
                     WHERE employee_id = 100)
WHERE job_id = (SELECT job_id
                FROM employees
                WHERE employee_id = 200);

-- DELETE statement
-- to delete specific row or rows
DELETE FROM departments
WHERE department_name = 'Finance';

-- to delete all the rows
DELETE FROM copy_emp;

-- to delete rows based on another table
DELETE FROM employees
WHERE department_id = (SELECT department_id
                       FROM departments
                       WHERE department_name
                             LIKE '%Public%');

-- subquery in INSERT statement
INSERT INTO 
        (SELECT employee_id, last_name, email, hire_date, job_id, salary, department_id
         FROM employees
         WHERE department_id = 50)
VALUES(99999, 'TAYLOR', 'DTAYLOR', TO_DATE('07-JUN-99', 'DD-MON-YY'), 'ST_CLERK', 5000, 50);

-- TRUNCATE table
TRUNCATE TABLE copy_emp;

-- to commit the chnages
-- COMMIT;

-- to rollback the changes
-- ROLLBACK;

-- Rank and Dense Rank
SELECT *
FROM employees;

SELECT first_name, salary, 
FROM employees
ORDER BY salary DESC;

-- my requirement is the employee getting higher salary should be ranked high
SELECT first_name, salary, RANK() OVER (ORDER BY salary DESC) AS rank1
FROM employees;
-- rank function generates gaps. If you Neena and Lex salary, it is same and thats why same rank is given to them

-- if I cahnge to DESC to ASC then employees having lesser salary will be ranked high
SELECT first_name, salary, RANK() OVER (ORDER BY salary ASC) AS rank2
FROM employees;

-- Dense Rank
SELECT first_name, salary, RANK() OVER (ORDER BY salary DESC) AS rank1,
DENSE_RANK() OVER (ORDER BY salary DESC) AS denserank
FROM employees;
-- the difference is that the rank function generates gaps but dense rank function does not generate gaps

-- if I want to calculate rank and dense rank by departments
SELECT first_name, salary, department_id, 
RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rank1,
DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS denserank
FROM employees;































