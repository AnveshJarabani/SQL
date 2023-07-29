-- Active: 1689145165545@@localhost@5432@postgres@leetcode
CREATE TABLE accounts (id int, name varchar);

insert into accounts
(id,name)
values
( 1  , 'Winston'),
( 7  , 'Jonathan');

create table logins
(id int, login_date date);

insert into logins
(id,login_date)
values
( 7  ,'2020-05-30'),
( 1  ,'2020-05-30'),
( 7  ,'2020-05-31'),
( 7  ,'2020-06-01'),
( 7  ,'2020-06-02'),
( 7  ,'2020-06-02'),
( 7  ,'2020-06-03'),
( 1  ,'2020-06-07'),
( 7  ,'2020-06-10');


select *,
row_number() over(partition by id order by login_date) as rn
from logins