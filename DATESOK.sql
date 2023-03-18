--2. Select the last day of the present month. Clues:
--Postgresql: date_trunc, interval, now
--Mariadb: last_day, now

--POSTGRES 
SELECT to_char(date_trunc('month', now()) + INTERVAL '1 month - 1 day', 'YYYY-MM-DD') as myday;

--MARIADB

SELECT LAST_DAY(now()) as myday;

--3. Select the last day of the month three months before today. Clues:
--Postgresql: date_trunc, now, interval
--Mariadb: last_day, date_sub, now, interval

--POSTGRES
SELECT to_char(date_trunc('month', now() - INTERVAL '3 months') + INTERVAL '1 month - 1 day', 'YYYY-MM-DD') as myday;

--MARIADB
SELECT LAST_DAY(DATE_SUB(NOW(), INTERVAL 3 MONTH)) as myday;


--4. Show the date of exercise 3 with format “Name_of_month day, year with 2 digits”. Clues:
--Postgresql: Same ex. 3 + to_char
--Mariadb: Same ex. 3 + date_format


--POSTGRES

SELECT to_char(date_trunc('month', now() - INTERVAL '3 months') + INTERVAL '1 month - 1 day', 'Month DD, YY') as myday;

--MARIADB
SELECT DATE_FORMAT((LAST_DAY(DATE_SUB(NOW(), INTERVAL 3 MONTH))), '%M %d, %y') as myday;


--Convert the current date/time to Panama time zone. Clues:
--Postgresql: https://popsql.com/learn-sql/postgresql/how-to-convert-utc-to-local-time-zone-in-postgresql
--Mariadb: https://mariadb.com/kb/en/mysqltime_zone_name-table/


--POSTGRES

SELECT 
  TO_CHAR(current_timestamp, 'YYYY-MM-DD HH:MI:SS') AS madrid, 
  TO_CHAR(current_timestamp AT TIME ZONE 'America/Panama', 'YYYY-MM-DD HH:MI:SS') AS panama_time;



--MARIADB

SELECT NOW() AS 'Hora Actual', CONVERT_TZ(NOW(), 'UTC', 'America/Panama') AS 'Hora en Panamá';


--LO MISMO CON SIDNEY

--POSTGRES
SELECT TO_CHAR(CURRENT_TIMESTAMP, 'YYYY-MM-DD HH24:MI:SS') AS "Hora Actual",
       TO_CHAR(CURRENT_TIMESTAMP AT TIME ZONE 'UTC' AT TIME ZONE 'Australia/Sydney', 'YYYY-MM-DD HH24:MI:SS') AS "Hora en Sidney";


--MARIADB

SELECT NOW() AS 'Hora Actual', CONVERT_TZ(NOW(), 'UTC', 'Australia/Sydney') AS 'Hora en Sidney';


--7. Subtract 3 hours 25 minutes to the current date/time. Clues:
--Postgresql: now, -, interval
--Mariadb: date_sub, now, interval

--POSTGRES
SELECT TO_CHAR(NOW() - INTERVAL '3 hours 25 minutes', 'YYYY-MM-DD HH24:MI:SS') as myday;


--MARIADB
SELECT DATE_FORMAT(NOW() - INTERVAL 3 HOUR - INTERVAL 25 MINUTE, '%Y-%m-%d %H:%i:%s') as myday;




--8. Difference in days between the employee who started in the first place and the employee who started in the last place. Clues:
--Postgresql: extract, now
--Mariadb: day_of_year, now


--POSTGRES
SELECT EXTRACT(DAY FROM NOW() - MIN(start_date)) - EXTRACT(DAY FROM NOW() - MAX(start_date)) AS myday
FROM employees;


--MARIADB

SELECT DATEDIFF(NOW(), MIN(start_date)) - DATEDIFF(NOW(), MAX(start_date)) AS myday
FROM employees;

SELECT DAYOFYEAR(NOW()) - MIN(DAYOFYEAR(start_date)) - (DAYOFYEAR(NOW()) - MAX(DAYOFYEAR(start_date))) AS day_difference
FROM employees;


--9. Select the dates inside the field employees.start_date that is Tuesday. Clues:
--Postgresql: extract
--Mariadb: dayofweek

--POSTGRES

SELECT surname,name,start_date FROM employees
WHERE extract(dow FROM start_date) = 2;


--MARIADB

SELECT surname,name,start_date FROM employees
WHERE dayofweek(start_date) = 3; -- 3 means Tuesday



Select the oldest employee in the enterprise. Clues: ORDER BY and LIMIT.

-- PostgreSQL and MariaDB
SELECT * FROM employees
ORDER BY start_date asc  
LIMIT 1; 

---Select the employees’ name, surname, and years and months working in our enterprise (order by those years and months descendent). Clues:
--Postgresql: date_part, age
--Mariadb: timestampdiff, now, % 12


--POSTGRES
SELECT name, surname,
date_part('year', age(now(), start_date)) AS years,
date_part('month', age(now(), start_date)) AS months
FROM employees
ORDER BY years DESC, months DESC;

--MARIADB

SELECT name, surname,
timestampdiff(YEAR, start_date, now()) AS years,
timestampdiff(MONTH, start_date, now()) % 12 AS months 
FROM employees
ORDER BY years DESC, months DESC; 



