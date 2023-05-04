CREATE TABLE emp570 (id int,name VARCHAR(255),department VARCHAR(255),managerid int NULL);
insert into emp570(id,name,department,managerid)
values
(101   ,'John' 	    ,'A',null),
(102   ,'Dan' 	    ,'A',101),
(103   ,'James'  ,'A',101),
(104   ,'Amy' 	    ,'A',101),
(105   ,'Anne' 	    ,'A',101),
(106   ,'Ron' 	    ,'B',101);

select name from emp570
where id in 
(select managerid from emp570
GROUP BY managerid
having count(DISTINCT id)>=5) 