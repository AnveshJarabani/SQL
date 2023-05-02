-- Active: 1682038109540@@mysql12--2.mysql.database.azure.com@3306@leetcode

Create table If Not Exists Sales (sale_id int, product_id int, year int, quantity int, price int);
Create table If Not Exists Product (product_id int, product_name varchar(10));
Truncate table Sales;
insert into Sales (sale_id, product_id, year, quantity, price) values ('1', '100', '2008', '10', '5000');
insert into Sales (sale_id, product_id, year, quantity, price) values ('2', '100', '2009', '12', '5000');
insert into Sales (sale_id, product_id, year, quantity, price) values ('7', '200', '2011', '15', '9000');
Truncate table Product;
insert into Product (product_id, product_name) values ('100', 'Nokia');
insert into Product (product_id, product_name) values ('200', 'Apple');
insert into Product (product_id, product_name) values ('300', 'Samsung');



select s.product_id,x.year as first_year,s.quantity,s.price from sales s
left join 
(select product_id,year,
ROW_NUMBER() OVER(PARTITION BY product_id order by year) as filt
from sales) x on
x.product_id=s.product_id and x.year=s.year
where filt=1;

select product_id,first_year,quantity,price from
(select product_id,
min(year) over(partition by product_id) as first_year,
ROW_NUMBER() OVER(PARTITION BY product_id) as rn,
quantity,price from sales
order by sale_id) x
where rn<2;
