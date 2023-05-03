
Create table If Not Exists Products1164 (product_id int, new_price int, change_date date);
Truncate table Products1164;
insert into Products1164 (product_id, new_price, change_date) values ('1', '20', '2019-08-14');
insert into Products1164 (product_id, new_price, change_date) values ('2', '50', '2019-08-14');
insert into Products1164 (product_id, new_price, change_date) values ('1', '30', '2019-08-15');
insert into Products1164 (product_id, new_price, change_date) values ('1', '35', '2019-08-16');
insert into Products1164 (product_id, new_price, change_date) values ('2', '65', '2019-08-17');
insert into Products1164 (product_id, new_price, change_date) values ('3', '20', '2019-08-18');

with cte as 
(select product_id,new_price,change_date,
datediff('2019-08-16',change_date) as delta from products1164
where datediff('2019-08-16',change_date)>=0)
-- select product_id,new_price as price from
select distinct p.product_id as product_id,
case when price is null then 10
else price
end as price

from products1164 p
left join 
(select cte.product_id, cte.new_price as price from 
(select product_id,min(delta) as min from cte
group by product_id) y
left join cte on y.min=cte.delta and y.product_id=cte.product_id) z
on p.product_id=z.product_id
