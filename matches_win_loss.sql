SELECT
    *
FROM
    icc_world_cup;

WITH win_list AS (
    SELECT
        team_1 AS team,
        CASE
            WHEN winner = team_1 THEN 1
            ELSE 0
        END AS "won",
        CASE
            WHEN winner != team_1 THEN 0
            ELSE 0
        END AS "lost"
    FROM
        icc_world_cup
    UNION
    ALL
    SELECT
        team_2 AS team,
        CASE
            WHEN winner = team_2 THEN 1
            ELSE 0
        END AS "won",
        CASE
            WHEN winner != team_2 THEN 0
            ELSE 0
        END AS "lost"
    FROM
        icc_world_cup
)
SELECT
    team AS Team_Name,
    count(*) AS Matches_played,
    sum(won) AS no_of_wins,
    sum(lost) AS no_of_losses
FROM
    win_list
GROUP BY
    team
ORDER BY
    count(*) DESC,
    SUM(won) DESC;