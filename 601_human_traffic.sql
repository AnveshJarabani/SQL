-- Active: 1682038109540@@mysql12--2.mysql.database.azure.com@3306@leetcode


Create table If Not Exists Stadium (id int, visit_date DATE NULL, people int);
Truncate table Stadium;
insert into Stadium (id, visit_date, people) values 
('1', '2017-01-01', '10'),
('2', '2017-01-02', '109'),
('3', '2017-01-03', '150'),
('4', '2017-01-04', '99'),
('5', '2017-01-05', '145'),
('6', '2017-01-06', '1455'),
('7', '2017-01-07', '199'),
('8', '2017-01-09', '188');


select id,visit_date,people from 
(select *,
-- case WHEN lead(id) OVER (PARTITION BY NULL)=id+1 THEN 'Y' 
CASE WHEN lead(id) over (ORDER BY visit_date)=id+1 and lead(id,2) OVER (ORDER BY visit_date)=id+2 THEN 'Y'
WHEN lead(id) OVER (ORDER BY visit_date)=id+1 AND lag(id) over (ORDER BY visit_date) = id-1 THEN 'Y' 
WHEN lag(id,2) OVER (ORDER BY visit_date)=id-2 AND lag(id) over (ORDER BY visit_date) = id-1 THEN 'Y' 
WHEN lead(id) OVER (ORDER BY visit_date) is NULL AND lag(id) over (ORDER BY visit_date) = id-1 AND lag(id,2) over (ORDER BY visit_date)=id-2 THEN 'Y' 
ELSE 'N'
end as filt
from Stadium
where people>=100) x 
where filt like "Y";