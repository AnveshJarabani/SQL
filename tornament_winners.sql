SELECT
    *
FROM
    players;

SELECT
    *
FROM
    matches;

WITH player_scores AS (
    SELECT
        first_player AS player,
        first_score AS score
    FROM
        matches
    UNION
    ALL
    SELECT
        second_player AS player,
        second_score AS score
    FROM
        matches
),
player_totals AS (
    SELECT
        player,
        sum(score) AS total_score
    FROM
        player_scores
    GROUP BY
        player
),
ranks AS (
    SELECT
        player,
        group_id,
        total_score,
        rank() over(
            PARTITION BY group_id
            ORDER BY
                total_score DESC,
                player ASC
        ) AS rn
    FROM
        player_totals pt
        JOIN players ps ON ps.player_id = pt.player
)
SELECT
    group_id,
    player AS winner,
    total_score
FROM
    ranks
WHERE
    rn = 1