CREATE TABLE students (
    ID int,
    Name varchar(64),
    Gender varchar(64)
);

INSERT INTO
    students (ID, Name, Gender)
VALUES
    (3, 'Kim', 'F'),
    (4, 'Molina', 'F'),
    (5, 'Dev', 'M');

SELECT
    *
FROM
    students;

SELECT
    CASE
        WHEN count(*) >= 2 THEN max(salary)
        ELSE NULL
    END AS SecondHighestSalray
FROM
    employee
WHERE
    salary <(
        SELECT
            max(salary)
        FROM
            employee
    )