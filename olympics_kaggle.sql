-- Active: 1688765630308@@localhost@5432@leetcode
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
SELECT
    *
FROM
    noc_regions;

WITH cte AS (
    SELECT
        region,
        CASE
            WHEN medal IS NOT NULL THEN 1
            ELSE 0
        END AS medals
    FROM
        athlete_events ae
        JOIN noc_regions noc ON noc.noc = ae.noc
),
xte AS (
    SELECT
        region,
        sum(medals) AS total_medals
    FROM
        cte
    GROUP BY
        region
    ORDER BY
        total_medals DESC
)
SELECT
    region,
    total_medals,
    rank() over (
        ORDER BY
            total_medals DESC
    ) AS rnk
FROM
    xte
LIMIT
    5;

-- 14.List down total gold, silver AND broze medals won by each country.
WITH cte AS (
    SELECT
        region,
        IF(medal = 'Gold', 1, 0) gold,
        IF(medal = 'silver', 1, 0) silver,
        IF(medal = 'bronze', 1, 0) bronze
    FROM
        athlete_events ae
        JOIN noc_regions noc ON noc.noc = ae.noc
)
SELECT
    region,
    sum(gold) gold,
    sum(silver) silver,
    sum(bronze) bronze
FROM
    cte
GROUP BY
    region
ORDER BY
    gold DESC,
    silver DESC,
    bronze DESC;

-- 15.List down total gold,silver AND broze medals won by each country corresponding TO each olympic games.
WITH cte AS (
    SELECT
        region,
        games,
        IF(medal = 'Gold', 1, 0) gold,
        IF(medal = 'silver', 1, 0) silver,
        IF(medal = 'bronze', 1, 0) bronze
    FROM
        athlete_events ae
        JOIN noc_regions noc ON noc.noc = ae.noc
)
SELECT
    games,
    region,
    sum(gold) gold,
    sum(silver) silver,
    sum(bronze) bronze
FROM
    cte
GROUP BY
    region,
    games
ORDER BY
    gold DESC,
    silver DESC,
    bronze DESC;

--  16.Identify which country won the most gold, most silver AND most bronze medals IN each olympic games.
WITH cte AS (
    SELECT
        region,
        games,
        IF(medal = 'Gold', 1, 0) gold,
        IF(medal = 'silver', 1, 0) silver,
        IF(medal = 'bronze', 1, 0) bronze
    FROM
        athlete_events ae
        JOIN noc_regions noc ON noc.noc = ae.noc
),
xte AS (
    SELECT
        games,
        region,
        sum(gold) gold,
        sum(silver) silver,
        sum(bronze) bronze
    FROM
        cte
    GROUP BY
        region,
        games
),
yte AS (
    SELECT
        *,
        rank() over (
            PARTITION by games
            ORDER BY
                gold DESC
        ) AS max_gold,
        rank() over (
            PARTITION by games
            ORDER BY
                silver DESC
        ) AS max_silver,
        rank() over (
            PARTITION by games
            ORDER BY
                bronze DESC
        ) AS max_bronze
    FROM
        xte
),
bte AS (
    SELECT
        games,
        IF(max_gold = 1, concat(region, '-', gold), NULL) max_gold,
        IF(
            max_silver = 1,
            concat(region, '-', silver),
            NULL
        ) max_silver,
        IF(
            max_bronze = 1,
            concat(region, '-', bronze),
            NULL
        ) max_bronze
    FROM
        yte
    ORDER BY
        games
)
SELECT
    games,
    GROUP_CONCAT(max_gold) max_gold,
    GROUP_CONCAT(max_silver) max_silver,
    GROUP_CONCAT(max_bronze) max_bronze
FROM
    bte
GROUP BY
    games;

