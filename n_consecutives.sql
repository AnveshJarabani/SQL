WITH cte AS (
    SELECT
        *,
        id - row_number() over(
            ORDER BY
                id
        ) AS rn
    FROM
        stadium
    WHERE
        no_of_people >= 100
),
xte AS (
    SELECT
        id,
        visit_date,
        no_of_people,
        count(rn) over(PARTITION by rn) AS ct
    FROM
        cte
)
SELECT
    id,
    visit_date,
    no_of_people
FROM
    xte
WHERE
    ct >= 3