-- Active: 1682038109540@@mysql12--2.mysql.database.azure.com@3306@leetcode
-- 1. HOW MANY GAMES HELD?
SELECT
    COUNT(DISTINCT `Games`)
FROM
    athlete_events;

-- 2. LIST OF ALL GAMES HEL
SELECT
    DISTINCT year,
    season,
    city
FROM
    athlete_events
ORDER BY
    year;

-- 3. Total nations participated in each game
WITH cte AS (
    SELECT
        games,
        noc.region
    FROM
        athlete_events ae
        JOIN noc_regions noc ON ae.NOC = noc.NOC
)
SELECT
    games,
    count(DISTINCT region) AS total_countries
FROM
    cte
GROUP BY
    games;

-- 4.Which year saw the highest AND lowest no of countries participating IN olympics ?
WITH cte AS (
    SELECT
        DISTINCT games,
        noc.region
    FROM
        athlete_events ae
        JOIN noc_regions noc ON ae.NOC = noc.NOC
),
x AS (
    SELECT
        games,
        count(DISTINCT region) AS total_countries
    FROM
        cte
    GROUP BY
        games
),
y AS (
    SELECT
        *,
        concat(games, "_", total_countries) AS final
    FROM
        x
)
SELECT
    FIRST_VALUE(final) over (
        ORDER BY
            total_countries ASC
    ) AS least_attendance,
    FIRST_VALUE(final) over (
        ORDER BY
            total_countries DESC
    ) AS highest_attendance
FROM
    y
LIMIT
    1;

-- 5.Which nation has participated IN ALL of the olympic games ? 
WITH cte AS (
    SELECT
        region,
        count(DISTINCT games) AS n_participated
    FROM
        athlete_events ae
        JOIN noc_regions noc ON noc.noc = ae.noc
    GROUP BY
        region
    ORDER BY
        n_participated DESC
),
xte AS (
    SELECT
        count(DISTINCT games) AS n_games
    FROM
        athlete_events
)
SELECT
    region
FROM
    xte
    JOIN cte ON xte.n_games = cte.n_participated;

-- 6.Identify the sport which was played IN ALL summer olympics
WITH cte AS (
    SELECT
        sport,
        count(DISTINCT games) AS no_games
    FROM
        athlete_events
    GROUP BY
        sport
),
xte AS (
    SELECT
        count(DISTINCT games) AS total_games
    FROM
        athlete_events
    WHERE
        Season = 'Summer'
)
SELECT
    sport,
    no_games,
    total_games
FROM
    xte
    JOIN cte ON xte.total_games = cte.no_games
ORDER BY
    sport;

-- 7.Which Sports were just played ONLY once IN the olympics ? 
WITH cte AS (
    SELECT
        sport,
        count(DISTINCT games) AS no_games
    FROM
        athlete_events
    GROUP BY
        sport
)
SELECT
    DISTINCT cte.sport,
    no_games,
    ae.games
FROM
    cte
    JOIN athlete_events ae ON ae.sport = cte.sport
WHERE
    no_games = 1
ORDER BY
    cte.sport;

-- 8.FETCH the total no of sports played IN each olympic games.
SELECT
    games,
    count(DISTINCT sport)
FROM
    athlete_events
WHERE
    games = '2000 Summer'
GROUP BY
    `Games`;

-- 9.FETCH details of the oldest athletes TO win a gold medal.
WITH cte AS (
    SELECT
        name,
        medal,
        age
    FROM
        athlete_events
    WHERE
        medal = 'Gold'
        AND age IS NOT NULL
),
xte AS (
    SELECT
        name,
        medal,
        age,
        DENSE_RANK() over (
            ORDER BY
                age DESC
        ) AS rnk
    FROM
        cte
)
SELECT
    name,
    medal,
    age
FROM
    xte
WHERE
    rnk = 1;

-- 1O.Find the Ratio of male AND female athletes participated IN ALL olympic games.
SELECT
    *
FROM
    athlete_events
LIMIT
    10;

-- WITH xte AS (
--     SELECT 
--         sex
--     FROM
--         athlete_events
--     GROUP BY
--     games,
--         name,
--         sex
-- ),
WITH lte AS (
    SELECT
        CASE
            WHEN sex = 'M' THEN 1
            ELSE 0
        END AS male,
        CASE
            WHEN sex = 'F' THEN 1
            ELSE 0
        END AS female
    FROM
        athlete_events
)
SELECT
    sum(male) / sum(female)
FROM
    lte;

-- 11.FETCH the top 5 athletes who have won the most gold medals.
SELECT
    *
FROM
    athlete_events
LIMIT
    10;

WITH cte AS (
    SELECT
        name,
        CASE
            WHEN medal = 'Gold' THEN 1
            ELSE 0
        END AS gold
    FROM
        athlete_events
)
SELECT
    name,
    sum(gold) AS golds
FROM
    cte
GROUP BY
    name
ORDER BY
    golds DESC
LIMIT
    5;

-- 12.FETCH the top 5 athletes who have won the most medals (gold / silver / bronze).
WITH cte AS (
    SELECT
        name,
        CASE
            WHEN medal IS NOT NULL THEN 1
            ELSE 0
        END AS gold
    FROM
        athlete_events
)
SELECT
    name,
    sum(gold) AS golds
FROM
    cte
GROUP BY
    name
ORDER BY
    golds DESC
LIMIT
    5;

-- 13.FETCH the top 5 most successful countries IN olympics.Success IS defined by no of medals won.
-- 14.List down total gold, silver AND broze medals won by each country.
-- 15.List down total gold,silver AND broze medals won by each country corresponding TO each olympic games.16.Identify which country won the most gold, most silver AND most bronze medals IN each olympic games.
-- 17.Identify which country won the most gold,most silver, most bronze medals AND the most medals IN each olympic games.
-- 18.Which countries have never won gold medal but have won silver / bronze medals ? 
-- 19.IN which Sport / event, India has won highest medals.
-- 20.Break down ALL olympic games WHERE india won medal FOR Hockey AND how many medals IN each olympic games.