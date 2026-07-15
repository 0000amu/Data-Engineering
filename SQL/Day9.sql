use amu;
select * from doctor;
select * from patitent;
select * from visit;
insert into doctor (id,full_name)values (17,'sarvesh');
insert into patitent (id,full_name)values (17,'sarvesh');

/*The clinic manager wants to know 
how many patients each doctor attended every day
. Display only those days where a doctor handled at least two visits.

m doctor                 id 
m patitent 13  id 
c visit     patient_id   doctor_id


20date la  1doc ni  4 jannana la bgitla  \

*/

select  v.visit_date ,
		v.doctor_id ,
		count(v.patient_id)as total_patient 
from patitent p  join visit v
on p.id= v.patient_id
group by  v.visit_date ,v.doctor_id
having count(v.patient_id)>=2;

/* Find the average rating of doctors
 who have treated at least 5 different patients.
 
doctor id full_name type price_per visit
visit doctor_id ,patient_id 

*/

select d.full_name, AVG(d.rating) AS avg_rating
from doctor d inner join visit v
on d.id = v.doctor_id 
group by d.id ,d.full_name
having count(distinct v.patient_id) >= 5
order by avg_rating desc ;

/*Identify the doctor who has treated
 the highest number of unique patients. distinct 
 doctor id
 visit  doctor_id
 
*/

select d.full_name,
	 count(distinct v.patient_id)
from doctor d 
join visit v
on d.id = v.doctor_id 
group by d.full_name ,d.full_name
ORDER BY COUNT(DISTINCT v.patient_id) DESC
LIMIT 1;



/* 4 Generate a report showing 
the total revenue earned by each doctor 
based on the number of visits and the consultation fee.
doctor id | full_name,price_per_visit 
visit doctor_id | visit_date 
*/
select v.doctor_id ,
	   d.full_name ,
	   sum(d.price_per_visit) as total_revenue 		
from doctor d
join visit v
on d.id = v.doctor_id
group by d.full_name ,d.price_per_visit, v.doctor_id
order by doctor_id 

/* 5. Find patients who have consulted more than one doctor.
patitent id |
visit patitent_id |
*/


select p.full_name ,count(distinct v.doctor_id)
from patitent p
join visit v
on p.id = v.patient_id 
group by p.full_name,p.id 
having count(distinct v.doctor_id) >1
ORDER BY COUNT(distinct v.doctor_id) DESC

/* Find the city where the highest number of doctors
 are currently practicing.

doctor id doctor| count(city) group by city  
*/

select city,count(city) as total_doctor
from doctor
group by city
order by total_doctor desc limit 1;

/* Generate a report of the Top 3 doctors  order by price limit 3 
 who generated the highest revenue.
 
 doctor id |full_name, price_per_visit 
 visit  doctor_id | patient_id , doctor_id  groupby visit _date
*/

select d.id , sum(d.price_per_visit)
from doctor d
join visit v
on d.id = v.doctor_id 
group by d.id , d.price_per_visit
order by sum(d.price_per_visit) desc limit 3



/* Identify doctors who have never been visited by any patient.
doctor 
visit 
*/

select d.id,d.full_name , v.patient_id
from doctor d
left join visit v
on d.id = v.doctor_id 
where v.patient_id is null

/* Find all patients who have not booked any appointment.
patitent  id 
visit patient_id 
*/

 select p.id,p.full_name 
 from patitent p 
 left join visit v
 on p.id = v.patient_id
 where v.id is null

/* Display every doctor along with the number
 of unique patients they have treated.
doctor id full_name 
visit doctor_id , distinct patient_id 
*/

select d.full_name , count(distinct v.patient_id ) as unique_pat
from doctor d 
join visit v
on d.id = v.doctor_id 
group by d.id ,d.full_name


/* Classify doctors based on total visits.
Excellent (10 or more visits) 
Good (5–9 visits) 
Needs Improvement (Less than 5 visits)
doctor  id 
visit  doctor_id 

 */
 
 select 
	    d.full_name,
           case 
               when count(distinct v.patient_id) >= 10 then 'exellent'
               when count(distinct v.patient_id) >= 5 then 'good'
               else 'need improvement'
           end as 'performance'
 from doctor d
 left join visit v
 on d.id = v.doctor_id 
 group by d.id , d.full_name; 
 
 /* Classify patients based on the number of visits.
Frequent Patient 
Regular Patient 
New Patient

patitent id
visit patient id 
 
 */ 
 
 select p.full_name, 
        case
            when count(doctor_id) between 2 and 5 then 'frequent' 
            when count(doctor_id)> 5 then 'regular'
            else 'new patient'
        end as 'frequency'
 from patitent p
 join visit v
 on p.id = v.patient_id 
 group by p.id,p.full_name;  
 
 /* Find the day when the clinic received
 the maximum number of patient visits. max date 
patitent id | 
visit  doctor_id |
 */
 
select  v.visit_date, count(distinct v.patient_id) as total_visit  
 from patitent p 
 join  visit v 
 on p.id = v.patient_id 
 group by v.visit_date
 order by total_visit desc limit 1;

/* Find patients who visited the same doctor more than three times.
patitent id          doctor_id  patient_id same 
visit    patient_id 

*/

select v.doctor_id ,count(v.visit_date) as total_visit
from patitent p 
join visit v
on p.id = v.patient_id
group by v.doctor_id
having total_visit > 3;

/*
Build a single SQL query to generate the following KPIs:
Total Doctors 
Total Patients 
Total Visits 
Total Revenue 
Average Doctor Rating 
Average Revenue Per Visit 
Highest Revenue Doctor 
Most Visited Doctor

patitient
doctor
visit


select * from doctor;
select * from patitent;
select * from visit;

d- v | p -v 
*/
select p.*,d.*,v.*
from doctor d join visit
on d.id = v.doctor_id
join patitent p
on p.id = v.patient_id 



/*Build a single SQL query to generate the following KPIs:
Total Doctors 
Total Patients 
Total Visits 
Total Revenue 
Average Doctor Rating 
Average Revenue Per Visit 
Highest Revenue Doctor 
Most Visited Doctor

doctor patitent visit 
*/




select  
count(distinct d.id ) as total_doctor,
	    count(distinct p.id) as total_patients,
        count(v.id) as total_visits,
        sum(d.price_per_visit) as total_revenue,
        avg(d.rating) as avg_ratings,
        SUM(d.price_per_visit) / COUNT(v.id) AS avg_revenue_per_visit
        
from doctor d 
join visit v
on d.id = v.doctor_id
join patitent p 
on p.id = v.patient_id


SELECT
    d.full_name,
    SUM(d.price_per_visit) AS revenue
FROM doctor d
JOIN visit v
ON d.id = v.doctor_id
GROUP BY d.id, d.full_name
ORDER BY revenue DESC
LIMIT 1;


SELECT
    d.full_name,
    COUNT(v.id) AS total_visits
FROM doctor d
JOIN visit v
ON d.id = v.doctor_id
GROUP BY d.id, d.full_name
ORDER BY total_visits DESC
LIMIT 1;
