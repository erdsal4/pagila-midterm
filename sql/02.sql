/*
 * Count the number of distinct customers who have rented a movie that 'RUSSELL BACALL' has acted in.
 *
 * NOTE:
 * You cannot hard-code Russell Bacall's actor_id.
 * You're where clause must include a condition using the "first_name" and "last_name" fields of the "actor" table.
 */
WITH bacall_films AS (
	SELECT title
	FROM film
	JOIN film_actor USING (film_id)
	JOIN actor USING (actor_id)
   	WHERE actor.first_name = 'RUSSELL' AND actor.last_name = 'BACALL'
)

SELECT count(*) FROM ( 
	SELECT DISTINCT customer.first_name, customer.last_name
	FROM customer
	JOIN rental USING (customer_id)
	JOIN inventory USING (inventory_id)
	JOIN film USING (film_id)
	WHERE film.title IN (SELECT title from bacall_films)
	ORDER BY customer.first_name,customer.last_name
)t ;
