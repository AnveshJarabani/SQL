




select name from candidate 
where id in 
(select candidateid from vote
GROUP BY 1
ORDER BY count(1) desc
limit 1)