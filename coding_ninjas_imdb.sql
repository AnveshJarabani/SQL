-- BUDGET HIGHER THAN 4 CR
SELECT
    imdb.movie_id,
    title
FROM
    imdb
    JOIN genre ON imdb.movie_id = genre.movie_id
WHERE
    genre LIKE 'C%'
    AND budget > 40000000
    AND reverse(
        substring(
            reverse(title),
            position(')' IN reverse(title)) + 1,
            position('(' IN reverse(title)) -2
        )
    ) :: integer = 2014;

--  Print the title
-- AND ratings of the movies released IN 2012 whose metacritic rating IS more than 60
-- AND Domestic collections exceed 10 Crores.(
--     Download the dataset  FROM console
SELECT
    title,
    rating
FROM
    imdb
    JOIN earning er ON er.movie_id = imdb.movie_id
WHERE
    domestic > 100000000
    AND metacritic > 60
    AND reverse(
        substring(
            reverse(title),
            position(')' IN reverse(title)) + 1,
            position('(' IN reverse(title)) -2
        )
    ) :: integer = 2012;

-- Print the genre and the maximum net profit among all
-- the movies of that genre released in 2012 per genre.
SELECT
    genre,
    max(domestic + worldwide - budget) AS net_profit
FROM
    imdb
    JOIN genre ON imdb.movie_id = genre.movie_id
    JOIN earning ON earning.movie_id = imdb.movie_id
WHERE
    reverse(
        substring(
            reverse(title),
            position(')' IN reverse(title)) + 1,
            position('(' IN reverse(title)) -2
        )
    ) :: integer = 2012
    AND genre IS NOT NULL
GROUP BY
    genre
ORDER BY
    genre;

WITH cte AS (
    SELECT
        genre,
        round((rating + metacritic / 10) / 2, 2) AS weighted_rating
    FROM
        imdb
        JOIN genre ON genre.movie_id = imdb.movie_id
    WHERE
        genre IS NOT NULL
        AND reverse(
            substring(
                reverse(title),
                position(')' IN reverse(title)) + 1,
                position('(' IN reverse(title)) -2
            )
        ) :: integer = 2014
    ORDER BY
        genre
)
SELECT
    genre,
    max(weighted_rating) AS weighted_rating
FROM
    cte
GROUP BY
    genre
ORDER BY
    genre;