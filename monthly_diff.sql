-- Active: 1689145165545@@localhost@5432@postgres@leetcode
WITH monthly_revenues AS (
    SELECT
        to_char(created_at, 'YYYY-MM') AS MONTH,
        sum(value) AS revenue
    FROM
        sf_transactions
    GROUP BY
        MONTH
    ORDER BY
        MONTH
),
revenue_comparisions AS (
    SELECT
        MONTH,
        revenue,
        lag(revenue, 1) over(
            ORDER BY
                MONTH
        ) AS last_month_revenue
    FROM
        monthly_revenues
)
SELECT
    MONTH,
    round(
        (revenue - last_month_revenue) * 100 / last_month_revenue,
        2
    ) AS per_diff
FROM
    revenue_comparisions;