create table courses(
course_id int primary key,
course_name varchar(30),
course_fee int 
);

insert into courses values 
(1,'mysql',5000),
(2,'python',5000),
(3,'hadoop',3000),
(4,'pyspark',7000);


create table studentss(
student_id int primary key,
student_name varchar(40),
course_id int ,
foreign key (course_id) references courses(course_id)
);

insert into studentss values 
(101,'A',1),
(102,'B',2),
(103,'C',2),
(104,'D',NULL),
(105,'E', 4);

select * from courses;
select * from studentss;

select c.course_id,c.course_name,s.student_name
from  courses c inner join studentss s 
on c.course_id = s.course_id;

select c.course_name , s.student_name
from courses c left join studentss s 
on c.course_id = s.course_id;

select s.student_name, c.course_name 
from courses c right join studentss s
on c.course_id = s.course_id ;

select c.*, s.*
from courses c left join studentss s
on c.course_id = s.student_id
union
select c.*,s.*
from courses c right join studentss s 
on c.course_id = s.student_id

select * from courses;
select * from studentss 

select distinct c.*
from courses c inner join studentss s
on c.course_id = s.course_id;


select c.*
from courses c left join studentss s
on c.course_id = s.course_id
where s.course_id is null;

select s.*
from courses c right join studentss s
on c.course_id = s.course_id
where c.course_id is null;

create table eee(
id int null
);
insert into eee values
(1),
(1),
(2),
(null),
(null); 


create table ch(
id int null
);
insert into ch values (1),(3),(null);


select * 
from  eee e inner join ch c
on e.id =c.id;

select e.*,c.*
from eee e left join ch c
on e.id= c.id;

select e.*,c.*
from eee e right join ch c
on e.id=c.id;

select e.* , c.*
from eee e left join ch c
on e.id = c.id
union
select e.*,c.*
from eee e right join ch c
on e.id = c.id;

create table demo (
id varchar(20) null,
name varchar(30)
);

insert into demo values 
('a','ram'),
('b','raj'),
('','blank'),
('null','string null'),
(null,'sql null');

select * from demo;

create table demo2(
id varchar(40)  null,
course varchar(50)
);

insert into demo2 values 
('a','MYSQL'),
('b','PYTHON'),
('','SPARK'),
('null','HADOOP'),
(NULL,'POWER BI');

SELECT * FROM DEMO2

-- INNER JOIN 4
SELECT D.*,D2.*
FROM DEMO D INNER JOIN DEMO2 D2
ON D.ID=D2.ID;

-- LEFT JOIN
SELECT D.*
FROM DEMO D LEFT JOIN DEMO2 D2
ON D.ID=D2.ID;

-- RIGHT JOIN
SELECT D2.*
FROM DEMO D RIGHT JOIN DEMO2 D2
ON D.ID=D2.ID;

-- FULL OUTER JOIN
SELECT D.*,D2.*
FROM DEMO D LEFT JOIN DEMO2 D2
ON D.ID=D2.ID
UNION
SELECT D.*,D2.*
FROM DEMO D RIGHT JOIN DEMO2 D2
ON D.ID=D2.ID;

-- LEFT SEMI
SELECT DISTINCT D.*
FROM DEMO D INNER JOIN DEMO2 D2
ON D.ID=D2.ID

-- RIGHT SEMI 
SELECT DISTINCT D2.*
FROM DEMO D INNER JOIN DEMO2 D2
ON D.ID=D2.ID

-- LEFT ANTI
SELECT D.*
FROM DEMO D LEFT JOIN DEMO2 D2
ON D.ID=D2.ID
WHERE D2.ID IS NULL;

-- RIGHT ANTI 
SELECT D2.*
FROM DEMO D RIGHT JOIN DEMO2 D2
ON D.ID = D2.ID
WHERE D.ID IS NULL;



CREATE TABLE PERSI(
PERSON_ID INT,
FIRST_NAME VARCHAR(39),
LAST_NAME VARCHAR(50)
);
INSERT INTO PERSI VALUES
(1,'ARJUN','DOE'),
(2,'AMEY','GUJAR'),
(3,'ROHAN','HANJE');
SELECT * FROM PERSI

CREATE TABLE Address(
ADDR_ID INT, 
PERSON_ID INT,
CITY VARCHAR(50),
STATE VARCHAR(60)
);
INSERT INTO Address VALUES
(101,1,'NEW YORK','NY'),
(102,2,'CHICAGO','IL');

-- LEFT JOIN BECZ IT DISPLAY WHOLE DATA MASTER TABLE AND WHOSE VALUE IS MISSING IT ASSIGN NULL VALUE AUTOMATICALLY
SELECT P.FIRST_NAME,P.LAST_NAME,A.CITY,A.STATE
FROM PERSI P LEFT JOIN ADDRESS A
ON P.PERSON_ID=A.PERSON_ID

CREATE TABLE CustI1 (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);
INSERT INTO CustI1 (customer_id, first_name, last_name)
VALUES
(1, 'John', 'Doe'),
(2, 'Jane', 'Smith'),
(3, 'Bob', 'Johnson'),
(4, 'Alice', 'White');



CREATE TABLE OrD2 (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATETIME NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES CustI1(customer_id)
);
INSERT INTO OrD2 (order_id, customer_id, order_date)
VALUES
(101, 1, '2022-07-01 10:00:00'),
(102, 3, '2022-07-05 12:30:00');

SELECT * FROM CustI1
SELECT * FROM OrD2

-- LEFT ANTI JOIN WHERE CUSTOMER_ID IS NULL

SELECT C.*
FROM CustI1 C LEFT JOIN OrD2 O2
ON C.CUSTOMER_ID = O2.CUSTOMER_ID 
WHERE O2.CUSTOMER_ID IS NULL

CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);
INSERT INTO Users (user_id, name)
VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'John');

CREATE TABLE Rides (
    ride_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    distance INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
INSERT INTO Rides (ride_id, user_id, distance)
VALUES
(101, 1, 50),
(102, 2, 100),
(103, 1, 70),
(104, 3, 100),
(105, 2, 50),
(106, 3, 30);

SELECT * FROM RIDES
SELECT * FROM USERS


-- RIGHT JOIN GROUP BY USER_ID AGGREGATE SUM DISTANCE

SELECT U.NAME , SUM(R.DISTANCE) AS TRAVELLED_DISTANCE 
FROM USERS U  RIGHT JOIN RIDES R
ON  U.USER_ID = R.USER_ID 
GROUP BY U.NAME
ORDER BY TRAVELLED_DISTANCE DESC;


CREATE TABLE Accounts (
    account INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);
INSERT INTO Accounts (account, name)
VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie');

CREATE TABLE Transactions (
    trans_id INT PRIMARY KEY,
    account INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (account) REFERENCES Accounts(account)
);
INSERT INTO Transactions (trans_id, account, amount)
VALUES
(101, 1, 5000),
(102, 2, 12000),
(103, 3, -3000),
(104, 1, 7000),
(105, 2, -1000),
(106, 3, 15000);

SELECT * FROM Accounts
SELECT * FROM  Transactions

-- the name and balance of users with a balance greater than 10,000. ACCOUNT 


SELECT A.NAME , SUM(T.AMOUNT) AS BALANCE 
FROM ACCOUNTS A  JOIN TRANSACTIONS T
ON A.ACCOUNT=T.ACCOUNT 
GROUP BY A.NAME
HAVING SUM(T.AMOUNT) > 10000;
