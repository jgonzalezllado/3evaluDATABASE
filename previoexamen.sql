CREATE TABLE departments (id int NOT NULL PRIMARY KEY, name text);
INSERT INTO
departments
VALUES
(1, 'Department 1'),
(2, 'Department 2'),
(3, 'Department 3'),
(4, 'Department 4'),
(5, 'Department 5');
CREATE TABLE employees (
id int NOT NULL,
name text,
surname text,
start_date timestamp,
end_date timestamp,
department int
);
INSERT INTO
employees
VALUES
(
1,
'John',
'Smith',
'2021-09-27 15:22',

'2023-01-02 00:00',
1
),
(
2,
'Jane',
'McDonald',
'2022-01-01 12:00',
NULL,
2
),
(
3,
'Mathew',
'Connor',
'2019-05-02 12:23',
'2022-10-02 00:00',
3
),
(
4,
'Laura',
'Dern',
'2018-09-26 01:22',
'2023-01-02 00:00',
4
),
(
5,
'John',
'Smith',
'2021-09-27 15:22',
NULL,
NULL
);

Inside a transaction, delete all the rows of the tables. Finally, undo those changes


BEGIN;
DELETE FROM table1;
DELETE FROM table2;
DELETE FROM table3;
COMMIT; o 
ROLLBACK; // solo funciona si no se ha hecho commit 

BEGIN;
DELETE FROM employees;
DELETE FROM departments;
ROLLBACK;

-- Write a query to count the times that a year appears in the column 'end_datetime'.
Sort the results like in the pictures

SELECT EXTRACT(YEAR FROM end_date) AS year, COUNT(*) AS num_year
FROM employees
GROUP BY year
ORDER BY year;

--Show the name of the employees with the format 'S. González'

SELECT substring(name, 1, 1) || '. ' || substring(name, position(' ' in name)+1) AS formatted_name
FROM employees;

--INER JOIN Retorna las filas que tienen una coincidencia en ambas tablas.
SELECT e.name, d.name
FROM employees e
INNER JOIN department d
ON e.department_id = d.id;


--LEFT JOIN  Retorna todas las filas de la tabla izquierda y 
--las filas de la tabla derecha que tienen una coincidencia. 
--Si no hay una coincidencia en la tabla derecha, los valores correspondientes serán nulos.

SELECT e.name, d.name
FROM employees e
LEFT JOIN department d
ON e.department_id = d.id;

--RIGHT JOIN Retorna todas las filas de la tabla derecha y
-- las filas de la tabla izquierda que tienen una coincidencia. 
--Si no hay una coincidencia en la tabla izquierda, 
--los valores correspondientes serán nulos.
SELECT e.name, d.name
FROM employees e
RIGHT JOIN department d
ON e.department_id = d.id;


--FULLOUTERJOIN
--Retorna todas las filas de ambas tablas y 
--combina las filas que tienen una coincidencia en ambas tablas. 
--Si no hay una coincidencia en una de las tablas, los valores correspondientes serán nulos.


SELECT e.name, d.name
FROM employees e
FULL OUTER JOIN department d
ON e.department_id = d.id;



--EXPLICIT JOIN ES SIMPLEMENTE UN JOIN 
SELECT columna(s)
FROM tabla1
JOIN tabla2 ON tabla1.columna = tabla2.columna;


--Number of days between end_date and start_date (when end_date is not NULL)
--adding 90 days. Also show the name of the employees, start_date, and end_date. Sort
--the results like in the pictures.

SELECT 
  name, 
  surname,
  start_date, 
  end_date, 
  COALESCE(end_date, CURRENT_DATE + interval '90 day') - start_date AS days_between
FROM 
  employees
WHERE 
  end_date IS NOT NULL
ORDER BY 
  days_between DESC;
