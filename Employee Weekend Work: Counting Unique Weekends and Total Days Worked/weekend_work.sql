WITH my_employee AS (
  SELECT
    employee_id
    ,CASE 
      WHEN (attendance_date < (DATE_TRUNC('year', attendance_date) + INTERVAL '3 days'))
          AND (EXTRACT(WEEK FROM attendance_date) > 1) 
        THEN 0
      ELSE EXTRACT(WEEK FROM attendance_date)
    END AS worked_weekends
    ,EXTRACT(DOW FROM attendance_date) AS worked_weekend_days
  FROM employee_attendance
  WHERE EXTRACT(DOW FROM attendance_date) IN (0, 6)
    AND EXTRACT(YEAR FROM attendance_date) = 2023
)

, weekends AS (
  SELECT  
    employee_id
    ,worked_weekends
    ,COUNT(worked_weekend_days) AS count_weekend_days
  FROM my_employee
  GROUP BY employee_id, worked_weekends
)

SELECT 
  employee_id
  ,COUNT(worked_weekends) AS weekends_worked
  ,SUM(count_weekend_days) :: integer AS total_weekend_days_worked 
FROM weekends
GROUP BY employee_id
ORDER BY weekends_worked DESC
  ,total_weekend_days_worked DESC
  ,employee_id DESC