-- 17.Identify which country won the most gold,most silver, most bronze medals AND the most medals IN each olympic games.
WITH cte AS (
    SELECT
        region,
        games,
        IF(medal = 'Gold', 1, 0) gold,
        IF(medal = 'silver', 1, 0) silver,
        IF(medal = 'bronze', 1, 0) bronze
    FROM
        athlete_events ae
        JOIN noc_regions noc ON noc.noc = ae.noc
),
gte AS (
    SELECT
        games,
        region,
        IF(medal IS NOT NULL, 1, 0) medal
    FROM
        athlete_events ae
        JOIN noc_regions noc ON noc.noc = ae.noc
),
qte AS (
    SELECT
        games,
        region,
        sum(medal) AS medals
    FROM
        gte
    GROUP BY
        games,
        region
),
rnkd_all AS (
    SELECT
        games,
        region,
        medals,
        rank() over (
            PARTITION by games
            ORDER BY
                medals DESC
        ) AS rnk
    FROM
        qte
),
max_mdls AS (
    SELECT
        games,
        IF(rnk = 1, concat(region, '-', medals), NULL) AS max_medals
    FROM
        rnkd_all
),
xte AS (
    SELECT
        games,
        region,
        sum(gold) gold,
        sum(silver) silver,
        sum(bronze) bronze
    FROM
        cte
    GROUP BY
        region,
        games
),
yte AS (
    SELECT
        *,
        rank() over (
            PARTITION by games
            ORDER BY
                gold DESC
        ) AS max_gold,
        rank() over (
            PARTITION by games
            ORDER BY
                silver DESC
        ) AS max_silver,
        rank() over (
            PARTITION by games
            ORDER BY
                bronze DESC
        ) AS max_bronze
    FROM
        xte
),
bte AS (
    SELECT
        games,
        IF(max_gold = 1, concat(region, '-', gold), NULL) max_gold,
        IF(
            max_silver = 1,
            concat(region, '-', silver),
            NULL
        ) max_silver,
        IF(
            max_bronze = 1,
            concat(region, '-', bronze),
            NULL
        ) max_bronze
    FROM
        yte
    ORDER BY
        games
),
prevs AS (
    SELECT
        games,
        GROUP_CONCAT(max_gold) max_gold,
        GROUP_CONCAT(max_silver) max_silver,
        GROUP_CONCAT(max_bronze) max_bronze
    FROM
        bte
    GROUP BY
        games
)
SELECT
    prevs.*,
    max_medals
FROM
    prevs
    LEFT JOIN max_mdls mx ON mx.games = prevs.games
WHERE
    max_medals IS NOT NULL;

-- 18.Which countries have never won gold medal but have won silver / bronze medals ? 
WITH cte AS (
    SELECT
        region,
        IF(medal = 'Gold', 1, 0) gold,
        IF(medal = 'silver', 1, 0) silver,
        IF(medal = 'bronze', 1, 0) bronze
    FROM
        athlete_events ae
        JOIN noc_regions noc ON noc.noc = ae.noc
    WHERE
        medal != 'Gold'
        AND medal IS NOT NULL
)
SELECT
    region,
    sum(gold) gold,
    sum(silver) silver,
    sum(bronze) bronze
FROM
    cte
GROUP BY
    region;

-- 19.IN which Sport / event, India has won highest medals.
WITH cte AS (
    SELECT
        region,
        sport,
        IF(medal IS NOT NULL, 1, 0) medal
    FROM
        athlete_events ae
        JOIN noc_regions noc ON noc.noc = ae.noc
),
xte AS (
    SELECT
        sport,
        sum(medal) total_medals
    FROM
        cte
    WHERE
        region = 'India'
    GROUP BY
        sport
)
SELECT
    sport,
    total_medals
FROM
    xte
ORDER BY
    total_medals DESC
LIMIT
    1;

-- 20.Break down ALL olympic games WHERE india won medal FOR Hockey AND how many medals IN each olympic games.
WITH cte AS (
    SELECT
        region,
        sport,
        games,
        IF(medal IS NOT NULL, 1, 0) medal
    FROM
        athlete_events ae
        JOIN noc_regions noc ON noc.noc = ae.noc
    WHERE
        region = 'India'
        AND sport = 'Hockey'
        AND medal IS NOT NULL
),
xte AS (
    SELECT
        sport,
        games,
        sum(medal) total_medals
    FROM
        cte
    GROUP BY
        sport,
        games
)
SELECT
    *
FROM
    xte
ORDER BY
    total_medals DESC;