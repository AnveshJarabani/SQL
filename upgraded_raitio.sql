-- Given the following two TABLES,
-- RETURN the fraction of users,
-- rounded TO two decimal places,
-- who accessed Amazon music
-- AND upgraded TO prime membership within the FIRST 30 days of signing up.Hekre IS the script: 
WITH cte AS (
    SELECT
        users.user_id,
        EVENTS.type,
        join_date,
        access_date
    FROM
        users
        JOIN EVENTS ON EVENTS.user_id = users.user_id
    WHERE
        TYPE IN ('P', 'Music')
)
SELECT
    round(
        count(
            CASE
                WHEN TYPE = 'P'
                AND access_date <= join_date + 30 THEN 1
                ELSE NULL
            END
        ) / count(
            CASE
                WHEN TYPE = 'Music' THEN 1
                ELSE NULL
            END
        ) :: decimal,
        2
    ) AS ratio
FROM
    cte;