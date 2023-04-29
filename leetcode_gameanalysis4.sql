-- Active: 1682009795450@@mysql12--2.mysql.database.azure.com@3306@leetcode
with cte as 
(select * from 
(select *,
row_number() over (partition by player_id order by event_date) as rn,
case when lead(event_date) OVER(PARTITION BY player_id)=DATE_ADD(event_date,INTERVAL 1 DAY)
then 'YAY'
else "NAY"
end as FILT
from activity) x
where rn<3)
SELECT ROUND(COUNT(distinct (select distinct player_id from cte 
where FILT LIKE 'YAY'))/COUNT(DISTINCT player_id),2) AS fraction
FROM cte;

WITH CTE AS (
    SELECT COUNT(DISTINCT player_id) AS yay
    FROM (
        SELECT *,
            CASE
                WHEN LEAD(event_date) OVER (PARTITION BY player_id ORDER BY event_date) = DATE_ADD(event_date, INTERVAL 1 DAY) THEN 'YES'
                ELSE 'NO'
            END AS FLAG
        FROM activity
    ) AS x1 
    WHERE flag LIKE 'YES'
)
SELECT ROUND((select yay from cte) / COUNT(DISTINCT player_id),2) AS fraction
FROM activity;






