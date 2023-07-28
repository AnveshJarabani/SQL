-- Active: 1688765630308@@localhost@5432@leetcode
CREATE TABLE IF NOT EXISTS Products1164 (product_id int, new_price int, change_date date);

TRUNCATE TABLE Products1164;

INSERT INTO
    Products1164 (product_id, new_price, change_date)
VALUES
    ('1', '20', '2019-08-14');

INSERT INTO
    Products1164 (product_id, new_price, change_date)
VALUES
    ('2', '50', '2019-08-14');

INSERT INTO
    Products1164 (product_id, new_price, change_date)
VALUES
    ('1', '30', '2019-08-15');

INSERT INTO
    Products1164 (product_id, new_price, change_date)
VALUES
    ('1', '35', '2019-08-16');

INSERT INTO
    Products1164 (product_id, new_price, change_date)
VALUES
    ('2', '65', '2019-08-17');

INSERT INTO
    Products1164 (product_id, new_price, change_date)
VALUES
    ('3', '20', '2019-08-18');

WITH changes AS (
    SELECT
        product_id,
        new_price,
        '2019-08-16' - change_date AS delta
    FROM
        products1164
)
SELECT
    pd.product_id,
    COALESCE(min(ch.new_price), 10) AS price
FROM
    products1164 pd
    LEFT JOIN (
        SELECT
            *
        FROM
            changes
        WHERE
            delta >= 0
    ) ch ON ch.product_id = pd.product_id
GROUP BY
    pd.product_id;
