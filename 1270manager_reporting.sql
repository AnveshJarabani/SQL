-- Active: 1688765630308@@localhost@5432@leetcode@public
CREATE TABLE employees (
    employee_id int,
    employee_name varchar,
    manager_id int
);

INSERT INTO
    employees (employee_id, employee_name, manager_id)
VALUES
    (1, 'Boss', 1),
    (3, 'Alice', 3),
    (2, 'Bob', 1),
    (4, 'Daniel', 2),
    (7, 'Luis', 4),
    (8, 'Jhon', 3),
    (9, 'Angela', 8),
    (77, 'Robert', 1);

WITH RECURSIVE emp_hierarcy AS (
    SELECT
        employee_id
    FROM
        employees
    WHERE
        employee_id = 1
    UNION
    ALL
    SELECT
        e.employee_id
    FROM
        employees e
        INNER JOIN emp_hierarcy eh ON e.manager_id = eh.employee_id
    WHERE
        e.manager_id != e.employee_id
)
SELECT
    *
FROM
    emp_hierarcy
WHERE
    employee_id != 1