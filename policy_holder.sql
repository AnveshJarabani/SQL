-- Active: 1688765630308@@localhost@5432@leetcode
WITH cte AS (
    SELECT
        *,
        count(tiv_2015) over(PARTITION by tiv_2015) AS ct_2015,
        count(concat(lat :: VARCHAR, lon :: varchar)) over(
            PARTITION by concat(lat :: varchar, lon :: varchar)
        ) AS locations
    FROM
        insurance
)
SELECT
    sum(tiv_2016) AS "TIV_2016"
FROM
    cte
WHERE
    locations = 1
    AND ct_2015 > 1