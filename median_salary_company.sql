WITH cte AS (
    SELECT
        *,
        row_number() over(
            PARTITION by company
            ORDER BY
                salary
        ) AS rn,
        count(*) over(PARTITION BY company) AS ct
    FROM
        employee
)
SELECT
    emp_id,
    company,
    salary
FROM
    cte
WHERE
    rn = ceil((ct / 2) + 1)