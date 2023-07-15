-- IN this video we will discuss a problem asked IN a Microsoft interview FOR Data Engineer Position.IN this problem we have TO WRITE a SQL TO build a team WITH a combination of seniors
-- AND juniors within a given salary budget.We will discuss the step by step approach TO solve the problem
-- AND see how powerful are SQL common TABLE Expressions (CTE).Zero TO hero(Advance) SQL Aggregation:
SELECT
    *
FROM
    candidates;

WITH seniors AS (
    SELECT
        *,
        sum(salary) over(
            PARTITION BY experience
            ORDER BY
                salary
        ) AS rsum
    FROM
        candidates
    WHERE
        experience = 'Senior'
),
juniors AS (
    SELECT
        *,
        sum(salary) over(
            PARTITION BY experience
            ORDER BY
                salary
        ) AS rsum
    FROM
        candidates
    WHERE
        experience = 'Junior'
),
seniors_selected AS (
    SELECT
        *
    FROM
        seniors
    WHERE
        rsum <= 70000
),
juniors_selected AS (
    SELECT
        *
    FROM
        juniors
    WHERE
        rsum <=(
            SELECT
                70000 - sum(salary)
            FROM
                seniors_selected
        )
)
SELECT
    *
FROM
    seniors_selected
UNION
ALL
SELECT
    *
FROM
    juniors_selected
ORDER BY
    rsum