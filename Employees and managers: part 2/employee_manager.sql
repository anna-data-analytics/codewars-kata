WITH RECURSIVE employee_levels AS (
  SELECT 
    id, 
    name, 
    manager_id,
    '' AS management_chain,
    1 AS level
  FROM employees 
  WHERE manager_id IS NULL

  UNION ALL

  SELECT
    e.id, 
    e.name,
    e.manager_id,
    CASE
      WHEN el.level = 1 THEN
        el.name || ' (' || el.id || ')'
      ELSE
        el.management_chain || ' -> ' || el.name || ' (' || el.id || ')'
    END as management_chain,
    el.level + 1 AS level
  FROM employees e
    JOIN employee_levels el ON e.manager_id = el.id
)

SELECT id, name, management_chain 
FROM employee_levels 
ORDER BY id ASC
