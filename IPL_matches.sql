CREATE TABLE ipl_teams (
    team_code varchar(10),
    team_name varchar(40)
);

INSERT INTO
    ipl_teams
VALUES
    ('RCB', 'Royal Challengers Bangalore'),
    ('MI', 'Mumbai Indians'),
    ('CSK', 'Chennai Super Kings'),
    ('DC', 'Delhi Capitals'),
    ('RR', 'Rajasthan Royals'),
    ('SRH', 'Sunrisers Hyderbad'),
    ('PBKS', 'Punjab Kings'),
    ('KKR', 'Kolkata Knight Riders'),
    ('GT', 'Gujarat Titans'),
    ('LSG', 'Lucknow Super Giants');

SELECT
    *
FROM
    ipl_teams p1;

-- PLAY WITH EVERY TEAM ONCE
WITH cte AS (
    SELECT
        ROW_NUMBER() over(
            ORDER BY
                team_name
        ) AS id,
        team_name
    FROM
        ipl_teams
)
SELECT
    C1.team_name,
    c2.team_name
FROM
    cte c1
    JOIN cte c2 ON c1.id < c2.id
ORDER BY
    c1.team_name;

-- PLAY TWICE WITH EVERY TEAM
WITH cte AS (
    SELECT
        ROW_NUMBER() over(
            ORDER BY
                team_name
        ) AS id,
        team_name
    FROM
        ipl_teams
)
SELECT
    C1.team_name,
    c2.team_name
FROM
    cte c1
    JOIN cte c2 ON c1.id <> c2.id
ORDER BY
    c1.team_name;