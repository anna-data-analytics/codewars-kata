WITH cast_in_together AS (
    SELECT fa1.film_id
    FROM film_actor fa1
    JOIN film_actor fa2 ON fa1.film_id = fa2.film_id
    WHERE fa1.actor_id = 105 AND fa2.actor_id = 122
)
SELECT f.title
FROM film f
JOIN cast_in_together cit ON f.film_id = cit.film_id
ORDER BY f.title
