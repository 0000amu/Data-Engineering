-- Write a PL/SQL function to display welcome message using function.

delimiter // 
create function func_message()
returns varchar(100) 
no sql
begin 
return 'welcome to avd';
end
//

select func_message()
SELECT func_message() AS message;

-- Write a PL/SQL function to take a number and find out cube of it.
delimiter // 
create function func_cube(f_cube  int)
returns int
no sql
begin   declare x_cube int; 
		set x_cube = f_cube * f_cube * f_cube;
        return x_cube;
end 
//

select func_cube(2)

-- Write a PL/SQL stored function for passing employee_id as a parameter, display employee details
drop function f_emp_detailss
delimiter // 
create function f_emp_detailss(f_emp_id int)
returns varchar(200)
reads sql data
begin  
       declare emp_detail varchar(200);
       
       select concat(
       emp_id, ' ',
       emp_name, ' ',
       department, ' ',
       salary, ' ',
       city, ' ',
       joining_date) 
       into emp_detail
       from employees
       where emp_id = f_emp_id;
       
       return emp_detail;
end;
 // 
select f_emp_detailss(99)as message


-- Example#4 [Normalize data during data Ingestion]

CREATE TABLE customersss (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    phone VARCHAR(20)
);

INSERT INTO customersss VALUES
(1, 'Anita Sharma', '9823 456 789'),
(2, 'Ravi Mehta', '98321-45670'),
(3, 'Geeta Iyer', '9700-123 456');

select * from customersss

--  ()as valid_no


delimiter //
create function func_phone_no(f_phon_no varchar(10))
returns varchar(10)
no sql 
begin
      declare phn_no varchar(10);
      
      set phn_no =replace(f_phon_no ,' ','');
      set f_phon_no = replace(f_phon_no , '-' , '');
      
      return concat('+91-' ,f_phon_no);
      
end 
//

select customer_name, func_phone_no(phone)as normalized_phone
from customersss

-- Example#5 [Convert from INR to USD]

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    amount_in_inr DECIMAL(10,2)
);

INSERT INTO orders VALUES
(1, 'Amit Deshmukh', 12450.00),
(2, 'Nikita Joshi', 5500.75),
(3, 'Suresh Patil', 78399.90),
(4, 'Meena Verma', 299.99);

delimiter // 
create function func_currency(f_amount_in_inr DECIMAL(10,2))
returns varchar(200)
no sql
begin 
return round(f_amount_in_inr / 98.4);

end
//
SELECT 
    order_id,
    customer_name,
    amount_in_inr,
    func_currency(amount_in_inr) AS amount_in_usd
FROM orders;

-- Example#6 [Validate PAN card format]
CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    pan_no VARCHAR(10)
); 

INSERT INTO employee VALUES
(1, 'Priya Chauhan', 'ABCDE1234F'),
(2, 'Mohit Jain', 'abcde234f'),
(3, 'Nisha Verma', 'A1CDE1234F');

select * from employee

delimiter // 
create function func_valid(f_pan_no varchar(10))
returns varchar(10)
no sql
begin 
     return regexp_like(f_pan_no,'^[A-Z]{5}[0-9]{4}[A-Z]$');
end
//

select *, func_valid(pan_no) from employee

-- Example#7 [Calculate number of days since last login]
CREATE TABLE user_accounts (
    user_id INT PRIMARY KEY,
    username VARCHAR(50),
    last_login DATE
);

INSERT INTO user_accounts VALUES
(1, 'raj', '2025-12-31'),
(2, 'ajay', '2026-01-15'),
(3, 'alok', '2025-05-15'),
(4, 'neel', NULL),
(5, 'amey', '2026-01-15');
select * from user_accounts

delimiter // 
create function func_total_days(f_last_login date)
returns varchar(100)
no sql
begin
     return timestampdiff(day ,f_last_login,curdate());
end
//

SELECT 
    username,
    last_login,
    func_total_days(last_login) AS inactive_days
FROM user_accounts;

/*Last login in days Description
		< 7            Active
		>7 and < 30    Inactive
		>30            Dormant
		NULL           Never Logged In
*/

delimiter // 
create function func_day_description(p_login_date date)
returns varchar(100)
reads sql data 
begin
    DECLARE days_diff INT;
	 
    IF p_last_login IS NULL THEN
        RETURN 'Never Logged In';
    END IF;
    
     set days_diff= timestamp_diff(days , p_login_date , currentdate());
     
     IF days_diff < 7 THEN
        RETURN 'Active';
    ELSEIF days_diff >= 7 AND days_diff < 30 THEN
        RETURN 'Inactive';
    ELSE
        RETURN 'Dormant';
	end if;
end
//

-- Example#9 [Masked Aadhaar Number]

CREATE TABLE teacher (
    teacher_id INT PRIMARY KEY,
    teacher_name VARCHAR(50),
    aadhaar_no VARCHAR(12)
);

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    aadhaar_no VARCHAR(12)
);

INSERT INTO teacher VALUES
(1, 'Anil Sharma', '123456789012'),
(2, 'Ajay Gupta', '987654321098');

INSERT INTO students VALUES
(1, 'Raj',  '111122223333'),
(2, 'Anita', '444455556666');

select * from teacher
select * from students
drop function func_masking_aadhar
delimiter // 
create function func_masking_aadhar(f_aadhar varchar(12))
returns varchar(12)
no sql 
begin
     return concat(repeat('*',length(f_aadhar)-4 ), right(f_aadhar,4));
end
//

select * , func_masking_aadhar(aadhaar_no )
from students  
