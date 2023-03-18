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


