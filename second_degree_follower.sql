WITH cte AS (
    SELECT
        CASE
            WHEN followee IN (
                SELECT
                    follower
                FROM
                    follow
            ) THEN followee
        END AS follower
    FROM
        follow
)
SELECT
    follower,
    count(follower) AS num
FROM
    cte
WHERE
    follower IS NOT NULL
GROUP BY
    follower
ORDER BY
    follower