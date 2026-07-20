CREATE TABLE kupch (
    depa_id INT PRIMARY KEY,
    depa_name VARCHAR(30)
);

INSERT INTO kupch VALUES
(10,'HR'),
(20,'IT'),
(30,'Finance'),
(40,'Sales');

CREATE TABLE pora (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(40),
    salary INT,
    hire_date DATE,
    depa_id INT,
    email VARCHAR(50) UNIQUE,
    FOREIGN KEY(depa_id) REFERENCES kupch(depa_id)
);

INSERT INTO pora VALUES
(1,'Amit',50000,'2022-01-10',10,'amit@gmail.com'),
(2,'Priya',80000,'2021-05-20',20,'priya@gmail.com'),
(3,'Rahul',75000,'2023-02-15',20,'rahul@gmail.com'),
(4,'Sneha',65000,'2020-08-18',30,'sneha@gmail.com'),
(5,'Vikas',90000,'2019-12-01',40,'vikas@gmail.com'),
(6,'Neha',55000,'2024-01-05',10,'neha@gmail.com'),
(7,'Rohit',70000,'2022-09-22',30,'rohit@gmail.com'),
(8,'Kiran',95000,'2021-07-30',20,'kiran@gmail.com');


select * from pora
select * from kupch

-- Create a view named high_salary_emp that displays employees earning more than 70000.

create view  high_salary_emp as 
select * from pora
where salary > 70000

select * from high_salary_emp


-- Using the view created above, display only employees from the IT department. 

select * from high_salary_emp
where depa_id = 20

/* Create a view named employee_department_view showing:
Employee Name
Department Name
Salary
(Use JOIN) 
*/ 
select * from pora
select * from kupch

create view employee_department_view as
select p.emp_name  , k.depa_name , p.salary 
from pora p
join kupch k 
on p.depa_id = k.depa_id 
select * from employee_department_view
 
/* Replace the above view so it also includes Hire Date.
(Hint: CREATE OR REPLACE VIEW)*/

select * from employee_department_view

create view employee_department_view2  as
select p.emp_name  , k.depa_name , p.salary ,p.hire_date 
from pora p
join kupch k 
on p.depa_id = k.depa_id 
select * from employee_department_view2


-- Create a view that stores only employees hired after 2022-01-01.

create view employees_hired_view as
select * from pora
where hire_date > '2022-01-01' 

-- Drop the view created in Question 5.
drop view employees_hired_view 


-- Create an HR View using WITH CHECK OPTION.

create view HR_VIEW as 

select *
from pora 
where depa_id = 10 
with check option;

insert into hr_view values
(11,'hf',342334, '2022-10-23' , 10 ,'a@gmail.com')
-- invalid input check option checks conditions 
insert into hr_view values
(11,'hf',342334, '2022-10-23' , 20 ,'a@gmail.com')

-- Indexes
-- Create an index on the hire_date column.

create index hire_date on pora(hire_date);

-- Display all indexes created on the employees table.

show index from pora

-- Drop the index created in Question 8. hire_date 

drop index hire_date on pora;

/* Create a composite index on
depa_id
hire_date
*/

create index idx_depa_hire on pora(depa_id , hire_date);

-- Write a query that can benefit from the composite index. 
(depa_id , hire_date);

select * from pora
where depa_id = 20
and   hire_date > '2021-01-01'

-- Create a functional index on the YEAR(hire_date) column.


select * from pora 
where year(hire_date) = '2022'

-- Write a query to find all employees hired in 2022 using the functional index.
 
select * from pora 
where year(hire_date) = '2023'

CREATE TABLE employees (
    emp_id INT,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    joined_date DATE
);

INSERT INTO employees VALUES
(1, 'Amit', 'HR', 50000, '2020-05-10'),
(2, 'Priya', 'Finance', 65000, '2021-01-20'),
(3, 'Rohit', 'IT', 80000, '2022-12-01'),
(4, 'Sneha', 'Finance', 70000, '2025-12-10'),
(5, 'Vikram', 'IT', 90000, '2024-07-15');

