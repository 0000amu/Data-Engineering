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
    INSERT INTO salary 
      (
            emp_id,
            salary,
            new_salary
        )
        VALUES
        (
            NEW.emp_id,
            OLD.salary,
            NEW.salary
        );
    END IF;
end
//

-- Prevent salary reduction.
delimiter // 
create trigger sala_reduction 
before update
 on empt
for each row
begin 
        if new.salary < old.salary then
        signal sqlstate '45000'
        set message_text = 'no salary reduction allowed';
      end if;
 
end // 

-- Whenever department changes, save both old and new departments in another table.
-- Design the table yourself.

select * from empt;

create table department_history(
emp_id int ,
old_department varchar(100),
new_department varchar(100)
);

delimiter //
create trigger depa_changes
after update 
on empt
for each row
begin
      if old.department <> new.department then
      insert into department_history(emp_id,
					old_department,
					new_department
					) values(
						  old.emp_id,
						  old.department,
						  NEW.department
						  );
      end if;
end

/*Level 3 — DELETE Triggers
Before deleting an employee, store the complete employee record in another table.
Create the backup table yourself.*/

create table backup_emp like empt;
select * from backup_emp


delimiter //
create trigger backup_emp_into_backup_emp
before delete 
on empt
for each row
begin 
      insert into  backup_emp 
      values 
      ( old.emp_id,
		old.emp_name,
		old.department,
		old.salary,
		old.email,
		old.status,
		old.joining_date
      )
end // 

-- Prevent deleting employees from the IT department.

delimiter //
create trigger emp_it_prevention
before delete
on empt
for each row
begin 
      if old.department = 'it' then
      signal sqlstate '45000'
      set message_text = 'cant delete emp from it';
      end if;

end 
//

-- Whenever an employee is deleted, save the deletion time in another table
-- Create the required table.

create table audit_log_deletion(
    log_id  INT AUTO_INCREMENT PRIMARY KEY,
    emp_id INT,
    action_time timestamp );
    
delimiter // 
create trigger triggu_deletion
after delete 
on empt
for each row
begin
	insert into audit_log_deletion  (emp_id, action_time)
	values (
       old.emp_id,
       current_timestamp()
    );
end  
//
