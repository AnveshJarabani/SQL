WITH most_visited AS (
    SELECT
        name,
        floor,
        count(*) AS floor_count
    FROM
        entries
    GROUP BY
        name,
        floor
),
floor_rank AS (
    SELECT
        name,
        floor,
        rank() over(
            PARTITION by name
            ORDER BY
                floor_count DESC
        ) AS floor_rank
    FROM
        most_visited
),
most_visited_floors AS(
    SELECT
        name,
        floor
    FROM
        floor_rank
    WHERE
        floor_rank = 1
),
total_visits AS(
    SELECT
        name,
        count(name) AS total_visits
    FROM
        entries
    GROUP BY
        name
    ORDER BY
        name
),
used_resources AS(
    SELECT
        name,
        string_agg(DISTINCT resources, ',') AS resources_used
    FROM
        entries
    GROUP BY
        name
)
SELECT
    mv.name,
    total_visits,
    mv.floor AS most_visited_floor,
    resources_used
FROM
    most_visited_floors mv
    JOIN total_visits tv ON tv.name = mv.name
    JOIN used_resources r ON r.name = mv.name;