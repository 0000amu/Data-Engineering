use amu;
create table employe(
emp_id INT,
first_name VARCHAR(50),
department VARCHAR(50),
salary DECIMAL ,
bonus DECIMAL
);

SELECT * FROM employe;


alter table employe add email varchar(50);
alter table employe change first_name emp_name varchar(50);
alter table employe add city varchar(50);
alter table employe drop email;

alter table employe add column manager_id int after department;

replace into em values 
(101,'Rahul','IT',201,50000,5000,'Pune'),
(102,'Amit','HR',NULL,45000,NULL,'Mumbai'),
(103,'Priya',NULL,202,60000,8000,'Delhi'),
(104,'Sneha','Finance',NULL,55000,3000,'Pune'),
(105,'John',NULL,NULL,70000,NULL,'Nagpur'),
(106,'Riya','Sales',203,48000,2000,'Mumbai'),
(107,'Karan','IT',201,75000,7000,'Pune'),
(108,'Neha','HR',204,52000,4000,'Delhi'),
(109,'Vikas','Sales',203,65000,NULL,'Bangalore'),
(110,'Anjali','Finance',205,58000,3500,'Pune');
rename table employe to em;
select * from em;
truncate table em;
alter table em change city city varchar(100);


update em set salary = 55000 where emp_id = 101;
update em set bonus = 5000 where emp_id = 105;
update em set department = 'it' where emp_id = 103;
delete from em where emp_id = 105;
start transaction;
delete from em;
rollback;


select * from em;
select emp_name from em;
select emp_name , salary from em;
select distinct department from em;
select city from em where city='pune';
select salary from em where salary > 60000;
select salary from em where salary < 50000;
select salary from em where salary >= 55000; 
select salary from em where salary <> 50000;


select emp_name from em where manager_id is null;
select emp_name , department from em where department is null;
select emp_name , department from em where department is not null;
select coalesce(manager_id,'unknown') from em;
select coalesce(salary,bonus) as 'total' from em;


select emp_name from em where emp_name like 'a%';
select emp_name from em where emp_name like '%a';
select emp_name from em where emp_name like '%ha%';
select  emp_name from em where length(emp_name)  = 5;
select emp_name from em where emp_name like '_i%'

select emp_name,salary from em where salary > 60000;
select emp_name ,department from em WHERE department = 'IT' OR department = 'HR';
select emp_name ,department from em where department != 'finance' ;
select emp_name ,salary ,city from em where city='pune' and salary >55000;

select emp_name , city from em where city = 'pune' or city ='mumbai';

select emp_name , salary from em where salary between 50000 and 70000;

select distinct city from em;

select emp_name,department from em where department  not in('finance');
select emp_name ,city from em where city not in ('Bangalore');

select emp_name , department from em where department in ('sales','finance');


select emp_name ,salary from em order by salary  asc;
select emp_name ,salary from em order by salary desc;
select emp_name, department from em order by department asc;

select * from em limit 5;
select * from em order by salary desc limit 3;

select count(*) from em;

select count(department) from em;
select sum(salary) from em;
select avg(salary)from em;

select sum(salary),avg(salary),max(salary),min(salary) from em;

create table IT_EMPLOYEE as select * from em where department = 'it';
create table empty_table like em; 


create table pune_table as select * from em where city = 'pune';

select * from pune_table;

alter table em add column is_deleted tinyint default 0;

update em set is_deleted =1 where emp_id=106;
select * from em where is_deleted = 1;

update em set is_deleted = 0 where emp_id=106;
select emp_id as active from em  where is_deleted = 0;

select * from em;

select department , sum(salary) as total_salary
from em group by department;

select department , avg(salary) as avg_salary
from em group by department ;

select department , avg(salary) as avg_salary
from em group by department limit 1;


select city ,count(*) as total_emply
from em group by city;

select department , max(salary) as max_salary
from em group by department ;


