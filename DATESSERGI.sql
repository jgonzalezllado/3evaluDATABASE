--1. Can you convert a String to a Date and/or Time? Write examples.
--Yes, in MariaDB you can do it with functions STR_TO_DATE. Example:
SELECT STR_TO_DATE('Wednesday, June 2, 2022', '%W, %M %e, %Y');
In Postgesql with :: or the function TO_DATE:
SELECT TO_DATE('Wednesday, June 2, 2022', 'DAY, Month DD, YYYY');
SELECT 'Wednesday, June 2, 2022'::date;

--2. Select the last day of the present month. Clues:
● Postgresql: date_trunc, interval, now
● Mariadb: last_day, now

--postgresql
SELECT (
date_trunc('MONTH', now()) + INTERVAL '1 MONTH - 1 day'
)::date as myday;
--mariadb
SELECT LAST_DAY(NOW()) AS myday;




3. Select the last day of the month three months before today. Clues: 
● Postgresql: date_trunc, now, interval 
● Mariadb: last_day, date_sub, now, interval 
MariaDB PostgreSQL

SELECT ( 
date_trunc('MONTH', now() - INTERVAL '3 MONTH') + INTERVAL '1 MONTH - 1 day' 
)::date as myday; 


--mariadb 
SELECT LAST_DAY(DATE_SUB(NOW(), INTERVAL 3 MONTH)) AS myday;
4. Show the date of exercise 3 with format “Name_of_month day, year with 2 digits”. Clues: ● Postgresql: Same ex. 3 + to_char 
● Mariadb: Same ex. 3 + date_format 
MariaDB PostgreSQL


--postgresql 
SELECT to_char( 
( 
date_trunc('MONTH', now() - INTERVAL '3 MONTH') + INTERVAL '1 MONTH - 1 day' 
)::date, 
'MonthDD, YY' 
) as myday; 
--mariadb 
SELECT DATE_FORMAT( 
LAST_DAY(DATE_SUB(NOW(), INTERVAL 3 MONTH)), 
'%M %d, %y' 
) AS myday; 


5. Convert the current date/time to Panama time zone. Clues: 
● Postgresql: 
https://popsql.com/learn-sql/postgresql/how-to-convert-utc-to-local-time-zone-in-post gresql 
● Mariadb: https://mariadb.com/kb/en/mysqltime_zone_name-table/ 
MariaDB PostgreSQL

--postgresql 
SELECT NOW() As datetime_madrid, 
NOW() at time zone 'America/Panama' As datetime_panama; --mariadb
SELECT NOW() As datetime_madrid, 
CONVERT_TZ(UTC_TIMESTAMP(), 'UTC', 'America/Panama') As date_time; 
6. Do the last exercise converting to the time in Sydney. 
MariaDB PostgreSQL




--postgresql 
SELECT NOW() As datetime_madrid, 
NOW() at time zone 'Australia/Sydney' As datetime_panama; --mariadb 
SELECT NOW() As DateMadrid, 
CONVERT_TZ(UTC_TIMESTAMP(), 'UTC', 'Australia/Sydney') As datesydney; 




7. Subtract 3 hours 25 minutes to the current date/time. Clues: 
● Postgresql: now, -, interval 
● Mariadb: date_sub, now, interval 
MariaDB PostgreSQL

--postgresql 
SELECT NOW() AS now, 
NOW() - INTERVAL '3 HOUR' - INTERVAL '25 MINUTE' AS mytimestamp; --mariadb 
SELECT NOW() AS now, 
DATE_SUB( 
DATE_SUB(NOW(), INTERVAL 3 HOUR), 
INTERVAL 25 MINUTE 
) AS mytimestamp; 





8. Difference in days between the employee who started in the first place and the employee who started in the last place. Clues: 
● Postgresql: MAX, MIN 
● Mariadb: DATEDIFF, MAX, MIN
MariaDB PostgreSQL

--postgresql 
SELECT MAX(E.start_date)- MIN(E.start_date) AS MyDay 
FROM employees E; 
--mariadb 
SELECT DATEDIFF(MAX(E.start_date), MIN(E.start_date)) AS MyDay FROM employees E; 




