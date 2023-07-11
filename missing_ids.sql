-- Active: 1688765630308@@localhost@5432@leetcode
WITH RECURSIVE cte AS(
    SELECT
        min(customer_id) AS all_id
    FROM
        customers
    UNION
    ALL
    SELECT
        all_id + 1 AS all_id
    FROM
        cte
    WHERE
        all_id + 1 <=(
            SELECT
                max(customer_id)
            FROM
                customers
        )
)
SELECT
    all_id AS ids
FROM
    cte
WHERE
    all_id NOT IN (
        SELECT
            customer_id
        FROM
            customers
    )