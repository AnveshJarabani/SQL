SELECT
    *
FROM
    users;

SELECT
    *
FROM
    orders;

SELECT
    *
FROM
    items;

WITH ranked AS (
    SELECT
        *,
        row_number() over(
            PARTITION BY seller_id
            ORDER BY
                order_date ASC
        ) AS rn
    FROM
        orders
),
filtered AS (
    SELECT
        seller_id,
        item_id
    FROM
        ranked
    WHERE
        rn = 2
),
fav_id AS (
    SELECT
        user_id,
        item_id
    FROM
        users
        JOIN items ON users.favorite_brand = items.item_brand
)
SELECT
    user_id,
    CASE
        WHEN filtered.item_id = fav_id.item_id THEN 'YES'
        ELSE 'NO'
    END AS "2nd_item_fav_brand"
FROM
    filtered
    RIGHT JOIN fav_id ON fav_id.user_id = filtered.seller_id