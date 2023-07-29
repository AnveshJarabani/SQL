CREATE TABLE movies (movie_id int, title varchar);

INSERT INTO
    movies (movie_id, title)
VALUES
    (1, 'Avengers'),
    (2, 'Frozen 2'),
    (3, 'Joker');

CREATE TABLE Users (user_id int, user_name varchar);

INSERT INTO
    users (user_id, user_name)
VALUES
    (1, 'Daniel'),
    (2, 'Monica'),
    (3, 'Maria'),
    (4, 'James');

CREATE TABLE movie_rating (
    movie_id int,
    user_id int,
    rating int,
    created_at date
);

INSERT INTO
    movie_rating (movie_id, user_id, rating, created_at)
VALUES
    (1, 1, 3, '2020-01-12'),
    (1, 2, 4, '2020-02-11'),
    (1, 3, 2, '2020-02-12'),
    (1, 4, 1, '2020-01-01'),
    (2, 1, 5, '2020-02-17'),
    (2, 2, 2, '2020-02-01'),
    (2, 3, 2, '2020-03-01'),
    (3, 1, 3, '2020-02-22'),
    (3, 2, 4, '2020-02-25');

(
    SELECT
        user_name AS results
    FROM
        (
            SELECT
                user_name,
                count(mr.user_id) AS rating_ct
            FROM
                users
                JOIN movie_rating mr ON mr.user_id = users.user_id
            GROUP BY
                user_name
        ) x
    ORDER BY
        rating_ct DESC,
        user_name ASC
    LIMIT
        1
)
UNION
ALL (
    SELECT
        title AS results
    FROM
        (
            SELECT
                title,
                avg(rating) AS rating
            FROM
                movie_rating mr
                JOIN movies ON movies.movie_id = mr.movie_id
            WHERE
                to_char(created_at, 'YYYY-mm') = '2020-02'
            GROUP BY
                title
        ) y
    ORDER BY
        rating DESC,
        title ASC
    LIMIT
        1
);