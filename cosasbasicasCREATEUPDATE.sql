--crear tabla

CREATE TABLE usuarios (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  email VARCHAR(100) UNIQUE,
  edad INT,
  fecha_registro DATE DEFAULT CURRENT_DATE
);


--insertar datos 

INSERT INTO usuarios (nombre, email, edad) 
VALUES ('Juan Perez', 'juan.perez@example.com', 30);


--actualizar

UPDATE usuarios 
SET edad = 31 
WHERE nombre = 'Juan Perez';


--eliminar datos

DELETE FROM usuarios 
WHERE edad > 50;


--CREATE VIEW

--Crea una vista simple llamada vista que muestra el nombre y el salario de los empleados:
CREATE VIEW vista AS SELECT nombre, salario FROM empleados;

--Crea una vista llamada vista2 que reemplaza a la vista anterior y muestra el nombre y el salario de los empleados que ganan más de 3000:-
CREATE OR REPLACE VIEW vista2 AS SELECT nombre, salario FROM empleados WHERE salario > 3000;

CREATE TEMPORARY TABLE IF NOT EXISTS tableTemp AS (SELECT * FROM table1 UNION SELECT * FROM table2);
