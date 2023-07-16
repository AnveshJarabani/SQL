-- Customer retention refers TO the ability of a company OR product TO retain its customers over some specified period.High customer retention means customers of the product OR business tend TO RETURN TO, continue TO buy OR IN some other way NOT defect TO another product OR business, OR TO non - USE entirely.Company programs TO retain customers: Zomato Pro, Cashbacks, Reward Programs etc.Once these programs IN place we need TO build metrics TO CHECK IF programs are working OR NOT.That IS WHERE we will WRITE SQL TO drive customer retention count.
WITH cte AS (
    SELECT
        *,
        to_char(order_date, 'Mon') AS MONTH,
        lead(cust_id, 1, 0) over(
            PARTITION BY cust_id
            ORDER BY
                date_part('month', order_date)
        ) AS churn
    FROM
        transactions
)
SELECT
    MONTH,
    sum(
        CASE
            WHEN churn = 0 THEN 1
        END
    ) AS churn
FROM
    cte
GROUP BY
    MONTH