with cte as (select *,
row_number() over(
    partition by company order by salary) as rn,
count(*) over(
    PARTITION BY company
) as ct
from employee)
select emp_id,company,salary from cte
where rn=ceil((ct/2)+1)
