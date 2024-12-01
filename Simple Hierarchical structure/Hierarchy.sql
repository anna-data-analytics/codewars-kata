WITH RECURSIVE employee_levels AS (
  SELECT 
    id, 
    first_name,
    last_name, 
    manager_id, 
    1 AS level
  FROM employees 
  WHERE manager_id IS NULL

  UNION ALL

  SELECT
    e.id, 
    e.first_name,
    e.last_name,
    e.manager_id,
    el.level + 1 AS level
  FROM employees e
    JOIN employee_levels el ON e.manager_id = el.id
)

SELECT  
 level, 
 id, 
 first_name, 
 last_name, 
 manager_id 
FROM employee_levels
