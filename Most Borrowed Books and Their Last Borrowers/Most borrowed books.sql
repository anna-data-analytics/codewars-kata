WITH sub AS (
  SELECT DISTINCT ON (book_id) 
    book_id, 
    borrower_name, 
    return_date, 
    COUNT(*) OVER(PARTITION BY book_id) AS loan_count
  FROM loans
  ORDER BY book_id, return_date DESC
  )
  
SELECT 
  book_id, 
  title, 
  borrower_name AS last_borrower, 
  loan_count
FROM books JOIN sub USING(book_id)
WHERE loan_count = (SELECT MAX(loan_count) FROM sub)
ORDER BY book_id
