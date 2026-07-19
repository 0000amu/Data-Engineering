select * from emz
select * from departmentti

-- window function 
-- multiple row Partition by single column 
select
     employee_id,
     depa_id,
     salary,
     sum(salary) over(partition by depa_id)as total,
     count(salary) over(partition by depa_id)as counttotal,
     avg(salary) over(partition by depa_id)as avgg,
     max(salary) over(partition by depa_id)as maxxi,
     min(salary) over(partition by depa_id)as minsala
from emz;

-- single row OVER() without Partition
select
     employee_id,
     depa_id,
     salary,
     sum(salary) over()as total,
     count(salary) over()as counttotal,
     avg(salary) over()as avgg,
     max(salary) over()as maxxi,
     min(salary) over()as minsala
from emz;

-- rank function 
-- 1.rank_number()
-- 2.rank()
-- 3.dense_rank()

-- rank_number()
-- Write an SQL query to list all employees along with their salary ranks within their respective
--  departments, ordered by their salary in descending order.

select *,
      row_number() over(partition by depa_id order by salary desc)as rn1
from emz;

-- Write a query to display first 2 highest paid employees from each department.
with empcte as(
select *,
      row_number() over(partition by depa_id order by salary desc)as rn1
from emz)
select * from empcte 
where rn1 in (1,2);

-- rank()
SELECT
    e.*,
    RANK() OVER(
        PARTITION BY depa_id
        ORDER BY salary DESC
    ) AS rank_no
FROM emz e;

SELECT
    employee_name,
    salary,
    CASE NTILE(3) OVER (ORDER BY salary DESC)
        WHEN 1 THEN 'High Salary'
        WHEN 2 THEN 'Medium Salary'
        WHEN 3 THEN 'Low Salary'
    END AS salary_group
FROM emz;

CREATE TABLE revenues (
quarter_name VARCHAR(20),
revenue DECIMAL(15, 2)
);
INSERT INTO revenues VALUES('Q1',20000000),
('Q2',50000000),
('Q3',10000000),
('Q4',60000000);

select * from revenues

with prvcte as(
select *,
      lag(revenue) over(order by quarter_name) as prv_revenue
from revenues
) 
select *,
      revenue -  coalesce(prv_revenue,0) as difference,
      case 
           WHEN revenue > COALESCE(prv_revenue, 0) THEN 'Profit'
           WHEN revenue < COALESCE(prv_revenue, 0) THEN 'Loss'
           ELSE 'No Change'
       END AS profit_loss
FROM prvcte;

select * from 
(SELECT quarter_name, revenue, 
lag(revenue,1,0) OVER (order by quarter_name) prev_revenue,
revenue - lag(revenue,1,0) OVER (order by quarter_name) as difference,
    case 
	when revenue > lag(revenue,1,0) OVER (order by quarter_name) then 'profit'
    else 'loss'
    end as profitlosses 

FROM revenues)as profitboys
where profitlosses = 'profit'

-- lead()

select *,
      lead(revenue) over(order by quarter_name) as rn1
from revenues;

-- first_value()
select *,
      first_value(revenue) over(order by quarter_name) as rn1
from revenues;


-- last_value()
select *,
      last_value(revenue) over(order by quarter_name)as rn1
from revenues;

-- nth value
SELECT quarter_name,
       revenue,
       nth_value(revenue, 2)  OVER ()as next_revenue
FROM revenues;

-- Retrieve the employees who earn the 3rd highest salary. 
select * from emz
with highcte as(
select *,
      dense_rank() over(order by depa_id desc)as highestsala
from emz) 
select * from highcte
where highestsala = 3


Questions#2 [Removing Duplicates]
CREATE TABLE cust10 (
    id INT,
    name VARCHAR(100),
    email VARCHAR(100)
);

INSERT INTO cust10 VALUES
(1, 'Amit', 'amit@gmail.com'),
(2, 'Priya', 'priya@gmail.com'),
(3, 'Amit', 'amit@gmail.com'),  
(4, 'Ravi', 'ravi@gmail.com'),
(5, 'Amit', 'amit@gmail.com');  
select * from cust10
-- Get unique records

with uniquecte as(
select *,
     row_number() over(partition by name,email) as ne
from cust10
)
select * from uniquecte 
where ne in (2,3)

-- delete unique id 

with duplicte as(
select *,
	 row_number() over(partition by name,email)as rn1
from cust10
)
delete from cust10 where id in(
     select id
     from duplicte 
     where rn1>1
)
select * from cust10

CREATE TABLE salesboys (
    region VARCHAR(50),
    month VARCHAR(10),
    sales DECIMAL(10,2)
);

INSERT INTO salesboys VALUES
('East', 'Jan', 1000),
('East', 'Feb', 1500),
('East', 'Mar', 1200),
('West', 'Jan', 2000),
('West', 'Feb', 1800),
('West', 'Mar', 2200);

select * from salesboys

-- Write a query to display region, 
-- month, sales, and the running total of sales for each region.
[Running Total/ Cumulative Count]

select *,
     sum(sales) over(partition by region order by month)as running_total
from salesboys

/*
We are given users' session logs for a particular day. We need to calculate
 how many hours each user was active that day. The session starts when state = 1 
 and ends when state = 0.

*/
CREATE TABLE customer_activity (
    cust_id INT,
    state INT,              
    timestamp DATETIME
);

INSERT INTO customer_activity VALUES
(101, 1, '2026-01-10 08:00:00'),
(101, 0, '2026-01-10 10:30:00'),
(101, 1, '2026-01-10 14:00:00'),
(101, 0, '2026-01-10 15:45:00'),
(102, 1, '2026-01-10 09:15:00'),
(102, 0, '2026-01-10 12:00:00'),
(103, 1, '2026-01-10 07:00:00'),
(103, 0, '2026-01-10 09:30:00'),
(103, 1, '2026-01-10 13:00:00'),
(103, 0, '2026-01-10 16:00:00');
select * from customer_activity


with logincte as(
select cust_id,
       state,
       timestamp as login_time,
     lead(timestamp) over(partition by cust_id order by timestamp) as log_out
from customer_activity
)
select     cust_id,

	  -- timestampdiff(second, login_time, log_out)as duration_sec ,
                	  floor(
          sum(timestampdiff(second, login_time, log_out)) / 3600 
          )as hr ,
          
            floor(
          (sum(timestampdiff(second, login_time, log_out)) % 3600) / 60 
          
          )as sec
from logincte   
where state = 1   
group by cust_id;

