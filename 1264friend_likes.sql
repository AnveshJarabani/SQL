create table frindships
(user1_id int, user2_id int);
insert into frindships
(user1_id, user2_id)
values( 1, 2 ),
( 1, 3 ),
( 1, 4 ),
( 2, 3 ),
( 2, 4 ),
( 2, 5 ),
( 6, 1 );
create table likes
(user_id int, page_id int);
insert into likes
(user_id,page_id)
values( 1, 88 ),
( 2, 23 ),
( 3, 24 ),
( 4, 56 ),
( 5, 11 ),
( 6, 33 ),
( 2, 77 ),
( 3, 77 ),
( 6, 88 );



with all_friends as (select * from frindships
where user1_id=1
union all
(select user2_id as user1_id,user1_id as user2_id
from frindships
where user2_id=1))

select distinct page_id from likes
where user_id in (select user2_id from all_friends)
and page_id not in (select page_id from likes where user_id=1)