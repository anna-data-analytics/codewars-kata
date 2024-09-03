WITH t1 AS
  (SELECT  
   atm_id, 
   SUM ((split_part(transaction_duration, '.', 1)::int * 60 + split_part(transaction_duration, '.', 2)::int)) AS total_duration 

  FROM atm_transactions
  GROUP BY atm_id   
  )
SELECT 
  atm_id,
  to_char(total_duration *interval'1min','FMHH24.MI') AS total_duration_hours
FROM t1
ORDER BY (total_duration *interval'1min') DESC, atm_id DESC
