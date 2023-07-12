WITH cte AS (
    SELECT
        from_id,
        to_id,
        count(*) AS call_count,
        sum(duration) AS duration
    FROM
        calls
    WHERE
        from_id < to_id
    GROUP BY
        from_id,
        to_id
    UNION
    ALL
    SELECT
        to_id AS from_id,
        from_id AS to_id,
        count(*) AS call_count,
        sum(duration) AS duration
    FROM
        calls
    WHERE
        from_id > to_id
    GROUP BY
        from_id,
        to_id
)
SELECT
    from_id AS "person1",
    to_id AS "person2",
    sum(call_count) AS call_count,
    sum(duration) AS total_duration
FROM
    cte
GROUP BY
    from_id,
    to_id
ORDER BY
    from_id,
    to_id;