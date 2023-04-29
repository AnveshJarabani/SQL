-- Active: 1682038109540@@mysql12--2.mysql.database.azure.com@3306@leetcode

Create Table If Not Exists Insurance (pid int, tiv_2015 float, tiv_2016 float, lat float, lon float)
Truncate table Insurance
insert into Insurance (pid, tiv_2015, tiv_2016, lat, lon) values ('1', '10', '5', '10', '10')
insert into Insurance (pid, tiv_2015, tiv_2016, lat, lon) values ('2', '20', '20', '20', '20')
insert into Insurance (pid, tiv_2015, tiv_2016, lat, lon) values ('3', '10', '30', '20', '20')
insert into Insurance (pid, tiv_2015, tiv_2016, lat, lon) values ('4', '10', '40', '40', '40');



select sum(tiv_2016) as tiv_2016 from insurance 
where tiv_2015 in 
(select tiv_2015 from insurance GROUP BY tiv_2015 having count(tiv_2015)>1)
and concat(lat,lon) not in
(select CONCAT(lat,lon) from insurance GROUP BY lat,lon having count(concat(lat,lon))>1);