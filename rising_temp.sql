WITH cte AS (
    SELECT
        *,
        CASE
            WHEN lag(temperature, 1) over(
                ORDER BY
                    id
            ) < temperature THEN 'yes'
            ELSE 'no'
        END AS filt
    FROM
        weather
)
SELECT
    id
FROM
    cte
WHERE
    filt = 'yes';