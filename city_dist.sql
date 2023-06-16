drop table if EXISTS src_dest_distance;

create table
    src_dest_distance (
        source varchar(20),
        destination varchar(20),
        distance int
    );

insert into src_dest_distance values ('Bangalore', 'Hyderbad', 400);

insert into src_dest_distance values ('Hyderbad', 'Bangalore', 400);

insert into src_dest_distance values ('Mumbai', 'Delhi', 400);

insert into src_dest_distance values ('Delhi', 'Mumbai', 400);

insert into src_dest_distance values ('Chennai', 'Pune', 400);

insert into src_dest_distance values ('Pune', 'Chennai', 400);

select * from src_dest_distance;

with cte as (
        select
            *,
            ROW_NUMBER() over() rn
        from
            src_dest_distance
    )
select
    c1.source,
    c1.destination,
    c1.distance
from cte c1
    join cte c2 on c1.source = c2.destination and c1.rn < c2.rn