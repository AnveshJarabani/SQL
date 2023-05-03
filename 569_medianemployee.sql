
create table employee569 (id int,company VARCHAR(255),salary int);
insert INTO employee569 (id,company,salary)
VALUES


(1    ,'A'          ,2341   ),
(2    ,'A'          ,341    ),
(3    ,'A'          ,15     ),
(4    ,'A'          ,15314  ),
(5    ,'A'          ,451    ),
(6    ,'A'          ,513    ),
(7    ,'B'          ,15     ),
(8    ,'B'          ,13     ),
(9    ,'B'          ,1154   ),
(10   ,'B'          ,1345   ),
(11   ,'B'          ,1221   ),
(12   ,'B'          ,234    ),
(13   ,'C'          ,2345   ),
(14   ,'C'          ,2645   ),
(15   ,'C'          ,2645   ),
(16   ,'C'          ,2652   ),
(17   ,'C'          ,65     );


with cte as 
    (select *,
    max(rn) over (PARTITION BY company) as mx from (select *,
    row_number() over (PARTITION BY company ORDER BY salary) as rn
    from employee569) x)
select id,company,salary
from cte
where if(mx%2=0,rn=mx/2 or rn=((mx/2)+1),rn=round((mx+1)/2,0));













SELECT t1.Id AS Id, t1.Company, t1.Salary
FROM Employee569 AS t1 JOIN Employee569 AS t2
ON t1.Company = t2.Company
GROUP BY t1.Id
HAVING abs(sum(CASE WHEN t2.Salary<t1.Salary THEN 1
                  WHEN t2.Salary>t1.Salary THEN -1
                  WHEN t2.Salary=t1.Salary AND t2.Id<t1.Id THEN 1
                  WHEN t2.Salary=t1.Salary AND t2.Id>t1.Id THEN -1
                  ELSE 0 END)) <= 1
ORDER BY t1.Company, t1.Salary, t1.Id;