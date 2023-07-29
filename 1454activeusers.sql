-- Active: 1689145165545@@localhost@5432@postgres@leetcode
CREATE TABLE accounts (id int, name varchar);

INSERT INTO
    accounts (id, name)
VALUES
    (1, 'Winston'),
    (7, 'Jonathan');

CREATE TABLE logins (id int, login_date date);

INSERT INTO
    logins (id, login_date)
VALUES
    (7, '2020-05-30'),
    (1, '2020-05-30'),
    (7, '2020-05-31'),
    (7, '2020-06-01'),
    (7, '2020-06-02'),
    (7, '2020-06-02'),
    (7, '2020-06-03'),
    (1, '2020-06-07'),
    (7, '2020-06-10');

WITH consecs AS (
    SELECT
        id,
        login_date,
        date_trunc('day', login_date) - INTERVAL '1 day' * rank() over(
            PARTITION by id
            ORDER BY
                login_date
        ) AS rn
    FROM
        logins
)
SELECT
    id
FROM
    consecs
GROUP BY
    id,
    rn
HAVING
    count(id) >= 5;

SELECT
    DISTINCT a.id,
    name
FROM
    logins a
    JOIN logins b ON a.id = b.id
    AND b.login_date - a.login_date BETWEEN 1
    AND 4
    JOIN accounts ON a.id = accounts.id
GROUP BY
    a.id,
    name
HAVING
    count(a.id) >= 4;