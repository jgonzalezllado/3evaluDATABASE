
--1. Concat the name and surname of the employees using the separator ' ' using the function CONCAT_WS.


SELECT CONCAT_WS(' ', e.name, e.surname) AS full_name
FROM employees e;

--2. Format employees’ commission with format ##,## (you have to find out how to do it by searching the Internet, not by consulting the slides...).

--3. Return the position of the first A in the employees’ surname.

SELECT e.surname, POSITION('A' IN e.surname) FROM employees e;


--4. (Danger) Return the position of the second A in the employees’ surname. Clue: Check IF function and use nested functions SUBSTRING and POSITION. Do it only for MariaDB.

SELECT surname AS surname,
  IF(POSITION('A' IN SUBSTRING(surname, POSITION('A' IN surname) + 1)) > 0, 
     POSITION('A' IN SUBSTRING(surname, POSITION('A' IN surname) + 1)) + POSITION('A' IN surname),
     0) AS seconda
FROM employees;





--5. Return the full name of the employees with the next format:



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


--6. Select all the full names of the databases but changing ’IO’ for ‘IOTE’. NOTE THAT: If you do this using a string function in a SELECT clause, you don’t change the data stored in the database…

SELECT 
    CONCAT(REPLACE(name, 'IO', 'IOTE'), ' ', REPLACE(surname, 'IO', 'IOTE')) AS ionte_name
FROM employees;



--7. Update all the names like Antonio or Antonia with Tonio or Tonia. You must use UPDATE and the function REPLACE (only a single sentence).

UPDATE employees 
SET name = REPLACE(REPLACE(name, 'ANTONIO', 'TONIO'), 'ANTONIA', 'TONIA') 
WHERE name LIKE '%ANTON%';



--8. Show the surnames of the employees with an underscore after the second char.


SELECT CONCAT(SUBSTR(surname, 1, 2), '_', SUBSTR(surname, 3)) AS surname
FROM employees;

--9. Write the first char of the surnames and the first char of the surnames in ASCII code (you should look it up on the Internet).

SELECT SUBSTR(surname, 1, 1) AS FirstChar, ASCII(SUBSTR(surname, 1, 1)) AS surnameascii
FROM employees;

--10. Show the full name of the employees, but ensuring that there won’t be white spaces before and/or after the name and/or surname.

SELECT CONCAT_WS(' ', name, surname) AS full_name
FROM employees;


Concat the name and surname of the employees using the separator ' ' using the function CONCAT_WS.
MariaDB:



SELECT CONCAT_WS(' ', name, surname) as full_name FROM employees;
Postgre:



SELECT CONCAT(name, ' ', surname) as full_name FROM employees;



Format employees’ commission with format ##,## (you have to find out how to do it by searching the Internet, not by consulting the slides...).
MariaDB:

SELECT FORMAT(commission, '##,##') as formatted_commission FROM employees;
Postgre:



SELECT TO_CHAR(commission, 'FM99G999D00') as formatted_commission FROM employees;
Return the position of the first A in the employees’ surname.
MariaDB:



SELECT POSITION('A' IN surname) as position_of_a FROM employees;
Postgre:



SELECT POSITION('A' IN surname) as position_of_a FROM employees;
(Danger) Return the position of the second A in the employees’ surname. Clue: Check IF function and use nested functions SUBSTRING and POSITION. Do it only for MariaDB.
MariaDB:



SELECT IF(
   POSITION('A' IN SUBSTRING(surname, POSITION('A' IN surname)+1)) > 0,
   POSITION('A' IN SUBSTRING(surname, POSITION('A' IN surname)+1))+POSITION('A' IN surname),
   'Second A not found'
) as position_of_second_a FROM employees;
Return the full name of the employees with the next format:
MariaDB:



SELECT CONCAT_WS(', ', surname, name) as full_name FROM employees;
Postgre:



SELECT CONCAT(surname, ', ', name) as full_name FROM employees;
Select all the full names of the databases but changing ’IO’ for ‘IOTE’. NOTE THAT: If you do this using a string function in a SELECT clause, you don’t change the data stored in the database…
MariaDB:



SELECT REPLACE(CONCAT_WS(' ', name, surname), 'IO', 'IOTE') as full_name FROM employees;
Postgre:



SELECT REPLACE(CONCAT(name, ' ', surname), 'IO', 'IOTE') as full_name FROM employees;
Update all the names like Antonio or Antonia with Tonio or Tonia. You must use UPDATE and the function REPLACE (only a single sentence).
MariaDB:



UPDATE employees SET name = REPLACE(name, 'Ant', 'T'), surname = REPLACE(surname, 'Ant', 'T') WHERE name LIKE 'Ant%' OR surname LIKE 'Ant%';
Postgre:



UPDATE employees SET name = REPLACE(name, 'Ant', 'T'), surname = REPLACE(surname, 'Ant', 'T') WHERE name LIKE 'Ant%' OR surname LIKE 'Ant%';
Show the surnames of the employees with an underscore after the second char.
MariaDB:



SELECT CONCAT(SUBSTRING(surname, 1, 2), '_', SUBSTRING(surname, 3)) as surname_with_underscore FROM employees;
Postgre:



SELECT CONCAT(SUBSTRING(surname, 1, 2), '_', SUBSTRING(s