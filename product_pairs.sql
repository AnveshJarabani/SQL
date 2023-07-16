-- Product recommendation.Just the basic TYPE (“ customers who bought this also bought … ”).That, IN its simplest form,
-- IS an outcome of basket analysis.IN this video we will learn how TO find products which are most frequently bought together USING simple SQL.Based ON the history ecommerce website can recommend products TO new user.
SELECT
    *
FROM
    orders;

SELECT
    *
FROM
    products;

WITH cte AS (
    SELECT
        o1.order_id,
        o1.customer_id,
        o1.product_id AS p1,
        o2.product_id AS p2
    FROM
        orders o1
        JOIN orders o2 ON o1.order_id = o2.order_id
        AND o1.customer_id = o2.customer_id
        AND o1.product_id < o2.product_id
)
SELECT
    concat(p1.name, ' ', p2.name) AS product_pairs,
    count(*) AS frequency
FROM
    cte
    JOIN products p1 ON p1.id = cte.p1
    JOIN products p2 ON p2.id = cte.p2
GROUP BY
    product_pairs;