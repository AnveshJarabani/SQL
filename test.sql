-- orders table order_id,order_date,amount 


delete from orders
where order_id in 
(select *,row_number() over(partition by order_id) as rn from orders
where rn>1)

with cte as 
(select extract(month from order_date) - interval "1 day" as order_month,
sum(amount) as Total_amount from orders
group by order_month)
select *,
sum(amount) over (partition by order_month rows between unbounded preceding and current_row) as running_total,
lag(total_amount,1,0) over (order by order_month) as Previous_month_total from cte;




str="aabbbacc"
lst=[i for i in str]
uniques=list(set(lst))
result_list=[[i,lst.count(i)] for i in uniques] #[[a,3],[b,3],[c,2]]
result=""
for i in result_list:
     result+=str(i[0])+str(i[1])
