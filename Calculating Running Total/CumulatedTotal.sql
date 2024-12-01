SELECT 
  DATE(created_at) AS date,
  COUNT(id) AS count,
  SUM(COUNT(*)) OVER (ORDER BY DATE(created_at)):: INTEGER AS total
FROM posts
GROUP BY date
ORDER BY date ASC
