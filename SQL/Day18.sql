CREATE TABLE empt (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    email VARCHAR(100),
    status VARCHAR(20),
    joining_date DATE
);

INSERT INTO empt VALUES
(101,'Rahul','IT',55000,'rahul@gmail.com','ACTIVE','2022-01-15'),
(102,'Sneha','HR',48000,'sneha@gmail.com','ACTIVE','2023-04-18'),
(103,'Amit','Finance',62000,'amit@gmail.com','ACTIVE','2021-09-11'),
(104,'Priya','IT',70000,'priya@gmail.com','ACTIVE','2020-11-25'),
(105,'Neha','Sales',45000,'neha@gmail.com','ACTIVE','2024-02-12'),
(106,'Rohit','IT',52000,'rohit@gmail.com','ACTIVE','2023-10-20'),
(107,'Kiran','HR',38000,'kiran@gmail.com','INACTIVE','2021-05-18'),
(108,'Pooja','Marketing',60000,'pooja@gmail.com','ACTIVE','2022-07-12');

select * from empt;

/*Level 1 — Fundamentals (Easy)
Create a trigger to prevent inserting an employee with salary less than 15,000
before 
*/
delimiter // 
create trigger triger_prevent_sala
before insert on empt
for each row
begin 
      
      if new.salary < 15000 then 
      signal sqlstate '45000'
      set message_text = 'Cannot insert employee with salary less than 15000';
      
      end if;
end
//

-- Create a trigger to convert every employee name into uppercase before insertion.

delimiter // 
create trigger emp_upper
before 
insert on empt
for each row
begin 
     set new.name =upper(new.name);
end 
//

-- Create a trigger to automatically set status as ACTIVE if no status is provided.

delimiter //
create trigger active_trigger
before 
insert on empt
for each row
begin 
     if new.status is null then 
     set new.status = active ;
     
	 end if;
end 
//

-- Create a trigger to prevent inserting employees with duplicate email addresses. 

delimiter //
create trigger dupli_email
before 
insert on empt
for each row
begin 
      declare email_count int; 
      
      select count(*) into email_count
      from empt
      where email = new.email;
      
      if new.email > 0 then 
      signal sqlstate '45000'
      set message_text = 'cant enter duplicate email addr';
      
      end if;
end
 //

/*Create a trigger to prevent inserting employees whose joining date
 is in the future.
*/ 

delimiter // 
create trigger late_joiner
before 
insert on empt 
for each row 
begin 
     
     if new.joining_date > curdate() then
      signal sqlstate '45000'
     set message_text = 'you cant enter future date';
     end if;
end //

-- Create a trigger to remove extra spaces from employee names before insertion. 

delimiter // 
create trigger remove_space
before insert on empt
for each row
begin
      set new.emp_name = replace(emp_name ,' ','');
end 
//

-- Create a trigger to prevent empty employee names.

delimiter // 
create trigger  prevent_empty 
before insert on empt
for each row 
begin 
	     if new.emp_name is not null
         or trim(new.emp_name)= '' then
         SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Employee name cannot be empty';
        end if;
end //


/*Create a trigger that does not allow department names other than:
IT
HR
Finance
Sales
Marketing*/

delimiter //
create trigger allow_depa
before insert on empt
for each row
begin

      if new.department not in ('it','hr','finance','sales','marketing') then 
      signal sqlstate '45000'
      set message_text = 'not in appropriate depa';
      end if;
end
 //

-- Level 2 — UPDATE Triggers
/* 
Whenever salary changes, store the old salary and new salary in another table.
You create the required table.*/


create table salary(
emp_id int,
salary decimal(10,2),
new_salary decimal(10,2)
);

delimiter // 
create trigger salary_change 
after update  on empt 
for each row
begin

IF OLD.salary <> NEW.salary THEN
    INSERT INTO salary (salary);
END IF;
end
//
