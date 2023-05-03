
Create table If Not Exists Delivery1174 (delivery_id int, customer_id int, order_date date, customer_pref_delivery_date date);
Truncate table Delivery1174 ;
insert into Delivery1174 (delivery_id, customer_id, order_date, customer_pref_delivery_date) values ('1', '1', '2019-08-01', '2019-08-02');
insert into Delivery1174 (delivery_id, customer_id, order_date, customer_pref_delivery_date) values ('2', '2', '2019-08-02', '2019-08-02');
insert into Delivery1174 (delivery_id, customer_id, order_date, customer_pref_delivery_date) values ('3', '1', '2019-08-11', '2019-08-12');
insert into Delivery1174 (delivery_id, customer_id, order_date, customer_pref_delivery_date) values ('4', '3', '2019-08-24', '2019-08-24');
insert into Delivery1174 (delivery_id, customer_id, order_date, customer_pref_delivery_date) values ('5', '3', '2019-08-21', '2019-08-22');
insert into Delivery1174 (delivery_id, customer_id, order_date, customer_pref_delivery_date) values ('6', '2', '2019-08-11', '2019-08-13');
insert into Delivery1174 (delivery_id, customer_id, order_date, customer_pref_delivery_date) values ('7', '4', '2019-08-09', '2019-08-09');


with cte as 
(select *,ROW_NUMBER() over (PARTITION BY customer_id ORDER BY order_date) as rn,
case when order_date=customer_pref_delivery_date then 'immidiate'
else 'scheduled'
end as tag from delivery1174)
select 
round(count(case when tag='immidiate' then 1 end)*100/count(*),2) as immediate_percentage from 
cte where rn=1

