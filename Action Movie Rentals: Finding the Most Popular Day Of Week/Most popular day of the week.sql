WITH action_movies AS
(
  SELECT
  f.film_id,
  f.title
  FROM film_category fc 
  INNER JOIN film f ON f.film_id = fc.film_id
  INNER JOIN category c ON c.category_id = fc.category_id
WHERE c.name = 'Action'

)

SELECT DISTINCT ON (film_id, film_title)
  am.film_id,
  f.title AS film_title,
  to_char(r.rental_date, 'DY') AS most_popular_day_of_week
 
FROM inventory i
  JOIN action_movies am ON am.film_id = i.film_id
  JOIN rental r ON r.inventory_id = i.inventory_id
  JOIN film f ON f.film_id = i.film_id

GROUP BY to_char(r.rental_date, 'DY'), am.film_id, f.title 
ORDER BY film_title, am.film_id ASC, COUNT(r.rental_id) DESC, most_popular_day_of_week
