1. Concat the name and surname of the employees using the separator ' ' using the function CONCAT_WS. 
MariaDB PostgreSQL

select CONCAT_WS(' ', num, name, surname) 
from employees; 



2. Format employees’ commission with format ##,## (you have to find out how to do it by searching the Internet, not by consulting the slides...).
MariaDB PostgreSQL

--PostgreSQL 
select TO_CHAR(commission, 'FM999,999.00') as commissionFormatted from employees; 
-- MariaDB 
select FORMAT(commission, 2, 'es_ES') as commissionFormatted from employees; 




3. Return the position of the first A in the employees’ surname.
MariaDB PostgreSQL

select E.surname, POSITION('A' IN E.surname) as FirstA from employees E; 
/****************************** 
Same behaviour than in MariaDB 
******************************/ 
-- Install extension unaccent 
CREATE EXTENSION unaccent; 
-- Query using unaccent 
select surname, 
position('A' in unaccent(surname)) 
from employees; 




4. (Danger) Return the position of the second A in the employees’ surname. Clue: Check IF function and use nested functions SUBSTRING and POSITION. Do it only for MariaDB.
MariaDB

-- MariaDB and Postgresql 
select E.surname, 
IF( 
POSITION( 
'A' IN SUBSTRING(E.surname, POSITION('A' IN E.surname) + 1) ) <> 0, 
POSITION( 
'A' IN SUBSTRING(E.surname, POSITION('A' IN E.surname) + 1) ) + POSITION('A' IN E.surname), 
0 
) AS SecondA 
from employees E; 
-- courtesy of a student 
SELECT surname, 
LOCATE('a', surname, LOCATE('a', surname) + 1) AS SecondA FROM employees; 
-- courtesy of a student 
select 
surname, 
if( 
length(substring_index(surname, 'A', 2)) < length(surname), length(substring_index(surname, 'A', 2)) + 1, 
0
) as second_A 
from 
employees; 



5. Return the full name of the employees with the next format: 
MariaDB PostgreSQL

-- PostgreSQL 
select CONCAT_WS( 
' ', 
INITCAP(E.name), 
INITCAP(E.surname) 
) AS FullName 
from employees E; 
-- MariaDB 
select CONCAT_WS( 
' ', 
CONCAT( 
UPPER(LEFT(E.name, 1)), 
LOWER(SUBSTRING(E.name, 2)) 
), 
CONCAT( 
UPPER(LEFT(E.surname, 1)), 
LOWER(SUBSTRING(E.surname, 2))
) 
) AS FullName 
from employees E; 




6. Select all the full names of the databases but changing ’IO’ for ‘IOTE’. NOTE THAT: If you do this using a string function in a SELECT clause, you don’t change the data stored in the database… 
MariaDB PostgreSQL

select REPLACE(CONCAT_WS(' ', E.name, E.surname), 'IO', 'IOTE') as iote_name 
from employees E; 



7. Update all the names like Antonio or Antonia with Tonio or Tonia. You must use UPDATE and the function REPLACE (only a single sentence).
UPDATE employees 
SET name = REPLACE(name, 'ANTONI', 'TONI'); 



8. Show the surnames of the employees with an underscore after the second char. 
MariaDB PostgreSQL

SELECT CONCAT( 
SUBSTR(E.surname, 1, 2), 
'_', 
SUBSTR(E.surname, 3) 
) AS Surname 
FROM employees E;


9. Write the first char of the surnames and the first char of the surnames in ASCII code (you should look it up on the Internet). 
MariaDB PostgreSQL



SELECT SUBSTR(E.surname, 1, 1) AS FirstChar, 
ASCII(SUBSTR(E.surname, 1, 1)) AS SurnameASCII 
FROM employees E; 
-- or better, because ASCII returns only the first character on the left 
SELECT SUBSTR(E.surname, 1, 1) AS FirstChar, 
ASCII(E.surname) AS SurnameASCII 
FROM employees E; 



--10. Show the full name of the employees, but ensuring that there won’t be white spaces before and/or after the name and/or surname. 
SELECT CONCAT_WS(' ', TRIM(E.name), TRIM(E.surname)) as FullName FROM employees E;
