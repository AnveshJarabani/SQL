
SELECT
    CASE
        WHEN count(*) >= 2 THEN max(salary)
        ELSE NULL
    END AS SecondHighestSalray
FROM
    employee
WHERE
    salary <(
        SELECT
            max(salary)
        FROM
            employee
    );