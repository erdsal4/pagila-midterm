/*
 * You want to watch a movie tonight.
 * But you're superstitious,
 * and don't want anything to do with the letter 'F'.
 * List the titles of all movies that:
 * 1) do not have the letter 'F' in their title,
 * 2) have no actors with the letter 'F' in their names (first or last),
 * 3) have never been rented by a customer with the letter 'F' in their names (first or last).
 *
 * NOTE:
 * Your results should not contain any duplicate titles.
 */
WITH title_f AS (
	SELECT title
	FROM film
	WHERE title LIKE '%F%'
),
actor_f AS (
	SELECT title, first_name || ' ' || last_name as name
	FROM actor
	JOIN film_actor USING (actor_id)
	JOIN film USING (film_id)
	WHERE first_name LIKE '%F%' OR last_name LIKE '%F%'
),
customer_f AS (
	SELECT title, first_name || ' ' || last_name as name
	FROM customer
	JOIN rental USING (customer_id)
	JOIN inventory USING (inventory_id)
	JOIN film USING (film_id)
	WHERE first_name LIKE '%F%' OR last_name LIKE '%F%'
)

SELECT title 
FROM film
WHERE title NOT IN (SELECT title FROM title_f ) 
  AND title NOT IN (SELECT title FROM actor_f)
  AND title NOT IN (SELECT title FROM customer_f)
ORDER BY title;
