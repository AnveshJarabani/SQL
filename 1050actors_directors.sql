-- Active: 1682038109540@@mysql12--2.mysql.database.azure.com@3306@leetcode
Create table If Not Exists ActorDirector (actor_id int, director_id int, timestamp int);
Truncate table ActorDirector;
insert into ActorDirector (actor_id, director_id, timestamp) values ('1', '1', '0');
insert into ActorDirector (actor_id, director_id, timestamp) values ('1', '1', '1');
insert into ActorDirector (actor_id, director_id, timestamp) values ('1', '1', '2');
insert into ActorDirector (actor_id, director_id, timestamp) values ('1', '2', '3');
insert into ActorDirector (actor_id, director_id, timestamp) values ('1', '2', '4');
insert into ActorDirector (actor_id, director_id, timestamp) values ('2', '1', '5');
insert into ActorDirector (actor_id, director_id, timestamp) values ('2', '1', '6');

select actor_id,director_id from 
(
select actor_id,director_id,count(concat(actor_id,director_id)) ct from actordirector
group by actor_id,director_id
having ct>2) x;

select actor_id,director_id from actordirector
group by actor_id,director_id
having count(*)>2;