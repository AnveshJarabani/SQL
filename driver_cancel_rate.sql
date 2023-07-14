SELECT
    *
FROM
    trips;

SELECT
    *
FROM
    users;

WITH banned AS (
    SELECT
        users_id
    FROM
        users
    WHERE
        banned = 'Yes'
),
unbanned_transactions AS (
    SELECT
        *,
        CASE
            WHEN STATUS IN ('cancelled_by_client', 'cancelled_by_driver') THEN 1
            ELSE 0
        END AS cancelled,
        CASE
            WHEN STATUS IN ('cancelled_by_client', 'cancelled_by_driver') THEN 0
            ELSE 1
        END AS not_cancelled
    FROM
        trips
    WHERE
        client_id NOT IN (
            SELECT
                users_id
            FROM
                banned
        )
        AND driver_id NOT IN (
            SELECT
                users_id
            FROM
                banned
        )
)
SELECT
    request_at AS "Date",
    to_char(
        (sum(cancelled) :: DECIMAL / count(*) :: DECIMAL) * 100,
        '00.00%'
    ) AS cancel_rate
FROM
    unbanned_transactions
GROUP BY
    request_at;