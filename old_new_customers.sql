WITH cte AS (
    SELECT
        *,
        rank() over(
            PARTITION by customer_id
            ORDER BY
                order_date
        ) AS rn
    FROM
        customer_orders
),
filterd AS (
    SELECT
        *,
        CASE
            WHEN rn = 1 THEN 1
            ELSE 0
        END AS New_customer,
        CASE
            WHEN rn != 1 THEN 1
            ELSE 0
        END AS Old_customer
    FROM
        cte
)
SELECT
    order_date,
    sum(new_customer) AS New_customers,
    sum(old_customer) AS Old_customers
FROM
    filterd
GROUP BY
    order_date
ORDER BY
    order_date