--Supongamos que tenemos una tabla ventas que contiene información sobre ventas de productos, incluyendo una columna precio_unitario que indica el precio unitario de cada producto vendido. Para obtener el precio promedio de los productos vendidos, podemos usar la función AVG de la siguiente manera:


SELECT AVG(precio_unitario) FROM ventas;


--SUM:
--Siguiendo el ejemplo anterior, para obtener el monto total de ventas de la tabla ventas, podemos usar la función SUM de la siguiente manera:

SELECT SUM(precio_unitario * cantidad_vendida) AS total_ventas FROM ventas;


--MAX:
--Supongamos que tenemos una tabla productos que contiene información sobre productos, incluyendo una columna precio que indica el precio de venta de cada producto. Para obtener el precio más alto de los productos en la tabla, podemos usar la función MAX de la siguiente manera:

SELECT MAX(precio) AS precio_maximo FROM productos;


--MIN:
--Siguiendo el ejemplo anterior, para obtener el precio más bajo de los productos en la tabla, podemos usar la función MIN de la siguiente manera:
SELECT MIN(precio) AS precio_minimo FROM productos;


--COUNT:
--Supongamos que tenemos una tabla clientes que contiene información sobre clientes, incluyendo una columna ciudad que indica la ciudad donde reside cada cliente. Para contar el número de clientes que viven en una ciudad específica, podemos usar la función COUNT de la siguiente manera:

SELECT COUNT(*) AS cantidad_clientes FROM clientes WHERE ciudad = 'Lima';


----GROUP_CONCAT:
--Supongamos que tenemos una tabla productos que contiene información sobre productos, incluyendo una columna nombre que indica el nombre de cada producto. Para concatenar los nombres de todos los productos en una sola cadena separada por comas, podemos usar la función GROUP_CONCAT de la siguiente manera:


SELECT GROUP_CONCAT(nombre SEPARATOR ', ') AS nombres_productos FROM productos;