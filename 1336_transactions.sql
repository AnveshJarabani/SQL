create table Visits1336 (user_id int,visit_date date);
insert into visits1336 (user_id,visit_date)
values(1       ,'2020-01-01'),
(2       ,'2020-01-02'),
(12      ,'2020-01-01'),
(19      ,'2020-01-03'),
(1       ,'2020-01-02'),
(2       ,'2020-01-03'),
(1       ,'2020-01-04'),
(7       ,'2020-01-11'),
(9       ,'2020-01-25'),
(8       ,'2020-01-28');

create table Transactions1336 (user_id int,transaction_date date,amout int);

insert into transactions1336 (user_id,transaction_date,amount)
values(1       ,'2020-01-02',       120),
(2       ,'2020-01-03',       22 ),
(7       ,'2020-01-11',       232),
(1       ,'2020-01-04',       7  ),
(9       ,'2020-01-25',       33 ),
(9       ,'2020-01-25',       66 ),
(8       ,'2020-01-28',       1  ),
(9       ,'2020-01-25',       99 );
-- +---------+------------------+--------+
-- Result table:
-- +--------------------+--------------+
-- | transactions_count | visits_count |
-- +--------------------+--------------+
-- | 0                  | 4            |
-- | 1                  | 5            |
-- | 2                  | 0            |
-- | 3                  | 1            |
-- +--------------------+--------------+
-- * For transactions_count = 0, The visits (1, "2020-01-01"), (2, "2020-01-02"), (12, "2020-01-01") and (19, "2020-01-03") did no transactions so visits_count = 4.
-- * For transactions_count = 1, The visits (2, "2020-01-03"), (7, "2020-01-11"), (8, "2020-01-28"), (1, "2020-01-02") and (1, "2020-01-04") did one transaction so visits_count = 5.
-- * For transactions_count = 2, No customers visited the bank and did two transactions so visits_count = 0.
-- * For transactions_count = 3, The visit (9, "2020-01-25") did three transactions so visits_count = 1.
-- * For transactions_count >= 4, No customers visited the bank and did more than three transactions so we will stop at transactions_count = 3

select * from transactions1336;
select * from  visits1336 v
left join transactions1336 t ON
v.user_id=t.user_id and v.visit_date=t.transaction_date;

















WITH RECURSIVE t1 AS(
                    SELECT visit_date,
                           COALESCE(num_visits,0) as num_visits,
                           COALESCE(num_trans,0) as num_trans
                    FROM ((
                          SELECT visit_date, user_id, COUNT(*) as num_visits
                          FROM visits
                          GROUP BY 1, 2) AS a
                         LEFT JOIN
                          (
                           SELECT transaction_date,
                                 user_id,
                                 count(*) as num_trans
                            FROM transactions
                          GROUP BY 1, 2) AS b
                         ON a.visit_date = b.transaction_date and a.user_id = b.user_id)
                      ),

              t2 AS (
                      SELECT MAX(num_trans) as trans
                        FROM t1
                      UNION ALL
                      SELECT trans-1
                        FROM t2
                      WHERE trans >= 1)

SELECT trans as transactions_count,
       COALESCE(visits_count,0) as visits_count
  FROM t2 LEFT JOIN (
                    SELECT num_trans as transactions_count, COALESCE(COUNT(*),0) as visits_count
                    FROM t1
                    GROUP BY 1
                    ORDER BY 1) AS a
ON a.transactions_count = t2.trans
ORDER BY 1