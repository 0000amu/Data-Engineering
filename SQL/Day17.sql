CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);
INSERT INTO departments VALUES
(10,'HR'),
(20,'IT'),
(30,'Finance'),
(40,'Sales'),
(50,'Marketing');

CREATE TABLE emp (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    salary DECIMAL(10,2),
    dept_id INT,
    joining_date DATE,
    bonus DECIMAL(10,2),
    experience INT,
    rating DECIMAL(3,1),
    FOREIGN KEY (dept_id)
    REFERENCES departments(dept_id)
);
INSERT INTO emp VALUES
(101,'Amit',65000,20,'2021-02-10',8000,5,4.8),
(102,'Priya',52000,10,'2022-05-11',4000,3,4.1),
(103,'Rahul',85000,20,'2019-09-18',12000,7,4.9),
(104,'Sneha',47000,30,'2023-01-20',3000,2,3.9),
(105,'Karan',39000,40,'2024-03-14',2500,1,3.5),
(106,'Neha',73000,20,'2020-08-25',9000,6,4.6),
(107,'Rohit',59000,50,'2022-07-15',4500,3,4.2),
(108,'Anjali',92000,30,'2018-04-19',15000,8,4.9),
(109,'Vikas',45000,40,'2023-11-02',2000,2,3.8),
(110,'Meera',61000,10,'2021-10-28',6000,5,4.4);

select * from emp 
select * from departments

-- LEVEL 1 (Basic)

-- Create a function that returns annual salary.
delimiter //
create function func_annual_sala(f_emp_id int)
returns decimal(10,2)
reads sql data
begin  
        declare emp_count int;
		declare emp_sala decimal(10,2);
        
        select count(*) into emp_count
        from emp
        where emp_id = f_emp_id;
        
        if emp_count > 0 then
        select salary into emp_sala
        from emp 
        where emp_id = f_emp_id;
        
        return emp_sala * 12 ;
        
        else 
        return null ;
        end if;
		
end; 
 //
 select func_annual_sala(103)
 select * from emp
 
 -- Create a function that returns salary after adding bonus.
 -- declr sala store karyl, 
 
 delimiter //
 create function func_sala_with_bonus(f_emp_id int)
 returns decimal(10,2)
 reads sql data
 begin 
	  
      declare emp_count int;
      declare bonus_sala decimal(10,2);
      
      select count(*)into emp_count
      from emp 
      where emp_id = f_emp_id;
      
      if emp_count > 0 then
      select salary +bonus into bonus_sala
      from emp 
      where emp_id = f_emp_id;
      return bonus_sala ;
      
      else 
      return null;
      end if;
 end;
 //
 
SELECT func_sala_with_bonus(101);

/* Create a function that returns

"High Salary"

if salary > 70000

otherwise

"Normal Salary" */


delimiter // 
create function func_salary_cls(f_emp_id int)
returns varchar(100)
reads sql data
begin 
      declare emp_count int;
      declare salary_high decimal(10,2);
	
	  select count(*)into emp_count
      from emp
      where emp_id = f_emp_id;
			
	  if emp_count >0 then
      
			SELECT salary
			INTO salary_high
			FROM emp
			WHERE emp_id = f_emp_id;
			
		  if salary_high > 70000 then 
		  return 'high_salary';
      else 
		  return 'normal_salary';
      end if;
	
	ELSE
        RETURN 'Employee Not Exists';
    END IF;

end;
//
select *, func_salary_cls(emp_id) from emp 


/*Create a function that returns employee experience category.

0-2  -> Fresher

3-5 -> Mid Level

6+ -> Senior
if exper > then 
*/

delimiter // 
create function func_emp_exp_cate(f_emp_id int)
returns varchar(100)
reads sql data
begin 
      declare emp_count int;
      declare exp_boys int;
      
      select count(*)into emp_count
      FROM emp
      WHERE emp_id = f_emp_id;
      
      if emp_count > 0 then 
		
        select experience into exp_boys
        FROM emp
        WHERE emp_id = f_emp_id;
        
			IF exp_boys BETWEEN 0 AND 2 THEN
				RETURN 'fresher';
                
             elseif exp_boys between 3 and 5 then
                 RETURN 'mid level';
                 
             else 
                 return 'senior';
			END IF;
            
        else 
           return 'no emp found';
		end if;
		
end;
//
select func_emp_exp_cate(101)
select * from emp
/*Return employee rating category

>=4.8 Excellent

>=4 Good

else Average
*/

delimiter // 
create function func_emp_rating(f_emp_id int)
returns varchar(100)
reads sql data
begin 
     declare emp_count int;
     declare rat_boys decimal(4,2);
     select count(*)into emp_count
     from emp
     where emp_id = f_emp_id;
     
     if emp_count > 0 then 
           
           select rating into rat_boys
           from emp 
           where emp_id = f_emp_id;
           
           if rat_boys >=4.8 then
           return 'excellent';
           
           elseif rat_boys >=4 then
           return 'good';
           
           else 
           return 'avg';
           
		end if;
     else 
         return 'no emp found';
	 end if;
