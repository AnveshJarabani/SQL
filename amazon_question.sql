-- Active: 1688765630308@@localhost@5432@leetcode
CREATE TABLE employees (emp_id INTEGER, department VARCHAR, t_date date);

TRUNCATE TABLE EMPLOYEES;

INSERT INTO
    employees (emp_id, department, t_date)
VALUES
    (1, 'HR', '1/1/2023'),
    (2, 'BR', '1/1/2023'),
    (3, 'HR', '1/1/2023'),
    (1, 'HR', '2/2/2023'),
    (2, 'HR', '2/2/2023'),
    (2, 'BR', '2/2/2023'),
    (1, 'BR', '2/3/2023'),
    (4, 'HR', '1/3/2023');

WITH cte AS (
    SELECT
        EMP_ID,
        DEPARTMENT,
        t_date,
        row_number() over(
            PARTITION by emp_id
            ORDER BY
                t_date
        ) AS rn
    FROM
        EMPLOYEES
    WHERE
        t_date <= '2/28/2023'
)

SELECT * FROM CTE
;

