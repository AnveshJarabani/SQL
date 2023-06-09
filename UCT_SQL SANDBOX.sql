-- Active: 1682009795450@@mysql12--2.mysql.database.azure.com@3306@uct_data
select count(*) from `lbr m-18`;

DROP TABLE ;

select `Order - Material (key)` , sum(`Operation Quantity`) from 
(SELECT DISTINCT `Order - Material (Key)`,`Order`,`Operation Quantity` FROM `lbr m-18`
where `Fiscal year/period` like '%2022') x
where `Order - Material (key)` in 
('UC-66-73960-00','UC-66-72032-00','UC-66-68025-00')
GROUP BY `Order - Material (key)`;



SELECT 'Order - Material (Key)',STR_TO_DATE(`Start Date`,'%m/%d/%y') as `Date`
FROM `lbr m-18`
ORDER BY `Date` DESC;

use leetcode;
drop table login_details;
create table login_details(
login_id int primary key,
user_name varchar(50) not null,
login_date date);



SELECT sub_q.* from 
(SELECT
DATE_FORMAT(date,'%M') as month,
account_id,
COUNT(distinct patient_id) as no_of_unique_patients,
ROW_NUMBER() over (PARTITION BY month order by no_of_unique_patients desc) as rn
from patient_logs
GROUP BY month,account_id
ORDER BY account_id ASC, no_of_unique_patients DESC) sub_q
where sub_q.rn<3;



select sub_q.* from employee
join
(select *,
MAX(`SALARY`) OVER (PARTITION BY `DEPT_NAME`) as max_salary,
MIN(`SALARY`) OVER (PARTITION BY `DEPT_NAME`) AS min_salary from employee) sub_q
on employee.`emp_ID`=sub_q.`emp_ID`
where employee.`SALARY`!=sub_q.max_salary or employee.`SALARY`!=sub_q.min_salary;
UPDATE users email
set email=CONCAT(user_name,'@email.com');
t.request_at as Day,t.status ;

select user_id,user_name,email from
(select *,
ROW_NUMBER() OVER (PARTITION BY user_name) as rn
from users) x 
where x.rn>1;




select t.request_at as Day,
round(sum(if(t.status!='completed',1,0))/count(t.status),2) as `Cancellation Rate`
from Trips t
WHERE t.request_at BETWEEN '2013-10-01' and '2013-10-03'
and t.client_id not in (select users_id from users where banned not like 'No')
and t.driver_id not in (select users_id from users where banned not like 'No')
GROUP BY t.request_at;



(select t.* from trips t
join (
select u.users_id from users u
where u.banned not like 'Yes') sub_q
on t.client_id=sub_q.users_id) ;





SELECT d.name as Department,sub_q.employee1,sub_q.salary from department d
JOIN
(SELECT mx.salary,e.name as employee1,e.`departmentId` from employee1 e
JOIN 
(SELECT e.`departmentId` as department,(order by e.salary limit 3) as Salary from employee1 e
GROUP BY e.`departmentId`) mx
on mx.`salary`=e.`salary` and 
) sub_q on 
d.id=sub_q.`departmentid`;



select d.`name` as Department ,sub_q.`Employee`,sub_q.salary from department d
join 
(with ranked_salaries as (SELECT e.`departmentId`,
DENSE_RANK() over (PARTITION BY `departmentId` ORDER BY e.salary desc) as rk,
e.name,e.salary,e.id
from employee e)
select `departmentId` as Department,name as employee,salary from ranked_salaries
where rk<4
order by Department) sub_q
on sub_q.department=d.id;
SELECT e.`departmentId` as department,
DENSE_RANK() over (PARTITION BY `departmentId` ORDER BY e.salary) as rk,
e.name,e.salary,e.id
from employee e;


select DISTINCT `Standard Text Key`,`Work Center` from `lbr m-18`;

select DISTINCT `Operation Text`,`Standard Text Key`,`Order - Material (Key)`
 from `lbr m-18`
where `Operation Text` like '%bend%';

use uct_data;