9. Select the dates inside the field employees.start_date that is Tuesday. Clues: ● Postgresql: extract 
● Mariadb: dayofweek 
MariaDB PostgreSQL

--postgresql 
SELECT E.surname, 
E.name, 
E.start_date 
FROM employees E 
WHERE EXTRACT('DOW' FROM E.start_date) = 2; 
--mariadb 
SELECT E.surname, 
E.name, 
E.start_date 
FROM employees E 
WHERE DAYNAME(E.start_date) = 'Tuesday'; 
--OR 
SELECT E.surname, 
E.name, 
E.start_date 
FROM employees E
WHERE DAYOFWEEK(E.start_date) = 3; 
--The first one depends on the language, so the second one is better… 




10. Select the oldest employee in the enterprise. Clues: ORDER BY and LIMIT. 
MariaDB PostgreSQL

--mariadb and postgresql 
SELECT E.* 
FROM employees E 
ORDER BY E.start_date 
LIMIT 1; 




11. Select the employees’ name, surname, and years and months working in our enterprise (order by those years and months descendent). Clues: 
● Postgresql: date_part, age 
● Mariadb: timestampdiff, now, % 12 
MariaDB PostgreSQL

-- MariaDB 
SELECT 
E.name, 
E.surname, 
TIMESTAMPDIFF(YEAR, E.start_date, NOW()) AS years, 
TIMESTAMPDIFF(MONTH, E.start_date, NOW()) % 12 AS months FROM
employees E 
ORDER BY 
years DESC, 
months DESC; 
-- PostgreSQL 
SELECT 
E.name, 
E.surname, 
DATE_PART('year', AGE(NOW(), E.start_date)) AS years, 
DATE_PART('month', AGE(NOW(), E.start_date)) AS months FROM 
employees E 
ORDER BY 
years DESC, 
months DESC; 





12. Write a query to show employees.start_date in three columns: year, month and day. Clues: 
● Postgresql: date_part 
● Mariadb: year, month, day
MariaDB PostgreSQL
-- MariaDB 
SELECT 
YEAR(E.start_date) AS _year, 
MONTH(E.start_date) AS _month, 
DAY(E.start_date) AS _day 
FROM 
employees E 
ORDER BY 
E.start_date; 
-- PostgreSQL 
SELECT 
DATE_PART('year', E.start_date) AS _year, 
DATE_PART('month', E.start_date) AS _month, 
DATE_PART('day', E.start_date) AS _day 
FROM 
employees E 
ORDER BY 
E.start_date; 




13. Write a query to show the employees that joined the enterprise in June. Clues: ● Postgresql: trim(to_char()) 
● Mariadb: monthname 
MariaDB PostgreSQL

-- MariaDB 
SELECT 
E.surname, 
E.name, 
E.start_date 
FROM 
employees E 
WHERE 
MONTHNAME(E.start_date) = 'June' 
ORDER BY
E.start_date; 
-- PostgreSQL 
SELECT 
E.surname, 
E.name, 
E.start_date 
FROM 
employees E 
WHERE 
TRIM(TO_CHAR(E.start_date, 'Month')) = 'June' 
ORDER BY 
E.start_date; 




14. Write the date of the last exercise with the following format (pictures). Clues: ● Postgresql: trim(to_char()) 
● Mariadb: monthname 
MariaDB PostgreSQL

-- MariaDB 
SELECT 
E.surname, 
E.name, 
DATE_FORMAT(E.start_date, '%W %d %M %Y %T') AS start_date FROM 
employees E 
WHERE 
MONTHNAME(E.start_date) = 'June'; 
-- PostgreSQL 
SELECT 
E.surname, 
E.name, 
TO_CHAR(E.start_date, 'Day DD Month YYYY HH24:MI:SS') AS start_date FROM 
employees E 
WHERE
TRIM(TO_CHAR(E.start_date, 'Month')) = 'June' 
ORDER BY 
E.start_date; 



