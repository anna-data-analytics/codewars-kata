WITH ranked_data AS (
  SELECT 
    i.store_id,
    c.name AS category,
    COUNT(r.rental_id) AS num_rentals,
    RANK() OVER (PARTITION BY i.store_id ORDER BY COUNT(r.rental_id) DESC, c.name ASC) AS rank
  FROM inventory i
    JOIN rental r ON i.inventory_id = r.inventory_id
    JOIN film_category fc ON fc.film_id = i.film_id
    JOIN category c ON c.category_id = fc.category_id
  GROUP BY i.store_id, c.name
)
SELECT store_id, category, num_rentals
FROM ranked_data
WHERE rank <= 5
