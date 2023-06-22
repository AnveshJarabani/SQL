-- Active: 1682009795450@@mysql12--2.mysql.database.azure.com@3306@leetcode
CREATE TABLE tfq_billing (
    customer_id int,
    customer_name varchar(1),
    billing_id varchar(5),
    billing_creation_date date,
    billed_amount int
);

INSERT INTO
    tfq_billing
VALUES
    (
        1,
        'A',
        'id1',
        str_to_date('10-10-2020', '%d-%m-%Y'),
        100
    ),
    (
        1,
        'A',
        'id2',
        str_to_date('11-11-2020', '%d-%m-%Y'),
        150
    ),
    (
        1,
        'A',
        'id3',
        str_to_date('12-11-2021', '%d-%m-%Y'),
        100
    ),
    (
        2,
        'B',
        'id4',
        str_to_date('10-11-2019', '%d-%m-%Y'),
        150
    ),
    (
        2,
        'B',
        'id5',
        str_to_date('11-11-2020', '%d-%m-%Y'),
        200
    ),
    (
        2,
        'B',
        'id6',
        str_to_date('12-11-2021', '%d-%m-%Y'),
        250
    ),
    (
        3,
        'C',
        'id7',
        str_to_date('01-01-2018', '%d-%m-%Y'),
        100
    ),
    (
        3,
        'C',
        'id8',
        str_to_date('05-01-2019', '%d-%m-%Y'),
        250
    ),
    (
        3,
        'C',
        'id9',
        str_to_date('06-01-2021', '%d-%m-%Y'),
        300
    );

select * from tfq_billing;
    select customer_id,customer_name,sum(billed_amount) as sm,3-count(distinct YEAR(billing_creation_date)) as test,count(*) from tfq_billing
    GROUP BY 1,2;