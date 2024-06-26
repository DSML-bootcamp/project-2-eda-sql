USE space2;


/*Top 5 companies with more launches*/

SELECT company, COUNT(*)
FROM company
GROUP BY company
ORDER BY COUNT(*) DESC                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
LIMIT 5;                                   
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            

/*Rate of succes, failure */

SELECT SUM(missionstatus = 'Success')*100/COUNT(*) AS rate_of_succes  /*missionstatus = 'Success' is an expresion returning 0 for false 1 for true*/
FROM status;

SELECT SUM(missionstatus = 'Failure')*100/COUNT(*) AS rate_of_failure
FROM status;

/*Difference of Rate of succes/failure in the past dates */

SELECT SUM(missionstatus = 'Failure')*100/COUNT(*) AS rate_of_failure
FROM status
JOIN time ON status.id = time.id
WHERE time.Date >= '1957-10-04' AND time.Date <= '1977-01-01';   /*First 20 years*/


SELECT SUM(missionstatus = 'Failure')*100/COUNT(*) AS rate_of_failure
FROM status
JOIN time ON status.id = time.id
WHERE time.Date >= '2002-07-29' AND time.Date <= '2022-07-29';   /*Last 20 years*/


/*Most used rocket before SpaceX's first launch*/

SELECT Rocket, COUNT(*) AS count
FROM company
JOIN time
ON company.id = time.id
WHERE time.Date < '2006-03-24'
GROUP BY Rocket
ORDER BY count DESC
LIMIT 1;


/*Most used rocket after SpaceX's first launch*/

SELECT Rocket, COUNT(*) AS count
FROM company
JOIN time
ON company.id = time.id
WHERE time.Date >= '2006-03-24'
GROUP BY Rocket
ORDER BY count DESC
LIMIT 1;


SELECT Rocket, counter
FROM(SELECT Rocket, COUNT(*) AS counter,
ROW_NUMBER()OVER (ORDER BY COUNT(*) ASC) AS row_num   /*find the top n rows of every rocket*/
FROM company
JOIN time
ON company.id = time.id
WHERE time.Date >= '2006-03-24'
GROUP BY Rocket) AS ranked
WHERE row_num <= 1;


/*Find the active rockets and their companies*/

SELECT COUNT(company.Rocket), company.Company
FROM company
JOIN status
ON company.id = status.id
WHERE status.RocketStatus = 'Active'
GROUP BY company.Rocket, company.Company;



/*Which country has hosted the most space missions*/

SELECT Country, COUNT(*) AS num_missions
FROM time
GROUP BY Country
ORDER BY num_missions DESC
LIMIT 1;




/*Average cost of missions before SpaceX's first lunch*/

SELECT(
SELECT AVG(price)
FROM company
JOIN time
ON company.id= time.id
WHERE time.Date < '2006-03-24') AS cost_before,
(SELECT AVG(price) 
FROM company
JOIN time
ON company.id= time.id
WHERE time.Date >= '2006-03-24') AS cost_after;


SELECT AVG(price) AS cost_before
FROM company
JOIN time
ON company.id= time.id
WHERE time.Date >= (STR_TO_DATE('2006-03-24', '%Y-%m-%d'));


SELECT 
    (SELECT AVG(price) FROM company JOIN time ON company.id = time.id WHERE time.Date < '2006-03-24') AS cost_before,
    (SELECT AVG(price) FROM company JOIN time ON company.id = time.id WHERE time.Date >= '2006-03-24') AS cost_after;
    
    
    
    SELECT 
    (SELECT AVG(price) 
     FROM company 
     JOIN time ON company.id = time.id 
     WHERE STR_TO_DATE(time.Date , '%Y-%m-%d') < '2006-03-24') AS cost_before,
    (SELECT AVG(price) 
     FROM company 
     JOIN time ON company.id = time.id 
     WHERE STR_TO_DATE(time.Date, '%Y-%m-%d')  >= '2006-03-24') AS cost_after;



SELECT AVG(price) 
FROM company 
JOIN time ON company.id = time.id 
WHERE STR_TO_DATE((time.Date, '%Y-%m-%d')  >= '2006-03-24');
