/*
 * You love the acting in the movie 'AMERICAN CIRCUS' and want to watch similar movies.
 * You've already watched all other movies with the same actors,
 * so now you need a new strategy for finding similar movies.
 * You decide that two movies X and Y are similar if they have been rented by the same customer,
 * and you further quantify this similarity by defining the "similarity score" to be the number of distinct customers that have rented both X and Y.
 *
 * Write a SQL SELECT query that:
 * computes the "similarity score" for all movies with 'AMERICAN CIRCUS'
 * and orders the results from highest to lowest.
 *
 * NOTE:
 * Your results should not contain any duplicate titles.
 *
 * NOTE:
 * You do not have to include movies with similarity score 0 in your results (but you may if you like).
 */
SELECT t.ttitle, count(t.ttitle)
FROM( 
	SELECT DISTINCT f1.title, f2.title as ttitle, first_name || ' ' || last_name as name
FROM customer c
JOIN rental r1 ON (c.customer_id=r1.customer_id)
JOIN rental r2 ON (r1.customer_id = r2.customer_id)
JOIN inventory i1 ON (r1.inventory_id=i1.inventory_id)
JOIN inventory i2 ON (r2.inventory_id = i2.inventory_id)
JOIN film f1 ON (i1.film_id=f1.film_id)
JOIN film f2 ON (i2.film_id=f2.film_id)
WHERE f1.title='AMERICAN CIRCUS'
  AND NOT f2.title='AMERICAN CIRCUS'
) t
GROUP BY(t.ttitle)
ORDER BY count(t.ttitle) DESC
