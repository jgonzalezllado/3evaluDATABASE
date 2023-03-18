--INNER JOIN: Devuelve sólo las filas que tienen una coincidencia en ambas tablas. Es decir, únicamente se muestran las filas que tienen valores que coinciden en la columna o conjunto de columnas especificado en la cláusula ON. Por ejemplo, supongamos que tenemos dos tablas clientes y ordenes, donde clientes tiene una columna id_cliente y ordenes tiene una columna id_cliente que indica el cliente al que pertenece cada orden. Para obtener todas las órdenes junto con la información del cliente que la realizó, podemos hacer un INNER JOIN de la siguiente manera:

SELECT *
FROM ordenes
INNER JOIN clientes
ON ordenes.id_cliente = clientes.id_cliente;



--LEFT JOIN: Devuelve todas las filas de la tabla de la izquierda y las filas correspondientes de la tabla de la derecha. Si no hay una coincidencia en la tabla de la derecha, se mostrarán NULL en todas las columnas de la tabla de la derecha. Por ejemplo, supongamos que queremos obtener una lista de todos los clientes y sus órdenes correspondientes, incluso si algunos clientes no han realizado ninguna orden. Podemos hacer un LEFT JOIN de la siguiente manera:

SELECT *
FROM clientes
LEFT JOIN ordenes
ON clientes.id_cliente = ordenes.id_cliente;


--RIGHT JOIN: Funciona de manera similar al LEFT JOIN, pero muestra todas las filas de la tabla de la derecha y las filas correspondientes de la tabla de la izquierda. Si no hay una coincidencia en la tabla de la izquierda, se mostrarán NULL en todas las columnas de la tabla de la izquierda. El RIGHT JOIN no está disponible en todas las bases de datos. Podemos modificar el ejemplo anterior para usar un RIGHT JOIN de la siguiente manera:

SELECT *
FROM clientes
RIGHT JOIN ordenes
ON clientes.id_cliente = ordenes.id_cliente;

--FULL OUTER JOIN: Devuelve todas las filas de ambas tablas y une las filas correspondientes. Si no hay una coincidencia en una de las tablas, se mostrarán NULL en todas las columnas de la otra tabla. El FULL OUTER JOIN no está disponible en todas las bases de datos. Por ejemplo, supongamos que queremos obtener una lista de todos los clientes y todas las órdenes, independientemente de si hay una coincidencia o no. Podemos hacer un FULL OUTER JOIN de la siguiente manera:

SELECT *
FROM clientes
FULL OUTER JOIN ordenes
ON clientes.id_cliente = ordenes.id_cliente;


--teoria izquierdaderecha

--Cuando hablamos de "tablas de la izquierda" y "tablas de la derecha" en el contexto de una cláusula JOIN, nos referimos a las tablas que están a cada lado del operador JOIN.


SELECT *
FROM tabla_izquierda
JOIN tabla_derecha
ON tabla_izquierda.columna = tabla_derecha.columna;
La tabla tabla_izquierda se considera la tabla de la izquierda y tabla_derecha se considera la tabla de la derecha. La razón por la que se usan estos términos es porque la sintaxis de la cláusula JOIN se asemeja a la posición relativa de las tablas en la consulta.

--También es importante tener en cuenta que, en una cláusula JOIN, la tabla de la izquierda es la tabla que se menciona primero en la consulta y la tabla de la derecha es la segunda


