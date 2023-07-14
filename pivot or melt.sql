SELECT
    city,
    string_agg(name, ',')
FROM
    players_location
GROUP BY
    city;

SELECT
    max(
        CASE
            WHEN city = 'Bangalore' THEN name
        END
    ) AS Bangalore,
    max(
        CASE
            WHEN city = 'Mumbai' THEN name
        END
    ) AS Mumbai,
    max(
        CASE
            WHEN city = 'Delhi' THEN name
        END
    ) AS Delhi
FROM
    (
        SELECT
            *,
            row_number() over(
                PARTITION by city
                ORDER BY
                    name
            ) pg
        FROM
            players_location
    ) a
GROUP BY
    pg
ORDER BY
    pg