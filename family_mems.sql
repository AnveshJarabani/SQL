-- Active: 1682038109540@@mysql12--2.mysql.database.azure.com@3306@leetcode
DROP TABLE IF EXISTS family_members;

CREATE TABLE family_members (
    person_id varchar(20),
    relative_id1 varchar(20),
    relative_id2 varchar(20)
);

INSERT INTO
    family_members
VALUES
    ('ATR-1', NULL, NULL),
    ('ATR-2', 'ATR-1', NULL),
    ('ATR-3', 'ATR-2', NULL),
    ('ATR-4', 'ATR-3', NULL),
    ('ATR-5', 'ATR-4', NULL),
    ('BTR-1', NULL, NULL),
    ('BTR-2', NULL, 'BTR-1'),
    ('BTR-3', NULL, 'BTR-2'),
    ('BTR-4', NULL, 'BTR-3'),
    ('BTR-5', NULL, 'BTR-4'),
    ('CTR-1', NULL, 'CTR-3'),
    ('CTR-2', 'CTR-1', NULL),
    ('CTR-3', NULL, NULL),
    ('DTR-1', 'DTR-3', 'ETR-2'),
    ('DTR-2', NULL, NULL),
    ('DTR-3', NULL, NULL),
    ('ETR-1', NULL, 'DTR-2'),
    ('ETR-2', NULL, NULL),
    ('FTR-1', NULL, NULL),
    ('FTR-2', NULL, NULL),
    ('FTR-3', NULL, NULL),
    ('GTR-1', 'GTR-1', NULL),
    ('GTR-2', 'GTR-1', NULL),
    ('GTR-3', 'GTR-1', NULL),
    ('HTR-1', 'GTR-1', NULL),
    ('HTR-2', 'GTR-1', NULL),
    ('HTR-3', 'GTR-1', NULL),
    ('ITR-1', NULL, NULL),
    ('ITR-2', 'ITR-3', 'ITR-1'),
    ('ITR-3', NULL, NULL);

SELECT
    *
FROM
    family_members;

WITH RECURSIVE related_fam_members AS (
    SELECT
        *
    FROM
        (
            SELECT
                relative_id1 AS relatives,
                SUBSTR(person_id, 1, 3) AS fam_group
            FROM
                family_members
            WHERE
                relative_id1 IS NOT NULL
            UNION
            SELECT
                relative_id2,
                SUBSTR(person_id, 1, 3) AS fam_group
            FROM
                family_members
            WHERE
                relative_id2 IS NOT NULL
            ORDER BY
                relatives
        ) x
    UNION
    SELECT
        fam.person_id,
        r.fam_group
    FROM
        related_fam_members r
        JOIN family_members fam ON fam.relative_id1 = r.relatives
        OR fam.relative_id2 = r.relatives
),
base_query AS (
    SELECT
        relative_id1 AS relatives,
        SUBSTR(person_id, 1, 3) AS fam_group
    FROM
        family_members
    WHERE
        relative_id1 IS NOT NULL
    UNION
    SELECT
        relative_id2,
        SUBSTR(person_id, 1, 3) AS fam_group
    FROM
        family_members
    WHERE
        relative_id2 IS NOT NULL
    ORDER BY
        relatives
),
no_relatives AS (
    SELECT
        person_id
    FROM
        family_members fam
    WHERE
        relative_id1 IS NULL
        AND relative_id2 IS NULL
        AND person_id NOT IN (
            SELECT
                relatives
            FROM
                base_query
        )
),
cte AS (
    SELECT
        GROUP_CONCAT(
            relatives,
            ""
            ORDER BY
                relatives
        ) AS relatives
    FROM
        related_fam_members
    GROUP BY
        fam_group
    UNION
    SELECT
        *
    FROM
        no_relatives
)
SELECT
    *,
    concat(
        'F_',
        ROW_NUMBER() over(
            ORDER BY
                relatives
        )
    ) AS Family_ID
FROM
    cte;