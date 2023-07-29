CREATE TABLE LOGS (log_id int);

INSERT INTO
    LOGS (log_id)
VALUES
    (1),
    (2),
    (3),
    (7),
    (8),
    (10);

SELECT
    *
FROM
    LOGS;

WITH consecs AS (
    SELECT
        *,
        log_id - row_number() over(
            ORDER BY
                log_id
        ) AS rn
    FROM
        LOGS
)
SELECT
    min(log_id) AS start_id,
    max(log_id) AS end_id
FROM
    consecs
GROUP BY
    rn
ORDER BY
    start_id;











