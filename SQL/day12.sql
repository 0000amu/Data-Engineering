create table departmentti (
  depa_id   int primary key,
  depa_name varchar(40) 


);

insert into departmentti values 
(10,'sales'),
(20,'it'),
(30,'marketing'),
(40,'data')

CREATE TABLE emz (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(255),
    salary DECIMAL(10, 2),
    depa_id INT,
    FOREIGN KEY (depa_id) REFERENCES departmentti(depa_id)
);

INSERT INTO emz VALUES
(1, 'Sunil', 60000, 10),
(2, 'Tushar', 75000, 20),
(3, 'Anil', 80000, 20),
(4, 'Priya', 55000, 10),
(5, 'Rahul', 90000, 30),
(6, 'Meera', 70000, 20),
(7, 'Vikram', 85000, 30);



select * from emz
select * from departmentti




-- Write a query to display employee those are getting more than 800000 annual salaries.
with annualsalacte as(
     select employee_name, salary,salary * 12 as annual_sala
     from emz
)
select * from annualsalacte
where  annual_sala > 800000;

-- find employee earning more than depa avg salary 

with avg_sala_cte as(
select 
depa_id ,
avg(salary) as avg_sal 
from emz
group by depa_id 
)
select 
z.employee_id,
z.employee_name,
 a.avg_sal,
 z.salary
 from emz z
join avg_sala_cte a 
on z.depa_id = a.depa_id 
where z.salary > a.avg_sal;

-- Calculate both the total salary and the average salary of employees.

with avgcte as(
	
    select avg(salary) as avgsala from emz

),
totalcte as(
 
 select sum(salary)as totalsala from emz

)
select e.*,tc.*,ac.*
from emz e
cross join totalcte tc
cross join avgcte ac

-- Display employees getting minimum annual salary.
 
with annualcte as(
    select salary,salary * 12 as annual_sal from emz
 ),
mincte as(
select min(annual_sal) as min_sal from annualcte 
)
select * from annualcte c1
inner join mincte c2
on c1.annual_sal = c2.min_sal;

----- recursion 

with recursive counter as(
    select 1 as count 
     UNION ALL
    SELECT count + 1 AS count
    FROM counter
    WHERE count < 10
) select * from counter ;


CREATE TABLE employees (
    employee_id int,
    employee_name VARCHAR(100),
    manager_id INT
);

INSERT INTO employees (employee_id, employee_name, manager_id) VALUES
(1, 'CEO', NULL),
(2, 'Manager1', 1),
(3, 'Employee1', 2),
(4, 'Manager2', 1),
(5, 'Employee2', 2),
(6, 'Employee4', 4),
(7, 'Employee3', 4);

SELECT * FROM employees;

with recursive emphicte as(
    select employee_id, employee_name, manager_id , 0 as level 
    from employees
    where manager_id is null
    union 
	select e.employee_id, e.employee_name, e.manager_id , eh.level + 1 
    from employees e
	INNER JOIN emphicte eh ON e.manager_id = eh.employee_id

)
SELECT employee_id, employee_name, level
FROM emphicte
ORDER BY level;



