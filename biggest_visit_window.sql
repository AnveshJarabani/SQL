with cte  as (SELECT
    user_id,
        (
            lead(visit_date, 1, '2021-1-1') over (
                PARTITION by user_id
                ORDER BY
                    user_id,
                    visit_date
            ) - visit_date
        )
     AS biggest_window
FROM
    uservisits
ORDER BY
    user_id)
select user_id,max(biggest_window) AS biggest_window
from cte
group by user_id
order by user_id;

SELECT
    *
FROM
    uservisits orr;