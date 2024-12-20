## Problem:

In a hotel booking system, a customer might make an initial payment to book a room and then make another payment for additional services or amenities during their stay. Create an SQL query that groups the transactions by each guest's booking.

Full description:
https://www.codewars.com/kata/65705f19f926c71f4c19fcaa

## Solution:

```sql
WITH ranked_transactions AS (
  SELECT
  transaction,
  name,
  receipt||' ('||datetime||')' AS service,
  RANK() OVER (PARTITION BY transaction ORDER BY datetime) AS rank
  FROM hotel_transactions
  )
SELECT
transaction,
name,
MIN(CASE WHEN rank = 1 THEN service END) AS initial_booking,
MIN(CASE WHEN rank = 2 THEN service END) AS additional_services

FROM ranked_transactions
GROUP BY transaction, name
ORDER BY transaction DESC
```