15. Write a query to get the year and number of employees who started working that year. Sort the results by year. Clues: 
● Postgresql: extract, count 
● Mariadb: year, count 
MariaDB PostgreSQL

--PostgreSQL 
SELECT EXTRACT(YEAR FROM E.start_date) AS year, 
COUNT(*) as num 
FROM employees E 
GROUP BY year 
ORDER BY year; 
--MariaDB 
SELECT YEAR(E.start_date) AS year, 
COUNT(*) as num 
FROM employees E 
GROUP BY year 
ORDER BY year; 




16. Write a query to get the minimum number of employees who started working in our enterprise in a single year. Sort the results by year (desc). Clue: HAVING COUNT(*) = (SUBSELECT).
MariaDB PostgreSQL



SELECT EXTRACT( 
YEAR 
FROM E.start_date 
) AS year, 
COUNT(*) as num 
FROM employees E 
GROUP BY year 
HAVING COUNT(*) =( 
SELECT COUNT(*) 
FROM employees E 
GROUP BY EXTRACT( 
YEAR 
FROM E.start_date 
) 
ORDER BY COUNT(*) 
LIMIT 1 
) 
ORDER BY year DESC; 



17. Write a query to get the year in which more employees joined our enterprise. Clue: Very similar to the last exercise. 
MariaDB PostgreSQL

--PostgreSQL and MariaDB 
SELECT EXTRACT( 
YEAR 
FROM E.start_date 
) AS year,
COUNT(*) as num 
FROM employees E 
GROUP BY year 
HAVING COUNT(*) =( 
SELECT COUNT(*) 
FROM employees E 
GROUP BY EXTRACT( 
YEAR 
FROM E.start_date 
) 
ORDER BY COUNT(*) DESC 
LIMIT 1 
) 
ORDER BY year DESC; 



18. Show employees who are manager of other employees and the time in years that they are working in the enterprise. Sort the results by year (desc). 
MariaDB PostgreSQL

--PostgreSQL 
SELECT E.num, 
E.name, 
E.surname, 
DATE_PART('year', AGE(NOW(), E.start_date)) AS years 
FROM employees E 
WHERE E.num IN ( 
SELECT DISTINCT Z.manager 
FROM employees Z 
WHERE Z.manager is NOT NULL 
) 
ORDER BY years DESC; 
--MariaDB 
SELECT E.num,
E.name, 
E.surname, 
TIMESTAMPDIFF(YEAR, E.start_date, NOW()) AS years 
FROM employees E 
WHERE E.num IN ( 
SELECT DISTINCT Z.manager 
FROM employees Z 
WHERE Z.manager is NOT NULL 
) 
ORDER BY years DESC; 



19. Show employees who are manager of other employees working in the enterprise for more than 5 years. Clue: Very similar to the last exercise. 
MariaDB PostgreSQL

--PostgreSQL 
SELECT E.num, 
E.name, 
E.surname, 
DATE_PART('year', AGE(NOW(), E.start_date)) AS years 
FROM employees E 
WHERE DATE_PART('year', AGE(NOW(), E.start_date)) > 5 
AND E.num IN ( 
SELECT DISTINCT Z.manager 
FROM employees Z 
WHERE Z.manager is NOT NULL 
) 
ORDER BY years DESC; 
--MariaDB 
SELECT E.num, 
E.name, 
E.surname, 
TIMESTAMPDIFF(YEAR, E.start_date, NOW()) AS years
FROM employees E 
WHERE TIMESTAMPDIFF(YEAR, E.start_date, NOW()) > 5 AND E.num IN ( 
SELECT DISTINCT Z.manager 
FROM employees Z 
WHERE Z.manager is NOT NULL 
) 
ORDER BY years DESC; 


20. Can you use BETWEEN keyword with dates? Write an example. Yes, you can. 
--Employees who start working in 2020 
SELECT E.num, 
E.name, 
E.surname, 
E.start_date 
FROM employees E 
WHERE start_date BETWEEN '2020-01-12' AND '2020-12-31' ORDER BY E.surname, 
E.name;
