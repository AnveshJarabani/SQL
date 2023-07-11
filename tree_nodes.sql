-- Active: 1688765630308@@localhost@5432@leetcode
SELECT
    id,
    CASE
        WHEN p_id IS NULL THEN 'Root'
        WHEN id in (select p_id from tree) THEN 'Inner'
        ELSE 'Leaf'
    END AS TYPE
FROM
    tree;
select * from tree;