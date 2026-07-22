
delimiter //
create procedure proc_demo()
BEGIN
	SELECT 'Welcome to procedure' AS message;
END //
DELIMITER ;

call proc_demo()

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(30),
    salary DECIMAL(10,2),
    city VARCHAR(30),
    joining_date DATE
);
INSERT INTO employees VALUES
(101, 'Rahul',  'IT',      65000, 'Pune',      '2022-01-15'),
(102, 'Priya',  'HR',      45000, 'Mumbai',    '2021-07-20'),
(103, 'Amit',   'IT',      72000, 'Pune',      '2023-03-12'),
(104, 'Sneha',  'Finance', 58000, 'Nagpur',    '2020-09-10'),
(105, 'Karan',  'HR',      50000, 'Delhi',     '2022-11-01'),
(106, 'Neha',   'IT',      80000, 'Bangalore', '2019-05-18'),
(107, 'Rohit',  'Sales',   55000, 'Pune',      '2021-02-25'),
(108, 'Anjali', 'Finance', 62000, 'Mumbai',    '2023-06-14'),
(109, 'Vikas',  'Sales',   48000, 'Delhi',     '2020-12-08'),
(110, 'Pooja',  'IT',      90000, 'Hyderabad', '2018-08-30');

select * from employees

/*Stored Procedure Practice Questions
Level 1 (Easy)
Create a stored procedure to display all employees.
Create a stored procedure to display only IT employees.
Create a stored procedure to display employees whose salary is greater than ₹60,000.
Create a stored procedure to count the total number of employees.
Create a stored procedure to display employees from Pune.*/

delimiter //
create procedure proc_emp()
begin
      select * from employees;
end
//

delimiter //
create procedure proc_it()
begin
	select * from employees
    where department = 'it';
end
//

delimiter // 
create procedure proc_greater_sala()
begin 
		select * from employees
        where salary > 80000;
end
//


delimiter //
create procedure proc_emp_count()
begin 
      select count(*)as total_emp
      from employees;
      
end
 // 
 
 
 
 delimiter //
 create procedure proc_pune_emp()
 begin 
      select * from employees
      where city = 'pune';
end
//
 
/*Level 2 (Using Parameters)
Create a stored procedure that accepts emp_id and displays that employee's details.*/
--in para madhe emp_id




delimiter // 
create procedure proc_accept_empid(in empp_id int )
begin 
       DECLARE emp_count INT;

		SELECT COUNT(*) into emp_count
		FROM employees
		WHERE emp_id = empp_id;
			
    if emp_count > 0 then
    select * from employees
    where emp_id = empp_id;
    else  
        select 'no emp_id found' as message;
	end if;
end
//


call proc_accept_empid(9)

/*Create a stored procedure that accepts a department 
name and displays employees from that department.
*/

delimiter // 
create procedure proc_depa( in p_depa_name varchar(30))
begin 
		DECLARE dept_count INT;

SELECT COUNT(*)
INTO dept_count
FROM employees
WHERE department = p_depa_name;
	
IF dept_count > 0 THEN
    SELECT *
    FROM employees
    WHERE department = p_depa_name;
ELSE
    SELECT 'No department found';
END IF;
end
// 

CAll proc_depa('it')

/*Create a stored procedure that accepts a city name and displays employees from that city.*/

delimiter // 
create procedure proc_city(in p_city varchar(50))
begin
      declare city_count int; 
       
      select count(*) into city_count
      from employees
      where city = p_city;
      
      if city_count > 0 then 
      select * from employees
      where city = p_city;
      
      else 
			select 'city not present' as message;
	  end if;
end
//
call proc_city('pune')


/*
Create a stored procedure that accepts a salary 
amount and displays employees earning more than that salary.
*/

delimiter // 
create procedure proc_salary(in p_salary decimal(10,2))
begin 
       declare sala_count int;
       
       select count(*)into sala_count
       from employees
       where salary > p_salary;
       
       if sala_count > 0 then
       select * from employees
       where salary > p_salary;
       
       else
			SELECT 'No employees earn more than the given salary.' AS message;       
		end if;
end 
//
call proc_salary(40000)


/*Create a stored procedure that accepts a joining year
 and displays employees who joined in that year.
*/


delimiter //
create procedure proc_joining_year(in p_joining_year year)
begin 
     -- where joining_date =  p_joining_year
     declare joining_count int;
     
     select count(*) into joining_count
     from employees 
     where year(joining_date) = year(p_joining_year);
     
	if joining_count > 0 then
		 select * from employees
		 where year(joining_date) = year(p_joining_year);
	else
		select 'no data in that year found' as message;
	end if;
         
     
end
 // 

/* Create a stored procedure to insert a new employee.
in emp_id int
in emp_name varchar(50)
in department varchar(50)
in salary decimal(10,2)
in city varchar(30)
in joining_date date 
*/


delimiter // 
create procedure proc_insert_new(
in p_emp_id int,
in p_emp_name varchar(50),
in p_department varchar(50),
in p_salary decimal(10,2),
in p_city varchar(30),
in p_joining_date date 
)

begin
      insert into employees (emp_id,
							emp_name,
							department,
							salary,
							city,
							joining_date
)
      values (   p_emp_id,
				p_emp_name,
				p_department,
				p_salary,
				p_city,
				p_joining_date
);
      select 'successfully inserted employee' as messsage;
end
// 

CALL proc_insert_new(
    99,
    'amey',
    'IT',
    80000,
    'Pune',
    '2026-12-01'
);
select * from employees

-- Create a stored procedure to update an employee's salary using emp_id.
drop procedure proc_update_sala
delimiter // 
create procedure proc_update_sala(in p_emp_id int, in p_salary decimal(10,2))
begin
	declare emp_count int;
    
    select count(*)into emp_count
    from employees
    where emp_id = p_emp_id;
    
    if emp_count > 0 then
    UPDATE employees
	SET salary = p_salary
	WHERE emp_id = p_emp_id;
    
    select 'successfully inserted salary'as message;
    
    else 
    select 'employee duplicate'as message;
    end if;
end 
// 

call proc_update_sala(99,99999)
select * from employees

-- Create a stored procedure to update an employee's city.

delimiter // 
create procedure proc_city_update(in p_emp_id int, in p_city varchar(50))
begin 
		declare city_count int;
        
        select count(*) into city_count
        from employees
        where emp_id = p_emp_id;
        
        if city_count > 0 then 
        update employees
        set city = p_city
        where emp_id = p_emp_id;
        
        select 'city updated successfully'as message;
        
        else 
        select 'fail to update' as message;
        end if;

end
//

call proc_city_update(99,'banglore')
select * from employees

-- Create a stored procedure to delete an employee using emp_id.

delimiter //
create procedure proc_delete_emp_id(in p_emp_id int)
begin 
     declare emp_count int;
     
     select count(*)
     into emp_count
     from employees
     where emp_id = p_emp_id;
     
     if emp_count > 0 then
     delete from employees
     where emp_id = p_emp_id;
     
     select 'successfully removed emp_id'as message;
     
     else
         select'not found'as message;
	 end if;

end
//

call proc_delete_emp_id(102)


