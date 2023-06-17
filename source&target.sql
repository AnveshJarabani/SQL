-- Active: 1682038109540@@mysql12--2.mysql.database.azure.com@3306@leetcode
CREATE TABLE target (id int, name varchar(1));

CREATE TABLE source (id int, name varchar(1));

INSERT INTO
    source
VALUES
    (1, 'A'),
    (2, 'B'),
    (3, 'C'),
    (4, 'D');

INSERT INTO
    target
VALUES
    (1, 'A'),
    (2, 'B'),
    (4, 'X'),
    (5, 'F');

WITH cte AS (
    SELECT
        s.id,
        CASE
            WHEN s.Name <> t.name THEN 'Mismatch'
        END AS COMMENT
    FROM
        source s
        LEFT JOIN target t ON s.id = t.id
    UNION
    SELECT
        s.id,
        CASE
            WHEN t.name IS NULL THEN 'New in Source'
        END AS COMMENT
    FROM
        source s
        LEFT JOIN target t ON s.id = t.id
    UNION
    SELECT
        t.id,
        CASE
            WHEN s.name IS NULL THEN 'New in target'
        END AS COMMENT
    FROM
        source s
        RIGHT JOIN target t ON s.id = t.id
)
SELECT
    *
FROM
    cte
WHERE
    COMMENT IS NOT NULL;

-- ---------- OTHER SOLUTION ----------------------------------------------------------------
SELECT
    s.id,
    'Mismatch' AS COMMENT
FROM
    source s
    JOIN target t ON s.id = t.id
    AND s.name <> t.name
UNION
SELECT
    s.id,
    'New in Source' AS COMMENT
FROM
    source s
    LEFT JOIN target t ON s.id = t.id
WHERE
    t.id IS NULL
UNION
SELECT
    t.id,
    'New in target' AS COMMENT
FROM
    source s
    RIGHT JOIN target t ON s.id = t.id
WHERE
    s.id IS NULL