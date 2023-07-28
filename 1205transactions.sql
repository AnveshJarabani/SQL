CREATE TYPE NEW_STATE AS ENUM ('approved', 'declined','chargeback');


CREATE TABLE Transactions (
    id int,
    country varchar,
    STATUS state,
    amount int,
    trans_date date
);

INSERT INTO
    transactions (id, country, STATUS, amount, trans_date)
VALUES
    (101, 'US', 'approved', 1000, '2019-05-18'),
    (102, 'US', 'declined', 2000, '2019-05-19'),
    (103, 'US', 'approved', 3000, '2019-06-10'),
    (104, 'US', 'approved', 4000, '2019-06-13'),
    (105, 'US', 'approved', 5000, '2019-06-15');

CREATE TABLE Chargebacks (trans_id int, trans_date date);

INSERT INTO
    chargebacks (trans_id, trans_date)
VALUES
    (102, '2019-05-29'),
    (101, '2019-06-30'),
    (105, '2019-09-18');

SELECT
    to_char(trans_date, '%Y-%m') AS MONTH,
    country,
    sum(
        CASE
            WHEN state = 'approved' THEN 1
            ELSE 0
        END
    ) AS approved_count,
    sum(
        CASE
            WHEN state = 'approved' THEN amount
            ELSE 0
        END
    ) AS approved_amount,
    sum(
        CASE
            WHEN state = 'chargeback' THEN 1
            ELSE 0
        END
    ) AS chargeback_count,
    sum(
        CASE
            WHEN state = 'chargeback' THEN amount
            ELSE 0
        END
    ) AS chargeback_amount
FROM
(
        SELECT
            c.trans_id,
            t.country,
            'chargeback' AS NEW_STATE,
            t.amount,
            c.trans_date
        FROM
            Chargebacks AS c
            JOIN Transactions t ON c.trans_id = t.id
        UNION
        ALL
        SELECT
            *
        FROM
            Transactions
    ) AS t1
GROUP BY
    country,
    MONTH
HAVING
    approved_amount > 0
    OR chargeback_amount > 0