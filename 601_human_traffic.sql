-- Active: 1682009795450@@mysql12--2.mysql.database.azure.com@3306@leetcode


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

select *,
-- case WHEN lead(id) OVER (PARTITION BY NULL)=id+1 THEN 'Y' 
CASE WHEN lag(id) over (PARTITION BY NULL)=id-1 THEN 'Y'
WHEN lead(id) OVER (PARTITION BY NULL)=id+1 THEN 'Y' 
ELSE 'N'
end as filt
from Stadium
where people>=100
ORDER BY visit_date;