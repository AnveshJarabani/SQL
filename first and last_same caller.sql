SELECT
    *
FROM
    phonelog;

WITH cte AS (
    SELECT
        callerid,
        datecalled :: date,
        max(datecalled) AS "last",
        min(datecalled) AS "first"
    FROM
        phonelog
    GROUP BY
        callerid,
        datecalled :: date
)
SELECT
    c1.*,
    ph1.recipientid AS last_rec
FROM
    cte c1
    JOIN phonelog ph1 ON c1.callerid = ph1.callerid
    AND c1.last = ph1.datecalled
    JOIN phonelog ph2 ON c1.callerid = ph2.callerid
    AND c1.first = ph2.datecalled
WHERE
    ph1.recipientid = ph2.recipientid