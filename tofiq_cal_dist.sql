drop table if exists src_dest_dist;
create table src_dest_dist
(
    src         varchar(20),
    dest        varchar(20),
    distance    float
);
insert into src_dest_dist values ('A', 'B', 21);
insert into src_dest_dist values ('B', 'A', 28);
insert into src_dest_dist values ('A', 'B', 19);
insert into src_dest_dist values ('C', 'D', 15);
insert into src_dest_dist values ('C', 'D', 17);
insert into src_dest_dist values ('D', 'C', 16.5);
insert into src_dest_dist values ('D', 'C', 18);


with cte as 
(select src,dest,sum(distance) as total_dist,
count(src) as routs,
ROW_NUMBER() OVER (ORDER BY src) as id
from src_dest_dist
GROUP BY src, dest)

select t1.src,t1.dest,round((t1.total_dist+t2.total_dist)/(t1.routs+t2.routs),2) as mean from cte t1
join cte t2 on t1.src = t2.dest and t1.id<t2.id
