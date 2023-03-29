1.- Write 2 examples of window function (using this database).

-- Film id and title plus total number of films
SELECT F.film_id, F.title, COUNT(*) OVER (
) As TotalNumOfFilms
FROM film F
ORDER BY F.title;
-- First ten payments with the average amount of all the payments
SELECT P.*, AVG(P.amount) OVER (
) As AverageAmount
FROM Payment P
ORDER BY P.Payment_date
LIMIT 10;
2.- Write 2 examples of subqueries using exists, all, or any. Use this database.
-- Films without actors
select F.*
from film F
where not exists (select * from film_actor FA where
FA.film_id=F.film_id);
-- Films without actors
select F.*
from film F
where F.film_id <> all (select distinct FA.film_id from film_actor
FA);
3.- Write an example of a view (using this database).
-- view of films data plus the number of actors in the film
create view film_with_num_actors as
select F.*, COUNT(FA.actor_id) as num_actors
from film F left outer join film_actor FA
on F.film_id = FA.film_id
group by F.film_id;
4.- Write an example of a query using case (using this database).
select language_id,
case
when name = 'Italian' then 'Italiano'
when name = 'French' then 'Français'
when name = 'Japanese' then 'やまと'
when name = 'Mandarin' then 'マンダリン'
when name = 'German' then 'Deutsch'
else name
end,
last_update
from language;

5.- Modify the table "category" adding a new column named 'category' with a new data
type 'category_type' (ENUM with values 'Action', 'Animation', 'Children', 'Classics',
'Comedy', 'Documentary', 'Drama', 'Family', 'Foreign', 'Games', 'Horror', 'Music', 'New',
'Sci-Fi', 'Sports', and, 'Travel'). Copy category.name inside category.category.
CREATE TYPE category_type AS ENUM (
'Action', 'Animation', 'Children', 'Classics',
'Comedy', 'Documentary', 'Drama', 'Family',
'Foreign', 'Games', 'Horror', 'Music', 'New',
'Sci-Fi', 'Sports', 'Travel'
);
ALTER TABLE category
ADD COLUMN category category_type;
update category
set category=name::category_type;

6.- Modify the table "address" adding a new column named 'mypostalcode' with a new
data domain 'postal_code_domain' (it must be a varchar(10) but only digits are
allowed). Copy address.postal_code inside address.mypostalcode.
CREATE DOMAIN postal_code_domain AS VARCHAR(10)
CHECK(
VALUE ~ '^[0-9]*$'
);
ALTER TABLE address
ALTER COLUMN postal_code
SET DATA TYPE postal_code_domain;
ALTER TABLE address
ADD COLUMN mypostalcode postal_code_domain;
update address
set mypostalcode=postal_code;