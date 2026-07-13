SELECT * FROM insurance;
select * from client;
select * from agent;
select * from policy;

/*Find the first and last names of the clients
 who don't have a city name and were born in 2000 or later.
 CLIENT LT AND POLICY RB    TYT ID AND CLIENT_ID PK 
 LEFT ANTI NULL 
 */

SELECT DISTINCT C.FIRST_NAME ,  C.LAST_NAME, C.CITY ,C.BIRTH_DATE 
FROM CLIENT C LEFT JOIN POLICY P
ON C.ID=P.CLIENT_ID 
WHERE CITY IS NULL AND C.BIRTH_DATE > '2000'

/* Write a SQL query showing the name of each insurance and
 the number of clients that have purchased that insurance.
 I  INSURANCE NAME,ID   AND     P  POLICY TABLE INSURANCE_ID GROUP BY 
*/

SELECT I.NAME, COUNT(P.CLIENT_ID) AS TOTAL_CLIENT 
FROM INSURANCE I  JOIN POLICY P 
ON I.ID = P.INSURANCE_ID
GROUP BY I.NAME
ORDER BY I.NAME;

/*
For clients born in or after 2000 that have home insurance, 
show their first and last names and
their annual fee. Sort records in ascending order by annual fee.
M CLIENT ID =      BIRTH_DATE >= '2000' 4 HOMEINSU       C POLICY CLIENT_ID
*/

SELECT C.FIRST_NAME,C.LAST_NAME,C.BIRTH_DATE,P.INSURANCE_ID ,P.ANNUAL_FEE 
FROM CLIENT C JOIN POLICY P
ON C.ID = P.CLIENT_ID 
WHERE C.BIRTH_DATE >= '2000' AND INSURANCE_ID = 4
ORDER BY ANNUAL_FEE desc

/*For agents who have sold 2 policies or less,
 show their name and the number of policies each has sold.
 AGENT ID  FIRST_NAME,LAST_NAME       POLICY AGENT_ID   ,POLICY_NUMBER 
 
 */
 
SELECT A.FIRST_NAME,COUNT(P.ID) AS TOTAL_POLICIES
FROM AGENT A JOIN POLICY P
ON A.ID = P.AGENT_ID
GROUP BY A.FIRST_NAME
HAVING COUNT(P.ID)<=2

/*
Select the first and last name of each client
 who bought a car insurance policy.
 Add the fee column with the value 'high' if the annual fee is higher than 1000;
 the value 'medium' if the annual fee is higher than 500,
 and the value 'low' in all other cases.


 CLIENT FIRST_NAME,LAST_NAME ID  POLICY CLIENT_ID
FEE COLUMN 1000> HIGH 500>MEDIUM REST LOW 
*/

SELECT C.FIRST_NAME,C.LAST_NAME,P.INSURANCE_ID,P.ANNUAL_FEE,
CASE
	WHEN P.ANNUAL_FEE >=1000 THEN 'HIGH'
    WHEN P.ANNUAL_FEE >=500 THEN 'MEDIUM'
    ELSE 'LOW'
END AS FEE
FROM CLIENT C JOIN POLICY P
ON C.ID=P.CLIENT_ID
WHERE P.INSURANCE_ID =5
ORDER BY P.ANNUAL_FEE DESC;

/*
Find the names of all insurance policies
 that were sold by agents who live in the city 'London'.
 
 M POLICY AGENT_ID/         C AGENT ID/ 
 P.POLICY_NUMBER , C CITY
*/
 
 SELECT  P.POLICY_NUMBER , A.CITY
 FROM POLICY P JOIN AGENT A 
 ON P.AGENT_ID = A.ID
 WHERE A.CITY = 'Annandale'
 
 
 /* List the first name, last name, and birth date
 of clients who have purchased more than two insurance policies.
 
 CLIENT ID FIRST_NAME , LAST_NAME, BIRTH_DATE
 POLICY CLIENT_ID 
 
 */ 
 
SELECT C.FIRST_NAME , C.LAST_NAME, C.BIRTH_DATE ,COUNT(P.ID) 
FROM CLIENT C JOIN POLICY P
ON C.ID = P.CLIENT_ID 
GROUP BY C.ID, C.FIRST_NAME , C.LAST_NAME, C.BIRTH_DATE 

/*  Find the first and last names of agents
 who have not sold any insurance policies.

AGENT ID FIRST_NAME , LAST_NAME 
POLICY WHERE AGENT_ID IS NULL       LEFT ANTI 
*/

SELECT A.FIRST_NAME,A.LAST_NAME
FROM AGENT A LEFT JOIN POLICY P
ON A.ID = P.AGENT_ID
WHERE P.AGENT_ID IS NULL


 
