-- Active: 1682009795450@@mysql12--2.mysql.database.azure.com@3306@leetcode
SELECT
    *
FROM
    student_list;

SELECT
    *
FROM
    student_response;

SELECT
    *
FROM
    correct_answer;

SELECT
    *
FROM
    question_paper_code;

WITH cte AS (
    SELECT
        sl.roll_number,
        student_name,
        sl.class,
        sl.section,
        school_name,
        subject,
        CASE
            WHEN option_marked = correct_option
            AND option_marked <> "e" THEN 1
            ELSE 0
        END AS correct_score,
        CASE
            WHEN option_marked != correct_option
            AND option_marked <> "e" THEN 1
            ELSE 0
        END AS incorrect_score,
        CASE
            WHEN option_marked = 'e' THEN 1
            ELSE 0
        END AS yet_to_learn
    FROM
        student_response sr
        LEFT JOIN correct_answer ca ON sr.question_paper_code = ca.question_paper_code
        AND sr.question_number = ca.question_number
        LEFT JOIN question_paper_code qc ON qc.paper_code = sr.question_paper_code
        LEFT JOIN student_list sl ON sl.roll_number = sr.roll_number
)
SELECT
    roll_number,
    student_name,
    class,
    section,
    school_name,
    sum(math_correct) AS math_correct,
    sum(math_incorrect) AS math_incorrect,
    sum(math_yet_to_learn) AS math_yet_to_learn,
    sum(math_correct) AS math_score,
    round(
        sum(math_correct) * 100 / (
            sum(math_incorrect) + sum(math_yet_to_learn) + sum(math_correct)
        ),
        2
    ) AS Math_percentage,
    sum(science_correct) AS science_correct,
    sum(science_incorrect) AS science_incorrect,
    sum(science_yet_to_learn) AS science_yet_to_learn,
    sum(science_correct) AS Science_score,
    round(
        sum(science_correct) * 100 / (
            sum(science_incorrect) + sum(science_yet_to_learn) + sum(science_correct)
        ),
        2
    ) AS science_Percentage
FROM
    (
        SELECT
            roll_number,
            student_name,
            class,
            section,
            school_name,
            subject,
            CASE
                WHEN subject = 'Math' THEN correct
                ELSE 0
            END AS Math_correct,
            CASE
                WHEN subject = 'Math' THEN wrong
                ELSE 0
            END AS Math_incorrect,
            CASE
                WHEN subject = 'Science' THEN correct
                ELSE 0
            END AS Science_correct,
            CASE
                WHEN subject = 'Science' THEN wrong
                ELSE 0
            END AS Science_incorrect,
            CASE
                WHEN subject = 'Math' THEN yet_to_learn
                ELSE 0
            END AS Math_yet_to_learn,
            CASE
                WHEN subject = 'Science' THEN yet_to_learn
                ELSE 0
            END AS Science_yet_to_learn
        FROM
            (
                SELECT
                    roll_number,
                    student_name,
                    class,
                    section,
                    school_name,
                    subject,
                    sum(correct_score) AS correct,
                    sum(incorrect_score) AS wrong,
                    sum(yet_to_learn) AS yet_to_learn
                FROM
                    cte
                GROUP BY
                    roll_number,
                    student_name,
                    class,
                    section,
                    school_name,
                    subject
            ) x
        GROUP BY
            roll_number,
            student_name,
            class,
            section,
            school_name,
            subject
    ) y
GROUP BY
    roll_number,
    student_name,
    class,
    section,
    school_name;