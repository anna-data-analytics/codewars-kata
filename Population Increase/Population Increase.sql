SELECT
  p2.country, 
  CONCAT(CAST(ROUND((p2.population - p1.population)/ 1000000.,2) AS TEXT), ' M') AS population_increase
FROM world_population p2
JOIN world_population p1 USING (country)
WHERE p1.year = 2000 AND p2.year = 2020
ORDER BY (p2.population - p1.population) DESC
LIMIT 5
