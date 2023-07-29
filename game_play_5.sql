WITH installs AS (
    SELECT
        *,
        rank() over(
            PARTITION by player_id
            ORDER BY
                event_date ASC
        ) AS first_install,
        CASE
            WHEN lead(event_date, 1) over(
                PARTITION BY player_id
                ORDER BY
                    event_date
            ) = event_date + 1 THEN 1
            ELSE 0
        END AS played_next_day
    FROM
        gameplay
    ORDER BY
        event_date
)
SELECT
    event_date,
    sum(first_install) AS installs,
    round(sum(played_next_day) / sum(first_install), 2) AS retained
FROM
    installs
WHERE
    first_install = 1
GROUP BY
    event_date