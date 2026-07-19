50 qus to solve over window function ,rank function, 

CREATE TABLE s5 (
    sale_id INT PRIMARY KEY,
    salesperson VARCHAR(50),
    region VARCHAR(30),
    product VARCHAR(30),
    sale_date DATE,
    amount INT
);

INSERT INTO s5 VALUES
(1,'Amit','North','Laptop','2026-01-01',65000),
(2,'Amit','North','Mouse','2026-01-03',1200),
(3,'Priya','South','Laptop','2026-01-02',70000),
(4,'Priya','South','Keyboard','2026-01-05',2500),
(5,'Rahul','West','Laptop','2026-01-01',72000),
(6,'Rahul','West','Mouse','2026-01-04',1500),
(7,'Sneha','North','Laptop','2026-01-02',68000),
(8,'Sneha','North','Monitor','2026-01-06',18000),
(9,'Vikas','East','Laptop','2026-01-03',71000),
(10,'Vikas','East','Keyboard','2026-01-07',2200),
(11,'Neha','South','Monitor','2026-01-08',20000),
(12,'Ankit','West','Laptop','2026-01-09',76000);

select * from s5

-- Level 1 - OVER()
-- Display every sale along with the total sales amount of the company.

select *,
      sum(amount) over()as total_sales 
from s5;

-- Display every sale along with the average sale amount of the company.

select *,
      avg(amount) over()as avg_sales
from s5;

-- Show each sale and the difference between its amount and the company average. 

select *,
       avg(amount) over()as avg_sales,
       amount - avg(amount) over()as diff
from s5;

-- Level 2 - PARTITION BY
-- Show each sale along with the total sales of its region.

select *,
	 sum(amount) over(partition by region)as total_per_regionsales
from s5;

-- Show each sale along with the average sales amount of its region.

select *,
      avg(amount) over(partition by region)as avg_sales
from s5;

-- Show each sale along with the maximum and min sale amount in its region.

select *,
      max(amount) over(partition by region)as max_sales,
      min(amount) over(partition by region)as min_sales
from s5;

-- Show each sale along with the number of sales made in its region.
select *,
     count(*) over(partition by region)as count_sales
from s5;

-- Level 3 - ROW_NUMBER()

-- Assign row numbers based on highest amount.

select *,
      row_number() over(order by amount desc)as highest_amount
from s5;

-- Assign row numbers within each region based on highest sale.

select *,
      row_number() over(partition by region order by amount desc)as region_sales
      from s5;
      
-- Find the highest sale from every region.
with highest_salecte as(
select *,
     row_number() over(partition by region order by amount)as region_sales
from s5
)
select *
from highest_salecte
where region_sales = 1;

-- Find the top 2 sales from every region.
with regioncte as(
select *,
   row_number() over(partition by region order by amount)as region_sales
   from s5
)
select * from regioncte
where region_sales in (1,2)

-- Level 4 - RANK()
-- Rank all sales based on amount.

select *,
      rank() over (order by amount)as ranky
from s5;

-- Rank sales within each region.

select *,
     rank() over(partition by region order by amount)as region_sales_rank
from s5;

-- Find the second highest sale in each region.
with regioncte as(
select *,
      rank() over(partition by region order by amount)as region_stack
from s5
)
select * from regioncte
where region_stack = 2


-- Level 5 - DENSE_RANK()

-- Assign dense rank based on sale amount.

select *,
    dense_rank() over(order by amount desc)as sales_rank
from s5;


-- Find the third highest sale in the company.

with third_cte as(
select *,
      dense_rank() over(order by amount desc)as rn1
from s5
)
select * from third_cte
where rn1 = 3

-- Find the highest sale from each region using DENSE_RANK().

with high_cte as(
select *,
      dense_rank() over(partition by region order by amount desc)as rn1
from s5)
select * from high_cte
where rn1 = 1

-- Level 6 - NTILE()

-- Divide all sales into 2 groups.
 
 select *,
      ntile(2) over()as sales
from s5;

-- Divide all sales into 3 groups.

select *,
 ntile(3) over()as sales
from s5;

-- Label each group as High, Medium, or Low using CASE.
with rank_cte as(
select *,
      ntile(3) over() as ranking
from s5
)
select *,
	case 
    when ranking = 1 then 'high'
    when ranking = 2 then 'medium'
    else 'low'
    end as ranks
from rank_cte




select *,
     
      case  ntile(3) over()
      when 1 then 'high' 
      when 2 then 'medium'
      else 'low'
      end as ranks
from s5

-- Level 7 - LAG()
-- Display previous sale amount for every sale ordered by date.

select *,
      lag(amount) over(order by sale_date)as prious_sale
      from s5;
      
-- Show the difference between current sale and previous sale.
select *,
     lag(amount) over(order by sale_date)as previous_sale,
     amount - coalesce(lag(amount) over(order by sale_date),0) as current_sales
	from s5;
    
-- Display only the rows where the sale amount increased
 -- compared to the previous sale.

with inccte as(
select *,
	lag(amount) over(order by sale_date)as prv,
    amount - coalesce(lag(amount)over(order by sale_date),0) as diff
from s5
)
select * from inccte
where diff > prv;

-- Level 8 - LEAD()
/*Display next sale amount.

Find the difference between current sale and next sale.

Show only the rows where the next sale is greater than the current*/

select *,
	lead(amount) over(order by sale_date)as leading_value
from s5;

select *,
	lead(amount) over(order by sale_date)as next_sale,
   coalesce(lead(amount) over(order by sale_date),0) - amount as diff
from s5;

with diff_cte as(
select *,
      lead(amount) over(order by sale_date)as next_sale,
      coalesce(lead(amount) over(order by sale_date),0) - amount as diff
from s5
)
select * from diff_cte 
where diff > amount



/*Level 9 - FIRST_VALUE(), LAST_VALUE(), NTH_VALUE()

Display the first sale amount in the company beside every row.

Display the last sale amount beside every row.

Display the second highest sale amount beside every row using NTH_VALUE().*/


select *,
     first_value(amount) over()as first_va,
     last_value(amount) over()as last_vl
from s5;

select *,
nth_value(amount,3) over(order by amount desc)as second_vl
from s5;

/*Level 10 - Running Total
Calculate the running total of sales ordered by date.

Calculate the running total separately for each region.

Calculate the running average.*/

SELECT *,
       SUM(amount) OVER (ORDER BY sale_date) AS running_total
FROM s5;

select *,
    sum(amount) over(order by sale_date , sale_id 
     rows between unbounded preceding and current row)as running_total 
from s5


select *,
sum(amount) over(partition by region
                order by sale_date , sale_id
				rows between unbounded preceding and current row
                )as running
from s5;


select *,
avg(amount) over(
                 order by sale_date,sale_id
                 rows between unbounded preceding and current row
                 )as running_avg
from s5;