end;
//


-- Function returns department name using dept_id.
select * from departments 

delimiter // 
create function func_depa(f_depa_id int) 
returns varchar(100)
reads sql data 
begin 
      declare depa_count int;
      declare depa_name varchar(50);
      
      select count(*) into depa_count
      from departments 
      where dept_id = f_depa_id;
      
      if depa_count> 0 then
      
          select dept_name into depa_name
          from departments
         where dept_id = f_depa_id;
         
         return depa_name; 
         
        else 
         return'no department found';
	  end if;
end
//

select func_depa(10)

-- Function returns employee salary by emp_id.

delimiter // 
create function func_sala_returns(f_emp_id int)
returns decimal(10,2)
reads sql data
begin 
      declare emp_count int;
      declare sala_emp decimal(10,2);
      
      select count(*)into emp_count
      from emp
      where emp_id = f_emp_id;
      
      if emp_count > 0 then 
      select salary into sala_emp
      from emp
      where emp_id = f_emp_id;
      
      return sala_emp;
      
      else 
         return null ;
         
		end if;
end
//

-- Function returns employee name using emp_id.
delimiter //
create function func_emp_name_returns(f_emp_id int)
returns varchar(100)
reads sql data
begin 
     declare emp_count int;
     declare emp_name2 varchar(100);
     
     select count(*)into emp_count
     from emp
     where emp_id = f_emp_id;
     
     if emp_count > 0 then 
     select emp_name into emp_name2 
     from emp 
     where emp_id = f_emp_id;
     
     return emp_name ;
     
     else 
        return null;
	end if;
end
 //
 select * from emp
 
 -- Function returns years completed in company.
 drop function func_year_complt
 delimiter // 
 create function func_year_complt(f_emp_id int)
 returns int
 reads sql data 
 begin 
       declare emp_count int;
       declare emp_year int;
       
       select count(*) into emp_count
       from emp
       where emp_id = f_emp_id;
       
       if  emp_count > 0 then
	
      select timestampdiff(year ,joining_date,curdate())
       into emp_year 
       from emp
       where emp_id = f_emp_id;
       
       return emp_year;
       
       else 
       return null ;
       end if;
 end
 //
 
 /*Function returns

Eligible

Not Eligible

when 
salary > 60000
AND
experience >4 -- eligible else not eligible  */

select * from emp

delimiter // 
create function func_eligibility(f_emp_id int)
returns varchar(100)
reads sql data
begin
     declare emp_count int;
     declare sala_var decimal(10,2);
     declare exp_var int;
     
     select count(*)into emp_count
     from emp
     where emp_id = f_emp_id;
     
     if emp_count > 0 then 
         
        select salary , experience
        into exp_var, exp_var
		from emp
        where emp_id = f_emp_id;
         
         if sala_var > 60000 and exp_var > 4 then
         return 'eligible';
         else
         return 'not eligible';
         end if;
         
     else    
        return'emp_id not found';
        end if;
end
//

-- Function returns department average salary.

delimiter //
create function func_avg_sala()
returns decimal(10,2)
no sql 
begin 
	  declare avg_sala decimal(10,2); 
      select avg(salary)into avg_sala
      from emp; 
      
      return avg(salary);
end 
 //
 
 /*Function returns
YES if employee salary is greater than department average.
Otherwise
NO
Input

emp_id
 */
 
 delimiter // 
 create function func_sala_compare(f_emp_id int)
 returns varchar(100)
 reads sql data
 begin
      declare emp_count int;
      declare sala_var decimal(10,2);
      declare depa_var_id int;
      declare avg_sal decimal(10,2);
      
      select count(*)into emp_count
      from emp
      where emp_id = f_emp_id ;
       
       if emp_count > 0 then 
           select salary , dept_id 
           into sala_var , depa_var_id 
           from emp
           where emp_id = f_emp_id;
           
           select avg(salary)into avg_sal
           from emp 
           where dept_id = depa_var_id;
           IF sala_var > avg_sal THEN
            RETURN 'YES';
        ELSE
            RETURN 'NO';
        END IF;

       
       else 
       return 'no emp found';
       end if;
end
 //
  
 /*Return salary rank.
Example
Highest salary Rank 1
Second highest Rank 2
Input
emp_id
(Hint: Count distinct salaries greater than employee salary.)*/

delimiter // 
create function func_sala_rank(f_emp_id int)
returns int
reads sql data
begin
     declare emp_count int;
     declare emp_sala_var decimal(10,2);
     declare sal_var int;
     
     select count(*)into emp_count
     from emp
     where emp_id = f_emp_id;
     
     if emp_count > 0 then
         select salary into emp_sala_var
         from emp 
         where emp_id = f_emp_id;
         
            SELECT COUNT(DISTINCT salary)
			INTO sal_var
			FROM emp
			WHERE salary > emp_sala_var;
            
            return sal_var + 1;
     else 
     return 'no emp found';
     end if;
end
//

SELECT *,
 func_sala_rank(emp_id)as ranku 
 from emp
 order by ranku;
