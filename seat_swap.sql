-- Active: 1688765630308@@localhost@5432@leetcode
SELECT
    *,
    CASE
        WHEN id % 2 = 0 THEN lag(student, 1, student) over()
        WHEN id % 2 != 0 THEN lead(student, 1, student) over()
    END AS s1
FROM
    seat