select * from empll
select * from department 

/* subquery using INSIDE FROM CLAUSE
Write a query to display employee 
those are getting more than 800000 annual salaries.

IN DATA TABLE NO ANNUAL SALRIES COLM IS PRESENT SO FIRST CREATE ONE 
SO HERE EMP TABLE IS CREATED USING EMPLL EXIXTING TbLE So first run inner query
1st derive subquery inner query then 2nd named that table as alias name then 
outer query derived hence we can solve in from 
 */
SELECT * FROM( 
SELECT SALARY,
        (SALARY * 12) AS ANNUAL_SALARY
FROM EMPLL) AS EMP 
WHERE EMP.ANNUAL_SALARY > 800000;

/*Employees with Annual Salary Category
Annual salary more than or equal to 800000 🡪 High
Annual salary less than 800000 🡪 Average

*/


select emp2.*,
       case
			when annual_salary > 800000 then 'high'
		    else 'low'
       end as category 
	   
from (
select salary ,
       (salary * 12) as annual_salary
from empll) as emp2 
having category = 'high'
================================================================================
select * from empll
select * from department 


/*subquey inside where 

======================================================= 
Find the names of employees who work in the IT department.
*/

select emp_name from empll where depa_id = (
select depa_id from department 
where depa_name = 'it')

-- Find employees whose salary is greater than Sunil's salary.
select * from empll where salary > ( 
select salary from empll where emp_name = 'sunil')

-- Find employees whose salary is less than Rahul's salary.
select * from empll where salary < (
select salary from empll where emp_name = 'rahul')

-- Find the employees who belong to the department named Sales. 
select * from empll where depa_id = (
select depa_id from department where depa_name = 'sale')

-- Find employees who work in the same department as Anil.

select emp_name from empll where depa_id = (
select depa_id from empll where emp_name = 'anil')

-- Find employees who do not work in the Marketing department.

select * from empll where depa_id not in (
select depa_id from department where depa_name = 'marketing')

-- Find employees whose salary is equal to the highest salary. 

select * from empll as emp1 
where 0 = (

      select count(distinct salary)
      from empll as emp2  
      where emp2.salary > emp1.salary 

);

-- Find employees whose salary is equal to the lowest salary. 6


select * from empll as emp1 
where 6 = (

		select count(distinct salary) from empll as emp2
        where emp2.salary > emp1.salary 

);


-- Find employees earning more than the average salary. 

select * from empll where salary > (
select avg(salary) from empll )

-- Find employees earning less than the average salary.

select * from empll where salary < (
select avg(salary) from empll )

===========================================================
-- Level 2 – Subqueries in FROM
===========================================================
-- Find the average salary of each department,
-- then display only departments with an average salary greater than 70,000.

select * from (select avg(salary) as avg from empll 
group by depa_id ) as emp1 
where emp1.avg > 70000 ;

-- Find the department having the highest average salary. 

select * from 
(select depa_id, avg(salary) as avg from empll 
group by depa_id) as emp1
order by emp1.avg desc limit 1

-- Find the department having the lowest average salary.
select * from 
(select depa_id, avg(salary) as avg from empll 
group by depa_id) as emp1
order by emp1.avg  limit 1

-- Find the maximum salary from each department, then display the overall highest among them.
select * from 
(select depa_id ,max(salary) as highest from empll 
group by depa_id) as emp1 
order by emp1.highest desc limit 1

-- Count the number of employees in each department using a derived table. 

select * from  
(select depa_id ,count(emp_id)as total_emp from empll 
group by depa_id)as emp1 

-- Find the department with the maximum number of employees.

 select * from (select depa_id , count(emp_id)as total from empll
 group by depa_id )as emp1
 order by emp1.total desc limit 1
 
 -- Find the department with the minimum number of employees. 
 
 
 select * from (
 select depa_id , count(emp_id) as total from empll
 group by depa_id ) as emp1 
 order by emp1.total limit 1
 
 -- Find the difference between the highest
 -- departmental average salary and the lowest departmental average salary. 
 
 select max(total_av)- min(total_av) as diff 
        from(
			select avg(salary)as total_av
			from empll 
			group by depa_id
        )as emp1;
-----------------------------------------------------------
-- Level 3 – Subqueries in SELECT (Correlated Subqueries)
-----------------------------------------------------------

-- Display every employee along with the total number of employees in their department.

select * from empll
select * from department 


select emp_id ,emp_name,
(
select count(*) from empll e2
where e2.depa_id = e1.depa_id 
)as total_emp
from empll as e1;

-- Display every employee along with the average salary of their department.
select    e1.emp_name,
    e1.salary,
(select avg(e2.salary) from empll e2
where e2.depa_id = e1.depa_id
)as avg_sala
from empll e1;

-- Display every employee along with the lowest salary in their department.]]

select e1.* ,e1.depa_id,
(select min(salary) from empll e2
where e2.depa_id = e1.depa_id
) as min_salary
from empll e1;

-- every employee along with the department name using a subquery in the SELECT clause.

select emp_name,
(select depa_name from department d2
where d2.depa_id = e1.depa_id 
)as depa_name  
from empll e1

-- Display every employee along with the number of employees earning more than them

select e1.emp_name ,
	   e1.salary,
(select count(*) from empll e2
where e2.salary > e1.salary
)as higher_sala
from empll e1

-----------------------------------------------------------------------------------
Level 4 – Subqueries in HAVING
------------------------------------------------------------------------------------
-- Find departments whose average salary is greater than the company's average salary. 

select depa_id,avg(salary)as avg_s from empll
group by depa_id
having avg_s > (select avg(salary) from empll);

-- Find departments whose maximum salary is greater than the company's average salary.


select depa_id,max(salary) from empll 
group by depa_id 
having max(salary) >
(select avg(salary) from empll)


-- Find departments having more employees than the average employees per department.

select depa_id , count(emp_id) from empll
group by depa_id
having count(emp_id) >
 (select avg(emp_count) from 
(select count(emp_id )as emp_count from empll
group by depa_id)as t)

 

