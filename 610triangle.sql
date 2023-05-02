-- Active: 1682038109540@@mysql12--2.mysql.database.azure.com@3306@leetcode
Create table If Not Exists Triangle (x int, y int, z int)
Truncate table Triangle
insert into Triangle (x, y, z) values ('13', '15', '30')
insert into Triangle (x, y, z) values ('10', '20', '15');


select *,
CASE WHEN x+y>z AND
y+z>x AND
x+z>y then 'YES'
ELSE 'No' 
END AS triangle
from triangle;