-- Write a query to show employees.start_date in three columns: year, month and day. Clues:
--Postgresql: date_part
--Mariadb: year, month, day


--POSTGRES
SELECT date_part('year', start_date) AS year,
date_part('month', start_date) AS month,
date_part('day', start_date) AS day
FROM employees
order by year ASC,month ASC, day ASC;


--MARIADB
SELECT year(start_date) AS year,
month(start_date) AS month,
day(start_date) AS day
FROM employees
order by year ASC,month ASC, day ASC;


--Write a query to show the employees that joined the enterprise in June. Clues:
--Postgresql: trim(to_char())
--Mariadb: monthname

--POSTGRES



SELECT SURNAME,NAME,start_date FROM employees
WHERE trim(to_char(start_date, 'Month')) = 'June'; 

--MARIADB

SELECT SURNAME,NAME,START_DATE FROM employees
WHERE monthname(start_date) = 'June';


Write the date of the last exercise with the following format surname,name, start_date. Clues:
Postgresql: trim(to_char())
Mariadb: monthname

--POSTGRES

SELECT SURNAME, NAME, to_char(start_date,'D DD Month YYYY') AS start_date FROM employees
WHERE trim(to_char(start_date,'Month')) = 'June';

--MARIADB

SELECT SURNAME, NAME, DATE_FORMAT(start_date, '%W %d %b %Y %T') AS start_date FROM employees
WHERE monthname(start_date) = 'June';


--Write a query to get the year and number of employees who started working that year. Sort the results by year. Clues:
--Postgresql: extract, count
--Mariadb: year, count

--POSTGRES
SELECT EXTRACT(YEAR FROM start_date) AS year, COUNT(*) AS num_employees
FROM employees
GROUP BY year
ORDER BY year;


--MARIADB

SELECT YEAR(start_date) AS year, COUNT(*) AS num_employees
FROM employees
GROUP BY year
ORDER BY year;

--Write a query to get the minimum number of employees
-- who started working in our enterprise in a single year. 
--Sort the results by year (desc). Clue: HAVING COUNT(*) = (SUBSELECT).


SELECT EXTRACT(YEAR FROM start_date) AS year, COUNT(*) AS num_employees
FROM employees
GROUP BY year
HAVING COUNT(*) = (
  SELECT MIN(count) FROM (
    SELECT COUNT(*) AS count
    FROM employees
    GROUP BY EXTRACT(YEAR FROM start_date)
  ) AS subquery1
)
ORDER BY year DESC;


--Write a query to get the year in which more employees joined our enterprise. Clue: Very similar to the last exercise.

SELECT EXTRACT(YEAR FROM start_date) AS year, COUNT(*) AS num_employees
FROM employees
GROUP BY year
HAVING COUNT(*) = (

  SELECT MAX(count) FROM (
    SELECT COUNT(*) AS count
    FROM employees
    GROUP BY EXTRACT(YEAR FROM start_date)
  ) AS t
);


-- Show employees who are manager of other employees and the time in years that they are working in the enterprise. Sort the results by year (desc).


-- Asumiendo que la tabla se llama employees y tiene las columnas employee_id, name, surname y start_date
-- Asumiendo también que hay otra tabla llamada managers que tiene las columnas employee_id y manager_id

--postgres

SELECT e.num, e.name, e.surname, ROUND(EXTRACT(YEAR FROM AGE(CURRENT_DATE, start_date))) AS years
FROM employees e
WHERE e.num IN (SELECT DISTINCT manager FROM employees)
ORDER BY years DESC;


--MARIADB

SELECT e.num, e.name, e.surname, ROUND(DATEDIFF(CURDATE(), start_date) / 365, 0) AS years
FROM employees e
WHERE e.num IN (SELECT DISTINCT manager FROM employees)
ORDER BY years DESC;



--Show employees who are manager of other employees working in the enterprise for more than 5 years. Clue: Very similar to the last exercise. 



--POSTGRES

SELECT e.num, e.name, e.surname, ROUND(EXTRACT(YEAR FROM AGE(CURRENT_DATE, start_date))) AS years
FROM employees e
WHERE e.num IN (SELECT DISTINCT manager FROM employees)
AND start_date < CURRENT_DATE - INTERVAL '5 YEAR'
ORDER BY years DESC;


--MARIADB
SELECT e.num, e.name, e.surname, ROUND(DATEDIFF(CURDATE(), start_date) / 365, 0) AS years
FROM employees e
WHERE e.num IN (SELECT DISTINCT manager FROM employees)
AND start_date < DATE_SUB(CURDATE(), INTERVAL 5 YEAR)
ORDER BY years DESC;









--extraer hora 

SELECT EXTRACT(HOUR FROM end_datetime) AS hour, COUNT(*) AS count
FROM your_table
GROUP BY hour
ORDER BY hour;

--extraer dia

SELECT EXTRACT(DAY FROM end_datetime) AS day, COUNT(*) AS count
FROM your_table
GROUP BY day
ORDER BY day;


--extraer mes

SELECT EXTRACT(MONTH FROM end_datetime) AS month, COUNT(*) AS count
FROM your_table
GROUP BY month
ORDER BY month;
