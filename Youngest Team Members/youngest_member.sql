select distinct on(team) * from employees
order by team, birth_date desc
