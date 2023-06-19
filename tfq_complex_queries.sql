-- Active: 1682038109540@@mysql12--2.mysql.database.azure.com@3306@leetcode
-- 1. WRITE a SQL Query TO FETCH ALL the DUPLICATE records IN a TABLE.
WITH cte AS (
    SELECT
        user_name,
        count(user_id) AS ct
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

--2. WRITE a SQL query TO FETCH the SECOND last record FROM employee TABLE.
WITH cte AS (
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

-- 3.WRITE a SQL query TO display ONLY the details of employees who either earn the highest salary OR the lowest salary IN each department FROM the employee TABLE.
WITH cte AS (
    SELECT
        *,
        max(salary) over(PARTITION BY `DEPT_NAME`) AS max,
        min(`SALARY`) over(PARTITION BY `DEPT_NAME`) AS min
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

-- 4.FROM the doctors TABLE,FETCH the details of doctors who WORK IN the same hospital but IN different specialty.
SELECT
    d1.*
FROM
    doctors d1
    JOIN doctors d2 ON d1.hospital = d2.hospital
WHERE
    d1.speciality != d2.speciality;

--  sub question - get docs. with any sepciality from same hospital
SELECT
    d1.name,
    d1.speciality,
    d1.hospital
FROM
    doctors d1
    JOIN doctors d2 ON d1.hospital = d2.hospital
WHERE
    d1.name != d2.name;

-- 5. FROM the login_details TABLE,FETCH the users who logged IN consecutively 3 OR more times.
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

--