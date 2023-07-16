WITH cte AS (
    SELECT
        *,
        row_number() over(
            ORDER BY
                date_value
        ) AS rn,
        row_number() over(
            PARTITION BY state
            ORDER BY
                date_value
        ) AS part_rn
    FROM
        tasks
),
xte AS (
    SELECT
        date_value,
        state,
        rn,
        part_rn,
        rn - part_rn AS group_val
    FROM
        cte
)
SELECT
    state,
    min(date_value) AS start_date,
    max(date_value) AS end_date
FROM
    xte
GROUP BY
    state,
    group_val
ORDER BY
    start_date;