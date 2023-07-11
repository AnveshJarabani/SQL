-- Active: 1688765630308@@localhost@5432@leetcode
SELECT
    name AS "Name"
FROM
    (
        SELECT
            e1.name,
            count(e2.name) ct
        FROM
            employee e1
            JOIN employee e2 ON e1.id = e2.managerid
        GROUP BY
            e1.name
    ) x
WHERE
    ct >= 5;

WITH CTE AS (
    SELECT
        ManagerId,
        count(ManagerId) ct
    FROM
        Employee
    GROUP BY
        managerID
)
SELECT
    name AS "Name"
FROM
    CTE
    JOIN employee e ON e.Id = cte.ManagerId
WHERE
    ct >= 5