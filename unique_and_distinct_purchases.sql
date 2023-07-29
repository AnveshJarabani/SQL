WITH cte AS (
    SELECT
        spend_date,
        max(platform) AS platform,
        count(DISTINCT user_id) AS total_users,
        sum(amount) AS total_amount
    FROM
        spending
    GROUP BY
        spend_date,
        user_id
    HAVING
        count(DISTINCT platform) = 1
    UNION
    ALL
    SELECT
        spend_date,
        CASE
            WHEN count(DISTINCT platform) > 1 THEN 'both'
        END AS platform,
        count(DISTINCT user_id) AS total_users,
        sum(amount) AS total_amount
    FROM
        spending
    GROUP BY
        spend_date,
        user_id
    HAVING
        count(DISTINCT platform) > 1
    UNION
    ALL
    SELECT
        DISTINCT spend_date,
        'both' AS platform,
        0 AS total_users,
        0 AS total_amount
    FROM
        spending
)
SELECT
    spend_date,
    platform,
    sum(total_users) AS total_users,
    sum(total_amount) AS total_amount
FROM
    cte
GROUP BY
    spend_date,
    platform
ORDER BY
    spend_date ASC,
    total_users DESC,
    total_amount DESC



