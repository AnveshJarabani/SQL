CREATE TABLE customer (
    customer_id int,
    name VARCHAR,
    visited_on date,
    amount int
);

INSERT INTO
    customer (customer_id, name, visited_on, amount)
VALUES
    (1, 'Jhon', '2019-01-01', 100),
    (2, 'Daniel', '2019-01-02', 110),
    (3, 'Jade', '2019-01-03', 120),
    (4, 'Khaled', '2019-01-04', 130),
    (5, 'Winston', '2019-01-05', 110),
    (6, 'Elvis', '2019-01-06', 140),
    (7, 'Anna', '2019-01-07', 150),
    (8, 'Maria', '2019-01-08', 80),
    (9, 'Jaze', '2019-01-09', 110),
    (1, 'Jhon', '2019-01-10', 130),
    (3, 'Jade', '2019-01-10', 150);

WITH grouped_dates AS (
    SELECT
        visited_on,
        sum(amount) AS total_amount
    FROM
        customer
    GROUP BY
        visited_on
),
rolling_values AS (
    SELECT
        visited_on,
        sum(total_amount) over(
            ORDER BY
                visited_on ROWS BETWEEN 6 preceding
                AND current ROW
        ) AS amount,
        avg(total_amount) over(
            ORDER BY
                visited_on ROWS BETWEEN 6 preceding
                AND current ROW
        ) AS average_amount
    FROM
        grouped_dates
)
SELECT
    visited_on,
    round(amount, 0) AS amount,
    round(average_amount, 2) AS average_amount
FROM
    rolling_values
WHERE
    visited_on >= (
        SELECT
            visited_on
        FROM
            rolling_values
        ORDER BY
            visited_on
        LIMIT
            1
    ) + 6