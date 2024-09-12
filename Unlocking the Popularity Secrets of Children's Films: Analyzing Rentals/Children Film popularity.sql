SELECT
  f.film_id, 
  CASE 
    WHEN COUNT(DISTINCT customer_id) <= 5 THEN f.title || ' is not popular'
    WHEN COUNT(DISTINCT customer_id) <= 15 AND COUNT(DISTINCT customer_id) > 5 THEN f.title || ' is slightly popular'
    WHEN COUNT(DISTINCT customer_id) <= 30 AND COUNT(DISTINCT customer_id) > 15 THEN f.title || ' is moderately popular'
    ELSE f.title || ' is very popular'
    END AS popularity,
  COUNT(DISTINCT customer_id) AS rental_count

FROM film f
  JOIN film_category fc USING(film_id)
  JOIN category c USING(category_id)
  JOIN inventory i USING(film_id)
  JOIN rental r USING(inventory_id)
WHERE c.name = 'Children'
GROUP BY f.film_id, c.name
ORDER BY rental_count DESC, title ASC
