-- Active: 1682009795450@@mysql12--2.mysql.database.azure.com@3306@uct_data


with RECURSIVE cte as 
    (select *, cast(`QTY` as FLOAT) as TOPLEVEL
    from st_bm_br_bom
    where `MATERIAL`='839-198032-001'
    union all
    (SELECT s.*, cast(s.QTY as FLOAT)*cte.TOPLEVEL as TOPLEVEL
     from st_bm_br_bom s
     join cte on 
     cte.`COMPONENT`=s.`MATERIAL`))
SELECT * from cte
where `COMPONENT` = 'UC-27-56178-00' OR `MATERIAL` = 'UC-27-56178-00';

select * from st_bm_br_bom;