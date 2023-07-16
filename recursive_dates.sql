-- IN the FIRST part of this video we are going TO discuss how recursive CTE works.IN SECOND part we will discuss a leet code SQL hard problem WHERE we will be USING recursive CTE concept.
SELECT
    *
FROM
    sales;

WITH recursive cte AS (
    SELECT
        min(period_start) AS dates,
        max(period_end) AS max_date
    FROM
        sales
    UNION
    ALL
    SELECT
        dates + 1 AS dates,
        max_date
    FROM
        cte
    WHERE
        dates < max_date
)
SELECT
    product_id,
    date_part('year', dates) AS report_year,
    sum(average_daily_sales)
FROM
    cte
    JOIN sales ON dates BETWEEN period_start
    AND period_end
GROUP BY
    product_id,
    report_year
ORDER BY
    product_id,
    report_year