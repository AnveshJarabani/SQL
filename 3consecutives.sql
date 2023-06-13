select l.id
from logs l
    join logs l1 on l.id = l1.id -1
    join logs l2 on l.id = l2.id -2
where
    l.num = l1.num
    and l.num = l2.num;