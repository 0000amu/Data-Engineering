select * from course 
select * from student 
select * from student_course

-- Find the names of all students who are enrolled in the 'English' course.
 
 select name from student where id in (
 select student_id  from student_course where course_id = (
 
		select id   from course where id = 1 
 ));
 
 -- List the titles of courses that have name of course through id at least one student who has completed the course.
select name from course where id in (
select distinct course_id from student_course where is_completed = 't');

-- Get the names of students who were invited by 'Veronica Knight'.

select name from student where id in (
  select id from student where invited_by_id = 1 );

-- Find the names of students who are enrolled in more than one course.
select name from student where id in (
select student_id from student_course 
group by student_id 
having count(course_id) > 1 ); 

-- List the courses where the average minutes_spent by students is greater than 500.

select name from course where id in (
select course_id  from student_course 
group by course_id
having avg(minutes_spent) > '500' );

-- Find the names of students who have enrolled in courses but have not completed any of them.
select name from student where id in (
select distinct student_id from student_course
where is_completed = 'f');


-- List courses that have no students enrolled. not in not exists 

select distinct distinct course_id
 from student_course
 group by student_id,course_id 

SELECT name 
FROM course
WHERE id NOT IN (
    select distinct course_id
 from student_course
 group by student_id,course_id 
);



-- For each student, display their name and the number of courses they are enrolled in.
select name from student where id in (
select student_id ,course_id  from student_course 
group by student_id,course_id ); 

/* master table 
   child table  sm id then join condition 
  course id , student id  , student_course id-s,c 


select s.name , c.name
from student s
inner join student_course sc
on s.id = sc.student_id 
inner join course c
on c.id = sc.course_id


SELECT
    name,
    (
        SELECT COUNT(*)
        FROM student_course sc
        WHERE sc.student_id = s.id
    ) AS total_courses
FROM student s;



select name from student where id in (
select student_id ,count(course_id) from student_course
group by student_id);

select * from student as s
where name = (select student_id , count(course_id) from student_course
where name = s.name
);

SELECT * FROM tablename aliasname 
WHERE columnname= (
    SELECT * FROM tablename  
    WHERE columnname = alianame.columnname
)
*/

-- Determine which student has the
-- highest minutes_spent value across all student_course entries.

select name from student where id = (
select student_id  as highest_min from student_course 
group by student_id
having count(*) > 1);


create table department(
depa_id int primary key,
depa_name varchar(255) 
);

insert into department  values (10,'sale'),(20,'it'),(30 , 'marketing');

create table empll(
emp_id int primary key,
emp_name varchar(255),
salary decimal(10,2) ,
depa_id int,
foreign key(depa_id) references department(depa_id) 
);

INSERT INTO empll (emp_id, emp_name, salary, depa_id) VALUES
(1, 'Sunil', 60000, 10),
(2, 'Tushar', 75000, 20),
(3, 'Anil', 80000, 20),
(4, 'Priya', 55000, 10),
(5, 'Rahul', 90000, 30),
(6, 'Meera', 70000, 20),
(7, 'Vikram', 85000, 30)


select * from empll
select * from department 

-- Find all employees whose salary is greater 
-- than the average salary of all employees.

select * from empll where salary > (
select avg(salary) from empll);
-- non corelated table row subquery 


-- Find employees whose salary is greater
-- than the average salary
-- of their own department.

SELECT e.emp_id,
       e.emp_name,
       e.salary,
       e.depa_id
FROM empll e
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM empll e2
    WHERE e2.depa_id = e.depa_id
);

 -- Find employees with the lowest salary.
 select * from empll where salary =(
     select min(salary) from empll
 ); -- non corelated single row subquery 
 
 
 -- Find employees who are working in ‘IT’ department.

select * from empll where depa_id = (
	select depa_id from department where depa_name = 'it' 
);-- non corelated  table subquery  

-- Write a query to display the employees who are getting
-- more salary than the highest paid employee in ‘IT’ department.


select * from empll where salary > (
	select max(salary) from empll where depa_id = (
		select depa_id from department where depa_name = 'it'
)); -- table non corelated subquery

-- Write a query to display the 2nd / 3rd or nth but 
-- value assign from 0 = highest value
-- highest salary from employee table.
-- nth 

select * from empll as e1
where  4 = (
		
        select count(distinct salary) 
        from empll as e2
        where e2.salary > e1.salary 

);

select max(salary) from empll where salary <( 
select max(salary) from empll); -- not recommended 


-- Write a query to display employees 
-- who are working in either IT or HR departments.

select * from empll where depa_id in (
select depa_id from department where depa_name in ('it','sale'));
-- Multiple row sub query 


-- Write a query to display employee details 
-- those are getting maximum salary in each department.
 

select * from empll where (depa_id, salary) in  (
select  depa_id , max(salary) from empll group by depa_id 
);

-- Top-N Query

 -- Write an SQL query to retrieve the employee(s) 
 -- who earn the 2nd highest salary in each department. 


select * from empll e1
where 1 = (
	 
     select count(distinct salary) from empll e2
	 where e2.salary > e1.salary 
	 
);







