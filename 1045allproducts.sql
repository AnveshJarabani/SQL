-- Active: 1682038109540@@mysql12--2.mysql.database.azure.com@3306@leetcode

Create table If Not Exists Customer (customer_id int, product_key int)
Create table Product (product_key int)
Truncate table Customer
insert into Customer (customer_id, product_key) values ('1', '5')
insert into Customer (customer_id, product_key) values ('2', '6')
insert into Customer (customer_id, product_key) values ('3', '5')
insert into Customer (customer_id, product_key) values ('3', '6')
insert into Customer (customer_id, product_key) values ('1', '6')
Truncate table Product
insert into Product (product_key) values ('5')
insert into Product (product_key) values ('6')
;

select customer_id from 
(select c.* from customer c
inner join product p on 
c.product_key=p.product_key) x
GROUP BY customer_id
having count(distinct product_key) = (select COUNT(DISTINCT product_key) pk from product);