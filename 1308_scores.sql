
create table scores
( player_name VARCHAR,gender VARCHAR,DAY DATE,score_points INT  )
;
INSERT INTO scores

(player_name,gender,day,score_points )
values
('Aron','F' ,'2020-01-01', 17),
('Alice','F' ,'2020-01-07', 23),
('Bajrang','M' ,'2020-01-07', 7 ),
('Khali','M' ,'2019-12-25', 11),
('Slaman','M' ,'2019-12-30', 13),
('Joe','M' ,'2019-12-31', 3 ),
('Jose','M' ,'2019-12-18', 2 ),
('Priya','F' ,'2019-12-31', 23),
('Priyanka','F' ,'2019-12-30', 17);
create table results
(gender varchar,day date,total int)
;

insert into results

( gender , day  ,       total )
values
('F', '2019-12-30',17),
('F', '2019-12-31',40),
('F', '2020-01-01',57),
('F', '2020-01-07',80),
('M', '2019-12-18',2),
('M', '2019-12-25',13),
('M', '2019-12-30',26),
('M', '2019-12-31',29),
('M', '2020-01-07',36);


select gender,day,
sum(score_points) over(partition by gender order by day) as total
from scores
order by gender, day

