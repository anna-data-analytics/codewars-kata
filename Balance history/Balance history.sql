WITH calculation AS 
  (
  SELECT
    DATE(date) AS date,
    SUM(amount) AS daily_balance
  FROM operations
  GROUP BY DATE(date)
  ORDER BY DATE(date)
   )
SELECT
  date,
  SUM(daily_balance) OVER (ORDER BY date) AS Balance
FROM calculation
