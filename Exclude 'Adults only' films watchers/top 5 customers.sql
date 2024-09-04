SELECT
  customer_id, 
  first_name || ' ' || last_name as full_name, 
  count(*) as total_rentals
FROM customer
  JOIN rental USING (customer_id)
  JOIN inventory USING (inventory_id)
  JOIN film USING (film_id)
GROUP BY customer_id
HAVING SUM((rating = 'NC-17') :: int) = 0
ORDER BY total_rentals DESC, last_name
LIMIT 5
