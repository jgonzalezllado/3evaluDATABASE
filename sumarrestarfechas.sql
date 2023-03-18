Para sumar un día a una fecha, utiliza la cláusula interval con el valor '1 day'. Por ejemplo:


SELECT CURRENT_DATE + INTERVAL '1 day';

Para restar un día a una fecha, utiliza la cláusula interval con el valor '-1 day'. Por ejemplo:
SELECT CURRENT_DATE - INTERVAL '1 day';



Para sumar una semana a una fecha, utiliza la cláusula interval con el valor '7 days'. Por ejemplo:
SELECT CURRENT_DATE + INTERVAL '7 days';


Para restar un mes a una fecha, utiliza la cláusula interval con el valor '-1 month'. Por ejemplo:
SELECT CURRENT_DATE - INTERVAL '1 month';


Para sumar un año a una fecha, utiliza la cláusula interval con el valor '1 year'. Por ejemplo:
SELECT CURRENT_DATE + INTERVAL '1 year';


Para restar un año a una fecha, utiliza la cláusula interval con el valor '-1 year'. Por ejemplo:
SELECT CURRENT_DATE - INTERVAL '1 year';




MARIADB
Para sumar un día a una fecha, utiliza la función DATE_ADD() con la unidad 'DAY' y el valor 1. Por ejemplo:
SELECT DATE_ADD(CURRENT_DATE(), INTERVAL 1 DAY);


Para restar un día a una fecha, utiliza la función DATE_SUB() con la unidad 'DAY' y el valor 1. Por ejemplo:
SELECT DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY);


Para sumar una semana a una fecha, utiliza la función DATE_ADD() con la unidad 'WEEK' y el valor 1. Por ejemplo:
SELECT DATE_ADD(CURRENT_DATE(), INTERVAL 1 WEEK);


Para restar un mes a una fecha, utiliza la función DATE_SUB() con la unidad 'MONTH' y el valor 1. Por ejemplo:
SELECT DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH);


Para sumar un año a una fecha, utiliza la función DATE_ADD() con la unidad 'YEAR' y el valor 1. Por ejemplo:
SELECT DATE_ADD(CURRENT_DATE(), INTERVAL 1 YEAR);


Para restar un año a una fecha, utiliza la función DATE_SUB() con la unidad 'YEAR' y el valor 1. Por ejemplo:
SELECT DATE_SUB(CURRENT_DATE(), INTERVAL 1 YEAR);

SELECT LAST_DAY(DATE_SUB('2022-03-15', INTERVAL 1 MONTH));
