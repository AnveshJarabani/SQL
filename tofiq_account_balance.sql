-- Active: 1682038109540@@mysql12--2.mysql.database.azure.com@3306@leetcode
DROP TABLE IF EXISTS account_balance;

CREATE TABLE account_balance (
    account_no varchar(20),
    transaction_date date,
    debit_credit varchar(10),
    transaction_amount decimal
);

INSERT INTO
    account_balance
VALUES
    (
        'acc_1',
        STR_TO_DATE('2022-01-20', '%Y-%m-%d'),
        'credit',
        100
    );

INSERT INTO
    account_balance
VALUES
    (
        'acc_1',
        STR_TO_DATE('2022-01-21', '%Y-%m-%d'),
        'credit',
        500
    );

INSERT INTO
    account_balance
VALUES
    (
        'acc_1',
        STR_TO_DATE('2022-01-22', '%Y-%m-%d'),
        'credit',
        300
    );

INSERT INTO
    account_balance
VALUES
    (
        'acc_1',
        STR_TO_DATE('2022-01-23', '%Y-%m-%d'),
        'credit',
        200
    );

INSERT INTO
    account_balance
VALUES
    (
        'acc_2',
        STR_TO_DATE('2022-01-20', '%Y-%m-%d'),
        'credit',
        500
    );

INSERT INTO
    account_balance
VALUES
    (
        'acc_2',
        STR_TO_DATE('2022-01-21', '%Y-%m-%d'),
        'credit',
        1100
    );

INSERT INTO
    account_balance
VALUES
    (
        'acc_2',
        STR_TO_DATE('2022-01-22', '%Y-%m-%d'),
        'debit',
        1000
    );

INSERT INTO
    account_balance
VALUES
    (
        'acc_3',
        STR_TO_DATE('2022-01-20', '%Y-%m-%d'),
        'credit',
        1000
    );

INSERT INTO
    account_balance
VALUES
    (
        'acc_4',
        STR_TO_DATE('2022-01-20', '%Y-%m-%d'),
        'credit',
        1500
    );

INSERT INTO
    account_balance
VALUES
    (
        'acc_4',
        STR_TO_DATE('2022-01-21', '%Y-%m-%d'),
        'debit',
        500
    );

INSERT INTO
    account_balance
VALUES
    (
        'acc_5',
        STR_TO_DATE('2022-01-20', '%Y-%m-%d'),
        'credit',
        900
    );

WITH CTE AS (
    SELECT
        *,
        CASE
            WHEN ROLLING_SUM >= 1000 THEN 1
            ELSE 0
        END AS FLAG
    FROM
        (
            SELECT
                *,
                SUM(transaction_amount) over(PARTITION BY account_no) AS total_amount,
                SUM(transaction_amount) OVER (
                    PARTITION BY account_no
                    ORDER BY
                        transaction_date
                ) AS ROLLING_SUM
            FROM
                account_balance
        ) X
)
SELECT
    account_no,
    min(transaction_date)
FROM
    CTE
WHERE
    TOTAL_AMOUNT >= 1000
    AND FLAG = 1
GROUP BY
    account_no;