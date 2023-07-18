WITH weekly_sales AS (
    SELECT
        extract(
            'week'
            FROM
                to_timestamp(invoicedate, 'DD/MM/YYYY')
        ) AS week_no,
        sum(quantity * unitprice) AS week_total
    FROM
        early_sales
    GROUP BY
        week_no
),
first_day_sales AS (
    SELECT
        extract(
            'week'
            FROM
                to_timestamp(invoicedate, 'DD/MM/YYYY')
        ) AS week_no,
        to_timestamp(invoicedate, 'DD/MM/YYYY') AS first_day_of_week,
        sum(quantity * unitprice) AS first_day_total
    FROM
        early_sales
    WHERE
        date_trunc('week', to_timestamp(invoicedate, 'DD/MM/YYYY')) :: date = to_timestamp(invoicedate, 'DD/MM/YYYY')
    GROUP BY
        first_day_of_week
),
last_day_sales AS(
    SELECT
        extract(
            'week'
            FROM
                to_timestamp(invoicedate, 'DD/MM/YYYY')
        ) AS week_no,
        to_timestamp(invoicedate, 'DD/MM/YYYY') AS last_day_of_week,
        sum(quantity * unitprice) AS last_day_total
    FROM
        early_sales
    WHERE
        to_timestamp(invoicedate, 'DD/MM/YYYY') = (
            date_trunc('week', to_timestamp(invoicedate, 'DD/MM/YYYY')) + INTERVAL '1 week' - INTERVAL '1 day'
        ) :: date
    GROUP BY
        last_day_of_week
) (
    SELECT
        ws.week_no,
        fd.first_day_of_week :: date,
        round(fd.first_day_total * 100 / ws.week_total)
    FROM
        weekly_sales ws
        JOIN first_day_sales fd ON ws.week_no = fd.week_no
)
UNION
ALL
SELECT
    ws.week_no,
    ld.last_day_of_week :: date,
    round(ld.last_day_total * 100 / ws.week_total)
FROM
    weekly_sales ws
    JOIN last_day_sales ld ON ws.week_no = ld.week_no
ORDER BY
    week_no