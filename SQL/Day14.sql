-- numeric function 
round 
floor
ceil
mod
power 
sort
abs


CREATE TABLE opps (
    order_id INT,
    customer_id INT,
    order_amount DECIMAL(10,2),
    discount DECIMAL(5,2),
    items INT
);

INSERT INTO opps VALUES
(1, 101, 123.4567, 5.25, 3),
(2, 102, 89.99,    10.00, 2),
(3, 103, 250.75,   0.00,  5),
(4, 104, 49.10,    2.50,  1),
(5, 105, -75.50,   0.00,  4);

select * from opps
/*You are working with an orders table where order_amount
 has values with more than 2 decimal places. Write a query
 to round the order_amount to 2 decimal places for reporting purposes.*/
 
select round(order_amount,2) from opps; 

-- In the orders table, management wants to bucket order amounts
 into whole numbers by always rounding down. Write a query to
 return the floored value of order_amount.
 
 select floor(order_amount) from opps

/* A cloud billing system charges customers in whole GBs. 
Given a column storage_used with decimal values,
 write a query to round up the usage to the nearest integer using CEIL()
*/

select *,
 ceil(order_amount)  as storage_used
from opps

-- You need to distribute orders across 3 database shards/paritions 0 1 2 
--  based on order_id - mod(order_amount,3)
-- Write a query using MOD() to assign each order to a shard.

select *,
     mod(order_id,3)as shards
from opps


/*Level 1 (Easy)
Q1. Display the order_amount rounded to the nearest whole number.*/
select *,
round(order_amount) as whole_num
from opps

-- Round order_amount to 1 decimal place.
select *,
round(order_amount,1)
from opps

-- Q3. Show the floor value of every order_amount.

select *,
floor(order_amount)
from opps

-- Q4. Show the ceiling value of every order_amount.

select *,
ceil(order_amount)
from opps

-- Q5. Display the absolute value of order_amount.
select *,
      abs(order_amount)
from opps

-- Q6. Find the remainder when items is divided by 2.
select *,
mod(items,2)
from opps
where mod(items,2) = 0

-- Identify whether each order has an Even or Odd number of items using MOD().
select * from opps

select *,
case 
    when mod(items,2) = 0 then 'even'
    else 'odd'
end as type_ 
from opps;

-- Q8. Display the square of the items column.

select * ,
       -- (items * items) 
       power(items,2) -- power(number,exponent)
from opps

-- Q9. Display the cube of items.

select *,
     power(items,3)as cube_
from opps

-- Q10. Display the square root of items.
select *,
    sqrt(items)
from opps

/*Level 3 (Intermediate)
Q11. Round the discount to 0 decimal places.

*/

select *,
     floor(discount)as discount
from opps

-- Q12. Calculate the order amount after discount.


select *,
     floor(discount)as discount,
     ceil(order_amount)as amount,
     ceil(order_amount) + floor(discount) as total_amount
from opps
 
 abs
 
 select *,
     floor(discount)as discount,
	order_amount + floor(discount) as total_amount
    
from opps
 
 
 
