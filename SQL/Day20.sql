 -- event

 SET GLOBAL event_scheduler = ON;
 
CREATE TABLE empt (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    last_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO empt VALUES
(101,'Amit','IT',65000,'2026-07-26 09:10:00'),
(102,'Sneha','HR',48000,'2026-07-26 09:20:00'),
(103,'Rahul','Sales',72000,'2026-07-26 09:30:00'),
(104,'Priya','Finance',55000,'2026-07-26 09:40:00'),
(105,'Rohan','IT',69000,'2026-07-26 09:50:00');
INSERT INTO empt VALUES
(106,'Amey','IT',90000,current_timestamp());
select * from empt


-- Q1. Create a backup table for employees

     CREATE TABLE backup_emp LIKE empt;

-- Q2. Create a stored procedure to perform a Full Backup.

delimiter //
create procedure proc_full_backup()
begin
     -- remove all record
     truncate table backup_emp;
     -- copy all record 
     insert into backup_emp 
     select *
     from empt;
end
 //
 
-- Q3. Create an event that executes the full backup every 2 minutes.
 delimiter // 
 create event event_full_body
 on schedule
      every 2 minute
      starts current_timestamp()
do 
begin
      call proc_full_backup();
 end
 //
 
-- Q4. Create a stored procedure for Incremental Backup using last_modified.


delimiter // 
create procedure proc_incremental_backup()
begin 
	 insert into backup_emp 
     select *  from empt where last_modified >
     (select max(last_modified)from backup_emp);
end
// 

-- Q5. Create an event that executes the incremental backup every 5 minutes.

delimiter //
create procedure proc_incremental_backup()
begin 
      insert into emp_backup
      select * 
      from empt 
      where last_modified >
       (select coalesce(max(last_modified), '2026-07-26 23:01:29')from emp_backup);
end 
//

select max(last_modified) from empt
delimiter //
create event event_incremnt
on schedule
		every 5 minute
        starts current_timestamp()
 do
 begin 
       call  proc_incremental_backup();
 end 
 //

-- Q6. Update one employee and verify only that row is copied during incremental backup.
UPDATE empt
SET salary = 75000,
    last_modified = CURRENT_TIMESTAMP
WHERE emp_id = 103;
----------------------------------------------------------------------------------------------
-- Practice Set 2 (Data Cleanup)

-- Q7. Create a procedure to delete records older than 90 days.

delimiter // 
create procedure proc_delete_90days()
begin
      delete 
      from empt 
      where last_modified) < current_date() - interval 90 day;
end
//

-- Q8. Create an event that executes every day.

delimiter // 
create event event_every_date 
on schedule 
       every 1 day
       starts current_timestamp()
do 
begin 
     call proc_delete_90days();
end 
//

-- Q9. Modify the procedure to delete records older than 120 days.

delimiter // 
create procedure proc_delete_120days()
begin
	delete
	from empt
    where last_modified < current_date()  - interval 120 day; 
end
//

-- Q10. Verify the cleanup.
proc_delete_120days();
----------------------------------------------------------------------------------------------------------------------
-- Practice Set 3 (Data Archival)
-- Q11. Create an archive table.


CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    sale_date DATE,
    amount DECIMAL(10,2),
    status VARCHAR(20)
);

INSERT INTO sales VALUES
(1,'Amit','2023-03-15',2500,'Completed'),
(2,'Sneha','2024-01-10',1800,'Completed'),
(3,'Rahul','2026-02-11',5200,'Pending'),
(4,'Priya','2025-04-05',3200,'Completed'),
(5,'Rohan','2022-12-20',4100,'Completed');

select * from sales
create table archiv_sales like sales
select * from archiv_sales

-- Q12. Create a procedure that archives sales older than 1 year.

delimiter // 
create procedure proc_archieve()
begin
       insert into  archiv_sales  
	   select *
       from sales
       where sale_date < curdate() - interval 1 year;
       
       delete 
       from sales 
       where sale_date < current_timestamp() - interval 1 year;
end
//

-- Q14. Create an event that runs every midnight.

delimiter //
create event event_midnight
on schedule
           every 1 day
           starts TIMESTAMP(CURDATE() + INTERVAL 1 DAY)
do 
begin  
    call proc_archieve() ;
    
end // 

-- Q15. Modify the procedure so that only Completed sales are archived.

delimiter // 
create procedure proc_archieve()
begin   
       insert into archiv_sales
       select * 
       from sales 
       where 
            status = 'completed' 
       and sale_date < curdate() - interval 1 year;
       
		delete  
        from sales
        where status = 'completed'
       and sale_date < curdate() - interval 1 year;
; 
	
       
end
//








