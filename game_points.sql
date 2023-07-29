-- Active: 1688765630308@@localhost@5432@leetcode
CREATE TABLE teams (team_id int, team_name VARCHAR);

INSERT INTO
    teams (team_id, team_name)
VALUES
    (10, 'Leetcode FC'),
    (20, 'NewYork FC'),
    (30, 'Atlanta FC'),
    (40, 'Chicago FC'),
    (50, 'Toronto FC');

CREATE TABLE matches (
    match_id int,
    host_team int,
    guest_team int,
    host_goals int,
    guest_goals int
);

INSERT INTO
    matches (
        match_id,
        host_team,
        guest_team,
        host_goals,
        guest_goals
    )
VALUES
    (1, 10, 20, 3, 0),
    (2, 30, 10, 2, 2),
    (3, 10, 50, 5, 1),
    (4, 20, 30, 1, 0),
    (5, 50, 30, 1, 0);

WITH all_goals AS (
    SELECT
        host_team AS team_id,
        CASE
            WHEN (host_goals > guest_goals) THEN 3
            WHEN host_goals = guest_goals THEN 1
            ELSE 0
        END AS goals
    FROM
        matches
    UNION
    ALL
    SELECT
        guest_team AS team_id,
        CASE
            WHEN (guest_goals > host_goals) THEN 3
            WHEN guest_goals = host_goals THEN 1
            ELSE 0
        END AS goals
    FROM
        matches
)
SELECT
    t.TEAM_ID,
    TEAM_NAME,
    COALESCE(num_points, 0) AS num_points
FROM
    TEAMS t
    LEFT JOIN (
        SELECT
            team_id,
            sum(goals) AS num_points
        FROM
            all_goals
        GROUP BY
            team_id
    ) ag ON t.team_id = ag.team_id
ORDER BY
    num_points DESC,
    team_name ASC;