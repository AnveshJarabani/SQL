s-- Active: 1682009795450@@mysql12--2.mysql.database.azure.com@3306@leetcode
Create table If Not Exists Customer1321 (customer_id int, name varchar(20), visited_on date, amount int);
Truncate table Customer1321;
insert into Customer1321 (customer_id, name, visited_on, amount) values ('1', 'Jhon', '2019-01-01', '100');
insert into Customer1321 (customer_id, name, visited_on, amount) values ('2', 'Daniel', '2019-01-02', '110');
insert into Customer1321 (customer_id, name, visited_on, amount) values ('3', 'Jade', '2019-01-03', '120');
insert into Customer1321 (customer_id, name, visited_on, amount) values ('4', 'Khaled', '2019-01-04', '130');
insert into Customer1321 (customer_id, name, visited_on, amount) values ('5', 'Winston', '2019-01-05', '110');
insert into Customer1321 (customer_id, name, visited_on, amount) values ('6', 'Elvis', '2019-01-06', '140');
insert into Customer1321 (customer_id, name, visited_on, amount) values ('7', 'Anna', '2019-01-07', '150');
insert into Customer1321 (customer_id, name, visited_on, amount) values ('8', 'Maria', '2019-01-08', '80');
insert into Customer1321 (customer_id, name, visited_on, amount) values ('9', 'Jaze', '2019-01-09', '110');
insert into Customer1321 (customer_id, name, visited_on, amount) values ('1', 'Jhon', '2019-01-10', '130');
insert into Customer1321 (customer_id, name, visited_on, amount) values ('3', 'Jade', '2019-01-10', '150');

select visited_on,
sum(amount) over 
(order by visited_on, visited_on rows between 6 preceding and current row) as amount
 from customer1321
 limit 9999999 offset 6;

 SELECT * FROM customer1321;