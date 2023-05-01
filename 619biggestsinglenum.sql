-- Active: 1682038109540@@mysql12--2.mysql.database.azure.com@3306@leetcode
Create table If Not Exists MyNumbers (num int);
Truncate table MyNumbers;
insert into MyNumbers (num) values ('8');
insert into MyNumbers (num) values ('8');
insert into MyNumbers (num) values ('3');
insert into MyNumbers (num) values ('3');
insert into MyNumbers (num) values ('1');
insert into MyNumbers (num) values ('4');
insert into MyNumbers (num) values ('5');
insert into MyNumbers (num) values ('6');

select max(num) as num from
(select num,count(num) as ct from mynumbers
GROUP BY num having count(*)=1) x;