-- Active: 1682038109540@@mysql12--2.mysql.database.azure.com@3306@leetcode

Create table If Not Exists Seat (id int, student varchar(255));
Truncate table Seat;
insert into Seat (id, student) values ('1', 'Abbot');
insert into Seat (id, student) values ('2', 'Doris');
insert into Seat (id, student) values ('3', 'Emerson');
insert into Seat (id, student) values ('4', 'Green');
insert into Seat (id, student) values ('5', 'Jeames');

select 
CASE 
    WHEN  id_temp is NULL THEN  id
    ELSE id_temp
END AS id,
CASE WHEN st_temp is NULL THEN student
ELSE st_temp
end as student from
(select * from seat s
left join
(select
CASE WHEN id % 2 =0 THEN id-1
WHEN id % 2 !=0 THEN id+1 
END AS id_temp,student as st_temp
from seat) x on 
s.id=x.id_temp) y
