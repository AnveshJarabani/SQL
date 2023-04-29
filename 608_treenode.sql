-- Active: 1682038109540@@mysql12--2.mysql.database.azure.com@3306@leetcode
Create table If Not Exists Tree (id int, p_id int)
Truncate table Tree
insert into Tree (id, p_id) values ('1', NULL)
insert into Tree (id, p_id) values ('2', '1')
insert into Tree (id, p_id) values ('3', '1')
insert into Tree (id, p_id) values ('4', '2')
insert into Tree (id, p_id) values ('5', '2');

select id,
CASE 
    WHEN p_id is null THEN 'Root' 
    WHEN id in (select p_id from Tree) THEN 'Inner'
    Else 'Leaf'  
END as type
from Tree;