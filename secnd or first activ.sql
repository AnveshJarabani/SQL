--  IN this video we will silve a leetcode hard problem 1369. WHERE we need TO find SECOND most recent activity AND IF user has ONLY 1 activoty THEN RETURN that AS it IS.We will USE SQL window functions TO solve this problem.Here IS the script:
SELECT
    username,
    activity,
    startdate,
    enddate
FROM
    (
        SELECT
            *,
            rank() over(
                PARTITION by username
                ORDER BY
                    startdate
            ) AS rn,
            count(username) over (PARTITION by username) AS ct
        FROM
            useractivity
    ) x
WHERE
    rn = 2
    OR ct = 1;