WITH cte AS (
    SELECT
        dp.Name AS "Department",
        E.Name AS "Employee",
        salary,
        max(salary) over (PARTITION by DepartmentId) AS max_salary
    FROM
        employee e
        JOIN department dp ON dp.id = e.DepartmentId
)
SELECT
    "Department",
    "Employee",
    max_salary AS Salary
FROM
    cte
WHERE
    max_salary = salary