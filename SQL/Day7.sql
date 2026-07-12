use amu;
select * from insurance;
select * from client;
select * from agent;
select * from policy;

select * from information_schema.table_constraints;
desc insurance;

create table cust1i (

custi_id int auto_increment primary key,
first_name varchar(100) not null,
last_name varchar(100) not null ,
addr  varchar (100)not null ,
city varchar(100)not null ,
state_provience varchar(100) not null ,
postal_code varchar(100) not null,
phne_no  varchar(20) not null unique ,
email varchar(20) not null unique ,
pan_card varchar(10) unique ,
adhaar_card bigint not null unique

);

truncate  cust1i;

create table transaction1 (
transaction_id bigint auto_increment primary key,
account_id int not null, 
transaction_type varchar(50) not null check (transaction_type in ('Deposit', 'Withdrawal', 'Transfer_In', 'Transfer_Out', 'Bill_Payment', 'Fee')),
amount decimal not null check (amount> 0),
transaction_date datetime not null default current_timestamp,
description_data varchar(255) ,
reference_no varchar(100)


);


INSERT INTO transaction1
(transaction_id, account_id, transaction_type, amount, transaction_date, description_data, reference_no)
VALUES
(1001, 201, 'Deposit',      25000.00, '2026-01-10 09:15:00', 'Salary Credited',          'UTR100001'),

(1002, 201, 'Withdrawal',    5000.00, '2026-01-12 11:30:00', 'ATM Withdrawal',           'ATM100002'),

(1003, 202, 'Transfer_In',  12000.00, '2026-01-13 15:20:00', 'Transfer from Rahul',      'UTR100003'),

(1004, 203, 'Transfer_Out',  7000.00, '2026-01-14 18:40:00', 'Transfer to Amit',         'UTR100004'),

(1005, 204, 'Bill_Payment',  3200.00, '2026-01-15 20:10:00', 'Electricity Bill',         'BILL100005'),

(1006, 205, 'Fee',            250.00, '2026-01-16 09:45:00', 'Annual Maintenance Fee',   NULL),

(1007, 201, 'Deposit',      15000.00, '2026-01-18 13:25:00', 'Cash Deposit',             'UTR100007'),

(1008, 202, 'Withdrawal',    8000.00, '2026-01-20 17:10:00', 'Cash Withdrawal',          'ATM100008'),

(1009, 203, 'Deposit',      50000.00, '2026-01-22 10:50:00', 'Business Income',          'UTR100009'),

(1010, 204, 'Transfer_In',  10000.00, '2026-01-24 14:30:00', 'Transfer from Company',    'UTR100010');


select * from transaction1;

select transaction_id, amount , transaction_date from transaction1;

select * from transaction1 where transaction_type = 'Deposit';
select * from transaction1 where transaction_type = 'Withdrawal';
select * from transaction1 where amount>10000;
select * from transaction1 where amount<5000;
select * from transaction1 where account_id = 201;
select * from transaction1 where transaction_date  between '2026-1-10' and '2026-1-21';
select * from transaction1 where description_data like 't%'
select * from transaction1 order by amount desc;


select sum(amount)  from transaction1 where transaction_type = 'deposit' ;
select sum(amount) from transaction1 where transaction_type = 'withdrawal'
select avg(amount) from transaction1 
select max(amount) from transaction1;
select min(amount) from transaction1;

select count(*) from transaction1;
select count(*) from transaction1 where transaction_type = 'deposit'
select transaction_type,count(*) from transaction1 group by transaction_type;
select transaction_type,sum(amount) from transaction1 group by transaction_type;
select account_id from transaction1 where amount > 30000 group by account_id 


