WITH recursive pages AS (
    SELECT
        0 AS left_pages,
        1 AS right_pages
    UNION
    ALL
    SELECT
        left_pages + 2,
        right_pages + 2
    FROM
        pages
    WHERE
        left_pages + 2 <=(
            SELECT
                max(page_number)
            FROM
                cookbook_titles
        )
        AND right_pages + 2 <=(
            SELECT
                max(page_number)
            FROM
                cookbook_titles
        )
)
SELECT
    left_pages,
    l.title AS left_title,
    r.title AS right_title
FROM
    pages p
    LEFT JOIN cookbook_titles l ON p.left_pages = l.page_number
    LEFT JOIN cookbook_titles r ON p.right_pages = r.page_number
ORDER BY
    left_pages;