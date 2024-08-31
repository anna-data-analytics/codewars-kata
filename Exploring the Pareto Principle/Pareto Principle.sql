WITH top20 AS (
  SELECT 
    customer_id
    , COUNT(rental_id) AS total_rentals 
    FROM rental 
    GROUP BY customer_id 
    ORDER BY total_rentals DESC 
    LIMIT ROUND((SELECT COUNT(DISTINCT(customer_id)) FROM rental) * 0.2, 0)::INTEGER 
)

, stat AS (
  SELECT 
    (
      SELECT SUM(total_rentals)
      FROM top20
    ) AS "top_20%_rentals_count"
    , (
      SELECT COUNT(rental_id)
      FROM rental
    ) AS total_rentals_count

  FROM top20
  LIMIT 1
)

SELECT
  "top_20%_rentals_count"::INTEGER
  , total_rentals_count
  , (ROUND("top_20%_rentals_count" * 100/ total_rentals_count, 2))::NUMERIC AS "percentage_of_top_20%"
FROM stat
