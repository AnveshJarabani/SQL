SELECT
    *
FROM
    students;

WITH cte AS (
    SELECT
        s.student_id,
        s.student_name,
        score,
        max(score) over(PARTITION BY exam_id) AS mx,
        min(score) over(PARTITION BY exam_id) AS mn
    FROM
        exams e
        JOIN students s ON e.student_id = s.student_id
)
SELECT
    DISTINCT student_id,
    student_name
FROM
    cte
WHERE
    score != mx
    AND score != mn
    AND student_id NOT IN (
        SELECT
            student_id
        FROM
            cte
        WHERE
            score = mx
            OR score = mn
    );