select * from employees
-- Creating View: high_salary_employees

create view high_view as 
select * from employees 
where salary > 70000;

-- Find all high salary employees

select *,
     dense_rank() over(order by salary desc)
from employees

-- Count how many high salary employees are in IT /  hr 
select *,
      dense_rank() over(order by salary desc)as rank_
      from employees
      where department in ('hr')
      
-- HR Department View
create view hr_view as
select *,
     dense_rank() over (oder by salary desc)as rank_
     from employees
     where department in ('hr')
     
select * from employees 

-- finance  Department View

-- Business wants to highlight employees earning above ₹75,000.

create view emp_view as 
select * from employees
where salary >= 75000;
select * from emp_view

-- Write a view to store 2nd highest salary employee details.
create view sec_view as 
select *,
    dense_rank() over(order by salary desc)as ranky
from employees

select * from sec_view
where ranky = 2


create view hr_views as
select * 
from employees
where department = 'hr'
with check option ;

insert into hr_views values (7 , 'a','hr',43434,'2026-1-1') 




-- index 
-- data retrieve faster 
-- by default used for union foreign key primary key 

CREATE TABLE yzdep ( 
	department_id INT PRIMARY KEY, 
	department_name VARCHAR(50) 
); 

CREATE TABLE yzemp ( 
	employee_id INT PRIMARY KEY, 
	employee_name VARCHAR(50), 
   	 mobile_number bigint unique,
    	hire_date date,
	department_id INT, 
	FOREIGN KEY (department_id) REFERENCES yzdep(department_id) 
);

create index index_name on table_nmae(colm_name);


==============================================================================================
CREATE TABLE support_tickets (
    ticket_id INT PRIMARY KEY,
    customer_id INT,
    customer_name VARCHAR(100),
    status VARCHAR(20),
    issue VARCHAR(255),
    created_at DATETIME
);

INSERT INTO support_tickets
(ticket_id, customer_id, customer_name, status, issue, created_at)
VALUES
(101, 1001, 'Rahul',   'HIGH',     'Payment Failed',         '2026-07-10 10:30:00'),
(102, 1002, 'Priya',   'LOW',      'Profile Update',         '2026-07-11 09:15:00'),
(103, 1003, 'Amit',    'CRITICAL', 'Server Down',            '2026-07-12 08:45:00'),
(104, 1004, 'Neha',    'MEDIUM',   'Password Reset',         '2026-07-11 15:20:00'),
(105, 1005, 'Vikram',  'HIGH',     'Order Not Delivered',    '2026-07-12 09:30:00'),
(106, 1006, 'Sneha',   'CRITICAL', 'Database Connection',    '2026-07-12 11:10:00'),
(107, 1007, 'Rohit',   'LOW',      'Address Change',         '2026-07-10 14:00:00'),
(108, 1008, 'Kiran',   'MEDIUM',   'Login Issue',            '2026-07-12 10:45:00');

SELECT * FROM support_tickets;

select *
 from support_tickets 
order by 
     case 
     when status = 'critical' then 1
     when status = 'high' then 2
	when status = 'medium' then 3
    when status = 'low' then 4
    else 5
    
    end,
status desc


-- Find how many tickets belong to each status.

select status,
      count(*)as total_ticket 
from support_tickets
group by status


-- Latest Ticket for Each Status
create view latest_view as
select *,
     row_number() over (partition by status order by created_at)as rn1
from support_tickets

select * from latest_view
where rn1 = 1     

-- Running Count of Tickets

select *,
     count(ticket_id) over(order by created_at) as running_count
from support_tickets

-- Find Percentage of Tickets by Status

select status,
      count(*) over(partition by status)
from support_tickets
group by status 



    select status,
      count(*)as total_
from support_tickets
group by status 

count(*) * 100
 / sum(count(*)) over()
 
 SELECT
    status,
    COUNT(*) AS total_ticket,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER(),
        2
    ) AS percentage
FROM support_tickets
GROUP BY status;
 
 
