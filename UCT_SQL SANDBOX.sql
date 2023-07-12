-- Active: 1688765630308@@localhost@5432@uct_data

select pg_size_pretty(pg_total_relation_size('"shp"')) as total_size ;

SELECT
    count(*)
FROM
    "lbr m-18";

SELECT
    "Start Date",
    date_trunc('month', "Start Date" :: Date) + INTERVAL '1 month' - INTERVAL '1 day'
FROM
    "lbr m-18";

SELECT
    `Order - Material (key)`,
    sum(`Operation Quantity`)
FROM
    (
        SELECT
            DISTINCT `Order - Material (Key)`,
            `Order`,
            `Operation Quantity`
        FROM
            `lbr m-18`
        WHERE
            `Fiscal year/period` LIKE '%2022'
    ) x
WHERE
    `Order - Material (key)` IN (
        'UC-66-73960-00',
        'UC-66-72032-00',
        'UC-66-68025-00'
    )
GROUP BY
    `Order - Material (key)`;

SELECT
    'Order - Material (Key)',
    STR_TO_DATE(`Start Date`, '%m/%d/%y') AS `Date`
FROM
    `lbr m-18`
ORDER BY
    `Date` DESC;

USE leetcode;

DROP TABLE login_details;

CREATE TABLE login_details(
    login_id int PRIMARY KEY,
    user_name varchar(50) NOT NULL,
    login_date date
);

SELECT
    sub_q.*
FROM
    (
        SELECT
            DATE_FORMAT(date, '%M') AS MONTH,
            account_id,
            COUNT(DISTINCT patient_id) AS no_of_unique_patients,
            ROW_NUMBER() over (
                PARTITION BY MONTH
                ORDER BY
                    no_of_unique_patients DESC
            ) AS rn
        FROM
            patient_logs
        GROUP BY
            MONTH,
            account_id
        ORDER BY
            account_id ASC,
            no_of_unique_patients DESC
    ) sub_q
WHERE
    sub_q.rn < 3;

SELECT
    sub_q.*
FROM
    employee
    JOIN (
        SELECT
            *,
            MAX(`SALARY`) OVER (PARTITION BY `DEPT_NAME`) AS max_salary,
            MIN(`SALARY`) OVER (PARTITION BY `DEPT_NAME`) AS min_salary
        FROM
            employee
    ) sub_q ON employee.`emp_ID` = sub_q.`emp_ID`
WHERE
    employee.`SALARY` != sub_q.max_salary
    OR employee.`SALARY` != sub_q.min_salary;

UPDATE
    users email
SET
    email = CONCAT(user_name, '@email.com');

t.request_at AS DAY,
t.status;

SELECT
    user_id,
    user_name,
    email
FROM
    (
        SELECT
            *,
            ROW_NUMBER() OVER (PARTITION BY user_name) AS rn
        FROM
            users
    ) x
WHERE
    x.rn > 1;

SELECT
    t.request_at AS DAY,
    round(
        sum(IF(t.status != 'completed', 1, 0)) / count(t.status),
        2
    ) AS `Cancellation Rate`
FROM
    Trips t
WHERE
    t.request_at BETWEEN '2013-10-01'
    AND '2013-10-03'
    AND t.client_id NOT IN (
        SELECT
            users_id
        FROM
            users
        WHERE
            banned NOT LIKE 'No'
    )
    AND t.driver_id NOT IN (
        SELECT
            users_id
        FROM
            users
        WHERE
            banned NOT LIKE 'No'
    )
GROUP BY
    t.request_at;

(
    SELECT
        t.*
    FROM
        trips t
        JOIN (
            SELECT
                u.users_id
            FROM
                users u
            WHERE
                u.banned NOT LIKE 'Yes'
        ) sub_q ON t.client_id = sub_q.users_id
);

SELECT
    d.name AS Department,
    sub_q.employee1,
    sub_q.salary
FROM
    department d
    JOIN (
        SELECT
            mx.salary,
            e.name AS employee1,
            e.`departmentId`
        FROM
            employee1 e
            JOIN (
                SELECT
                    e.`departmentId` AS department,
                    (
                        ORDER BY
                            e.salary
                        LIMIT
                            3
                    ) AS Salary
                FROM
                    employee1 e
                GROUP BY
                    e.`departmentId`
            ) mx ON mx.`salary` = e.`salary`
            AND
    ) sub_q ON d.id = sub_q.`departmentid`;

SELECT
    d.`name` AS Department,
    sub_q.`Employee`,
    sub_q.salary
FROM
    department d
    JOIN (
        WITH ranked_salaries AS (
            SELECT
                e.`departmentId`,
                DENSE_RANK() over (
                    PARTITION BY `departmentId`
                    ORDER BY
                        e.salary DESC
                ) AS rk,
                e.name,
                e.salary,
                e.id
            FROM
                employee e
        )
        SELECT
            `departmentId` AS Department,
            name AS employee,
            salary
        FROM
            ranked_salaries
        WHERE
            rk < 4
        ORDER BY
            Department
    ) sub_q ON sub_q.department = d.id;

SELECT
    e.`departmentId` AS department,
    DENSE_RANK() over (
        PARTITION BY `departmentId`
        ORDER BY
            e.salary
    ) AS rk,
    e.name,
    e.salary,
    e.id
FROM
    employee e;

SELECT
    DISTINCT `Standard Text Key`,
    `Work Center`
FROM
    `lbr m-18`;

SELECT
    DISTINCT `Operation Text`,
    `Standard Text Key`,
    `Order - Material (Key)`
FROM
    `lbr m-18`
WHERE
    `Operation Text` LIKE '%bend%';

USE uct_data;