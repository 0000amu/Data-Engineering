CREATE DATABASE sql_practice;
USE sql_practice;

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    age INT,
    city VARCHAR(50),
    joining_date DATE
);

INSERT INTO employees VALUES
(101, 'Rahul', 'IT', 75000, 25, 'Pune', '2023-01-10'),
(102, 'Priya', 'HR', 55000, 28, 'Mumbai', '2022-05-15'),
(103, 'Amit', 'IT', 65000, 24, 'Pune', '2023-07-20'),
(104, 'Sneha', 'Finance', 80000, 30, 'Mumbai', '2021-03-12'),
(105, 'Vikas', 'IT', 90000, 29, 'Bangalore', '2020-11-05'),
(106, 'Neha', 'HR', NULL, 26, 'Pune', '2024-01-18'),
(107, 'Rohan', 'Finance', 70000, 31, 'Mumbai', '2022-09-25'),
(108, 'Pooja', 'Sales', 60000, 27, 'Delhi', '2023-04-14'),
(109, 'Karan', 'Sales', 85000, 32, 'Pune', '2021-12-01'),
(110, 'Anjali', 'IT', 72000, 25, 'Mumbai', '2024-02-10'),
(111, 'Sagar', 'Finance', NULL, 29, 'Delhi', '2023-08-16'),
(112, 'Meena', 'HR', 50000, 27, 'Pune', '2022-06-22'),
(113, 'Akash', 'Sales', 65000, 26, NULL, '2024-03-05'),
(114, 'Nikhil', 'IT', 95000, 33, 'Bangalore', '2019-10-11'),
(115, 'Isha', 'Finance', 75000, 28, 'Pune', '2023-05-19'),
(116, 'Varun', 'Sales', 55000, 30, 'Mumbai', '2022-02-28'),
(117, 'Riya', 'HR', 60000, 24, 'Delhi', '2024-04-10'),
(118, 'Manish', 'IT', 68000, 27, 'Pune', '2023-09-09'),
(119, 'Komal', 'Finance', 82000, 26, 'Mumbai', '2021-07-17'),
(120, 'Deepak', 'Sales', NULL, 29, 'Pune', '2023-11-21');

SELECT * FROM EMPLOYEES;
SELECT EMP_NAME ,DEPARTMENT,SALARY FROM EMPLOYEES
SELECT EMP_NAME , CITY FROM EMPLOYEES

/*Q4. Find employees whose salary is greater than 70000.

Q5. Find employees who work in the IT department.

Q6. Find employees whose age is greater than 28.

Q7. Find employees from Pune.

Q8. Find IT employees whose salary is greater than 70000.*/

SELECT * FROM EMPLOYEES
WHERE SALARY > 70000

SELECT * FROM EMPLOYEES
WHERE DEPARTMENT ='IT'

SELECT * FROM EMPLOYEES
WHERE AGE > 28

SELECT * FROM EMPLOYEES
WHERE CITY = 'PUNE'

SELECT * FROM EMPLOYEES
WHERE DEPARTMENT = 'IT'
AND SALARY > 70000

/*DISTINCT

Q9. Display all unique departments.

Q10. Display all unique cities.

Q11. Display unique combinations of department and city.*/
SELECT DISTINCT(DEPARTMENT)
FROM EMPLOYEES

SELECT DISTINCT DEPARTMENT,CITY
FROM EMPLOYEES

/*ORDER BY

Q12. Display all employees ordered by salary from highest to lowest.

Q13. Display all employees ordered by salary from lowest to highest.

Q14. Display employees ordered by age from highest to lowest.

Q15. Display IT employees ordered by salary descending*/

SELECT * FROM EMPLOYEES 
ORDER BY SALARY DESC

/*LIMIT
Q16. Find the highest-paid employee.
Q17. Find the top 3 highest-paid employees.
Q18. Find the 2 lowest-paid employees.
Q19. Find the top 5 employees based on salary.*/

SELECT * FROM EMPLOYEES
ORDER BY SALARY DESC LIMIT 1

SELECT * FROM EMPLOYEES
WHERE SALARY > (SELECT  MIN(SALARY)
FROM EMPLOYEES)LIMIT 1

SELECT 
EMP_NAME AS "EMPLOYEE NAME",
SALARY AS "MONTHLY NAME" 
FROM EMPLOYEES

SELECT * FROM EMPLOYEES
WHERE CITY IS NULL

SELECT * FROM EMPLOYEES
WHERE CITY IS NOT NULL

SELECT *,COALESCE(SALARY ,"NA" )
FROM EMPLOYEES

SELECT *,
CASE 
	WHEN SALARY >= 80000 THEN "HIGH"
   WHEN SALARY >= 60000 THEN "MEDIUM" 
    WHEN SALARY < 60000 THEN "LOW"
END AS "CATEGORY"
FROM EMPLOYEES

SELECT COUNT(*) FROM EMPLOYEES
SELECT MIN(SALARY) FROM EMPLOYEES

SELECT COUNT(*)FROM EMPLOYEES
WHERE SALARY IS NOT NULL

SELECT COUNT(*)FROM EMPLOYEES
WHERE DEPARTMENT ='IT'

SELECT DEPARTMENT , SUM(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT

SELECT DEPARTMENT , MAX(SALARY),MIN(SALARY),AVG(SALARY),COUNT(*)AS "EMP_COUNT"
FROM EMPLOYEES
GROUP BY DEPARTMENT

SELECT DEPARTMENT , COUNT(*)AS "EMP_COUNT"
FROM EMPLOYEES
GROUP BY DEPARTMENT
HAVING COUNT(*)>3

SELECT DEPARTMENT , AVG(SALARY)AS "EMP_COUNT"
FROM EMPLOYEES
GROUP BY DEPARTMENT
HAVING AVG(SALARY)>70000

SELECT * FROM EMPLOYEES
ORDER BY SALARY DESC LIMIT 3

SELECT emp_name,
department,
COALESCE(salary,'Not Available')
FROM EMPLOYEES

SELECT emp_name,
department,
COALESCE(salary,'Not Available'),
CASE
	WHEN SALARY>= 90000 THEN "EXECLENT"
    WHEN SALARY >= 75000 THEN "GOOD"
    WHEN SALARY >=60000 THEN  "Average"
	WHEN SALARY < 60000 THEN "Low"
	WHEN SALARY = NULL THEN  "Not Available"
END AS "SALA_CLAS"
FROM EMPLOYEES

DROP TABLE EMPLOYEES

