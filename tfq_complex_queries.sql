-- Active: 1682038109540@@mysql12--2.mysql.database.azure.com@3306@leetcode
-- 1. WRITE a SQL Query TO FETCH ALL the DUPLICATE records IN a TABLE.
WITH cte AS (
    SELECT
        user_name,
        COUNT(user_id) AS ct
    FROM
        users
    GROUP BY
        user_name
    HAVING
        ct > 1
)
SELECT
    *
FROM
    users
WHERE
    user_name IN (
        SELECT
            user_name
        FROM
            cte
    );

--2. WRITE a SQL query TO FETCH the SECOND last record
FROM
    employee TABLE.WITH cte AS (
        SELECT
            `emp_ID`,
            ROW_NUMBER() over(
                ORDER BY
                    `emp_ID` DESC
            ) AS rn
        FROM
            emp_tfq2
    )
SELECT
    *
FROM
    emp_tfq2
WHERE
    `emp_ID` IN (
        SELECT
            `emp_ID`
        FROM
            cte
        WHERE
            rn = 2
    );

-- 3.WRITE a SQL query TO display ONLY the details of employees who either earn the highest salary OR the lowest salary IN each department
FROM
    the employee TABLE.WITH cte AS (
        SELECT
            *,
            MAX(salary) over(PARTITION BY `DEPT_NAME`) AS max,
            MIN(`SALARY`) over(PARTITION BY `DEPT_NAME`) AS min
        FROM
            emp_tfq2
    )
SELECT
    *
FROM
    cte
WHERE
    `SALARY` = max
    OR `SALARY` = min;

-- 4.FROM the doctors TABLE, FETCH the details of doctors who WORK IN the same hospital but IN different specialty.
SELECT
    d1.*
FROM
    doctors d1
    JOIN doctors d2 ON d1.hospital = d2.hospital
WHERE
    d1.speciality != d2.speciality;

-- sub question - get docs.
WITH any sepciality
FROM
    same hospital
SELECT
    d1.name,
    d1.speciality,
    d1.hospital
FROM
    doctors d1
    JOIN doctors d2 ON d1.hospital = d2.hospital
WHERE
    d1.name != d2.name;

-- 5.
-- FROM
--     the login_details TABLE,
--     FETCH the users who logged IN consecutively 3
--     OR more times.
SELECT
    DISTINCT l1.user_name
FROM
    login_details l1
    JOIN login_details l2 ON l1.login_id = l2.login_id - 1
    JOIN login_details l3 ON l1.login_id = l3.login_id + 1
WHERE
    l1.user_name = l2.user_name
    AND l1.user_name = l3.user_name;

SELECT
    DISTINCT repeated_names
FROM
    (
        SELECT
            *,
            CASE
                WHEN user_name = lead(user_name) over(
                    ORDER BY
                        login_id
                )
                AND user_name = lead(user_name, 2) over(
                    ORDER BY
                        login_id
                ) THEN user_name
                ELSE NULL
            END AS repeated_names
        FROM
            login_details
    ) x
WHERE
    x.repeated_names IS NOT NULL;

-- 6.
-- FROM
--     the students TABLE,
--     WRITE a SQL query TO interchange the adjacent student NAMES.
CREATE TABLE studnts_tfq_sql6 (
    id int PRIMARY KEY,
    student_name varchar(50) NOT NULL
);

INSERT INTO
    studnts_tfq_sql6
VALUES
    (1, 'James'),
    (2, 'Michael'),
    (3, 'George'),
    (4, 'Stewart'),
    (5, 'Robin');

SELECT
    id,
    CASE
        WHEN id % 2 != 0 THEN lead(student_name, 1, student_name) over(
            ORDER BY
                id
        )
        ELSE lag(student_name) over(
            ORDER BY
                id
        )
    END AS new_student_name
FROM
    studnts_tfq_sql6;

-- 7.FROM the weather TABLE, FETCH ALL the records WHEN London had extremely cold temperature FOR 3 consecutive days OR more.
WITH cte AS (
    SELECT
        *,
        IF(
            (
                id + 1 = lead(id, 1) over(
                    ORDER BY
                        id
                )
                AND id + 2 = lead(id, 2) over(
                    ORDER BY
                        id
                )
            )
            OR (
                id -1 = lag(id, 1) over(
                    ORDER BY
                        id
                )
                AND id + 1 = lead(id, 1) over(
                    ORDER BY
                        id
                )
            )
            OR (
                id -1 = lag(id, 1) over(
                    ORDER BY
                        id
                )
                AND id -2 = lag(id, 2) over(
                    ORDER BY
                        id
                )
            ),
            'Yes',
            'No'
        ) AS filt
    FROM
        weather
    WHERE
        temperature < 0
)
SELECT
    id,
    city,
    temperature,
    DAY
FROM
    cte
WHERE
    filt = 'Yes';

-- 8. FROM the following 3 tables ( event_category, physician_speciality, patient_treatment ), write a SQL query to get the histogram of specialties of the unique physicians who have done the procedures but never did prescribe anything.
SELECT
    *
FROM
    event_category;

SELECT
    *
FROM
    physician_speciality;

SELECT
    *
FROM
    patient_treatment;

WITH presc AS (
    SELECT
        e.physician_id
    FROM
        patient_treatment e
        JOIN physician_speciality p ON e.physician_id = p.physician_id
        JOIN event_category ec ON e.event_name = ec.event_name
    WHERE
        category = 'Prescription'
),
proc AS (
    SELECT
        e.physician_id
    FROM
        patient_treatment e
        JOIN physician_speciality p ON e.physician_id = p.physician_id
        JOIN event_category ec ON e.event_name = ec.event_name
    WHERE
        category = 'Procedure'
),
subq AS (
    SELECT
        *
    FROM
        proc
    WHERE
        physician_id NOT IN (
            SELECT
                *
            FROM
                presc
        )
)
SELECT
    speciality,
    count(ps.physician_id) AS speciality_count
FROM
    subq
    JOIN physician_speciality ps ON ps.physician_id = subq.physician_id
GROUP BY
    speciality;

-- 9.Find the top 2 accounts WITH the maximum number of UNIQUE patients ON a monthly basis.
WITH cte AS (
    SELECT
        MONTHNAME(date) AS MONTH,
        account_id,
        count(DISTINCT patient_id) AS no_of_unique_patients
    FROM
        patient_logs
    GROUP BY
        MONTH,
        account_id
),
xte AS (
    SELECT
        *,
        DENSE_RANK() over (
            PARTITION by MONTH
            ORDER BY
                no_of_unique_patients DESC
        ) AS rn
    FROM
        cte
)
SELECT
    MONTH,
    account_id,
    no_of_unique_patients
FROM
    xte
WHERE
    rn = 1;
    SELECT * from patient_logs;

    