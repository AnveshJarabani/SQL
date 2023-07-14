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
    company,
    round(avg(salary),2)
FROM
    cte
WHERE
    rn between ct/2 and ct/2+1
group by company