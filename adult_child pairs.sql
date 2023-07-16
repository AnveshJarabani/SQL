-- IN this video we will solve a SQL interview problem asked IN tiger analytics FOR a data engineer position.We are going TO solve the original problem AND IN the SECOND part of the video we solve it WITH a twist IN the problem.
WITH adults AS (
    SELECT
        *,
        ROW_NUMBER() over(
            ORDER BY
                age DESC
        ) AS rn
    FROM
        family
    WHERE
        TYPE = 'Adult'
),
childs AS (
    SELECT
        *,
        row_number() over(
            ORDER BY
                age ASC
        ) AS rn
    FROM
        family
    WHERE
        TYPE = 'Child'
)
SELECT
    concat(a.person, ' ', c.person) AS pair
FROM
    adults a
    LEFT JOIN childs c ON a.rn = c.rn
ORDER BY
    a.age DESC;

SELECT
    *
FROM
    family