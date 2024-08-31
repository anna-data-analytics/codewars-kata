WITH rental_totals AS (
  SELECT actor_id, count(*) AS rental_count
  FROM film_actor
  LEFT JOIN inventory USING(film_id)
  LEFT JOIN rental USING(inventory_id)
  GROUP BY actor_id, film_id
)
SELECT actor_id, first_name || ' ' || last_name AS full_name, count(DISTINCT film_id) AS film_count
FROM actor
LEFT JOIN film_actor USING(actor_id)
LEFT JOIN rental_totals USING(actor_id)
GROUP BY actor_id
HAVING count(DISTINCT film_id) > 19 AND min(rental_count) > 6
ORDER BY film_count DESC, actor_id
