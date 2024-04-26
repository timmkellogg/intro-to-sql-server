--1. Display the first and last name of each actor in a single column in upper case letters.
--Name the column Actor Name.
SELECT CONCAT(UPPER(first_name), ' ',  UPPER(last_name)) AS ActorName
FROM actor

--  Correct names to captilaize only first letter of each string
SELECT CONCAT(UPPER(SUBSTRING(first_name, 1, 1)), LOWER(SUBSTRING(first_name, 2,9)), ' ', 
              UPPER(SUBSTRING(last_name, 1, 1)), LOWER(SUBSTRING(last_name, 2,9))) AS "actor_name"
FROM actor;

--2. You need to find the ID number, first name, and last name of an actor, of whom you
--know only the first name, 'Joe'.
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'JOE';

--3. Find all actors whose last name contain the letters GEN.
SELECT *
FROM actor
WHERE last_name LIKE '%GEN%';

--4. Find all actors whose last names contain the letters �LI�. This time, order the rows by
--last name and first name, in that order.
SELECT *
FROM actor
WHERE last_name LIKE '%LI%'
ORDER BY last_name, first_name;

--5. Using IN, display the country_id and country columns of the following countries:
--Afghanistan, Bangladesh, and China.
SELECT country_id, country
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

--6. List last names of actors and the number of actors who have that last name, but only
--for names that are shared by at least two actors
SELECT last_name, COUNT(*) AS actor_count
FROM actor
GROUP BY last_name
HAVING COUNT(*) >= 2
ORDER BY actor_count DESC, last_name;

--7. The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO
--WILLIAMS. Write a query to fix the record, and another to verify the change.
UPDATE actor
SET first_name = 'HARPO'
WHERE first_name = 'GROUCHO' AND last_name = 'WILLIAMS';

SELECT *
FROM actor
WHERE first_name = 'HARPO' AND last_name = 'WILLIAMS';

--8. Perhaps we were too hasty in changing GROUCHO to HARPO. It turns out
--that GROUCHO was the correct name after all! In a single query, if the first name of
--the actor is currently HARPO, change it to GROUCHO. Then write a query to verify
--your change.
UPDATE actor
SET first_name = 'GROUCHO'
WHERE first_name = 'HARPO';

SELECT *
FROM actor
WHERE first_name = 'GROUCHO' AND last_name = 'WILLIAMS'
-- Verify the change

--9. Use JOIN to display the total amount rung up by each staff member in August of
--2005. Use tables staff and payment.


--SELECT staff.staff_id, staff.first_name, staff.last_name, SUM(payment.amount) AS total_amount
--FROM staff, payment
--WHERE staff.staff_id = payment.staff_id
--GROUP BY staff.staff_id, staff.first_name, staff.last_name

SELECT staff.staff_id, staff.first_name, staff.last_name, SUM(payment.amount) AS total_amount
FROM staff
JOIN payment ON staff.staff_id = payment.staff_id
WHERE payment.payment_date >= '2005-08-01' AND payment_date <= '2005-08-31'
--WHERE YEAR(payment.payment_date) = 2005 AND MONTH(payment.payment_date) = 8
GROUP BY staff.staff_id, staff.first_name, staff.last_name

--10. List each film and the number of actors who are listed for that film. Use tables
--film_actor and film. Use inner join.
SELECT film.title, COUNT(film_actor.actor_id) AS num_actors
FROM film
JOIN film_actor ON film.film_id = film_actor.film_id
GROUP BY film.title
ORDER BY num_actors DESC

--11. How many copies of the film HUNCHBACK IMPOSSIBLE exist in the system?
SELECT film.title, COUNT(*) AS num_of_inventory
FROM film
JOIN inventory ON film.film_id = inventory.film_id
WHERE film.title = 'HUNCHBACK IMPOSSIBLE'
GROUP BY film.title

--SELECT film.title, COUNT(*) AS num_of_inventory
--FROM film, inventory
--WHERE film.title = 'HUNCHBACK IMPOSSIBLE' AND film.film_id = inventory.film_id
--GROUP BY film.title


--12. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an
--unintended consequence, films starting with the letters K and Q have also soared in
--popularity. Use subqueries to display the titles of movies starting with the letters K
--and Q whose language is English.
SELECT title
FROM film
JOIN language ON film.language_id = language.language_id
WHERE title LIKE 'K%' OR title LIKE 'Q%'
and language.name = 'English'

--SELECT TABLE_SCHEMA, TABLE_NAME
--FROM INFORMATION_SCHEMA.TABLES
--WHERE TABLE_NAME LIKE '%language%'

--SELECT TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME
--FROM INFORMATION_SCHEMA.COLUMNS




--13. Insert a record to represent Mary Smith renting the movie
--ACADEMY DINOSAUR from Mike Hillyer at Store 1 today. Then write a query to
--capture the exact row you entered into the rental table.
INSERT INTO rental (rental_date, inventory_id, customer_id, staff_id, return_date, last_update)
VALUES (
    CURRENT_TIMESTAMP,
    (SELECT TOP 1 inventory_id 
     FROM inventory 
     WHERE film_id = (SELECT film_id FROM film WHERE title = 'ACADEMY DINOSAUR') AND store_id = 1),
    (SELECT customer_id FROM customer WHERE first_name = 'MARY' AND last_name = 'SMITH'),
    (SELECT staff_id FROM staff WHERE first_name = 'Mike' AND last_name = 'Hillyer'),
    NULL,
    CURRENT_TIMESTAMP
);

SELECT TOP 1 *
FROM rental
ORDER BY rental_date DESC;
