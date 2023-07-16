-- Customer retention refers TO the ability of a company OR product TO retain its customers over some specified period.High customer retention means customers of the product OR business tend TO RETURN TO, continue TO buy OR IN some other way NOT defect TO another product OR business, OR TO non - USE entirely.Company programs TO retain customers: Zomato Pro, Cashbacks, Reward Programs etc.Once these programs IN place we need TO build metrics TO CHECK IF programs are working OR NOT.That IS WHERE we will WRITE SQL TO drive customer retention count.IF you preparing FOR SQL interviews FOR product based companies 
WITH cte AS(
    SELECT
        to_char(order_date, 'Mon') AS MONTH,
        count(order_id) over(
            PARTITION by cust_id
            ORDER BY
                order_date
        ) AS running_ct
    FROM
        transactions
)
SELECT
    MONTH,
    sum(
        CASE
            WHEN running_ct = 1 THEN 1
            ELSE 0
        END
    ) AS new_customers,
    sum(
        CASE
            WHEN running_ct > 1 THEN 1
            ELSE 0
        END
    ) AS old_customers
FROM
    cte
GROUP BY
    MONTH;

SELECT
    *
FROM
    transactions