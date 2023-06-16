create table batch (batch_id varchar(10), quantity integer);

drop table if exists orders;

create table orders (order_number varchar(10), quantity integer);

insert into batch values ('B1', 5);

insert into batch values ('B2', 12);

insert into batch values ('B3', 8);

insert into orders values ('O1', 2);

insert into orders values ('O2', 8);

insert into orders values ('O3', 2);

insert into orders values ('O4', 5);

insert into orders values ('O5', 9);

insert into orders values ('O6', 5);

select * from orders;

with RECURSIVE batch_split as (
        select
            batch_id,
            1 as quantity
        from batch
        union all
        select
            b2.batch_id,
            b1.quantity + 1 as quantity
        from batch_split b1
            join batch b2 on b1.batch_id = b2.batch_id and b2.quantity > b1.quantity
    ), order_split as (
        select
            order_number,
            1 as quantity
        from orders
        union all
        SELECT
            o2.order_number,
            o1.quantity + 1 as quantity
        FROM order_split o1
            join orders o2 on o1.order_number = o2.order_number and o2.quantity > o1.quantity
    )
select
    order_number,
    batch_id,
    sum(1)
from (
        SELECT
            *,
            ROW_NUMBER() over (
                order by
                    batch_id
            ) as rn
        from (
                select
                    *,
                    1 as ct
                from
                    batch_split
                order by
                    1,
                    2
            ) x
        order by rn
    ) bth
    right join (
        SELECT
            *,
            ROW_NUMBER() over (
                order by
                    order_number
            ) o_rn
        from (
                select *
                from
                    order_split
                order by
                    1,
                    2
            ) y
        order by
            o_rn
    ) odrs on bth.rn = odrs.o_rn
GROUP BY
    order_number,
    batch_id;