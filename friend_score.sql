WITH agg AS (
    SELECT
        friend."PersonID" AS "PersonID",
        count("FriendID"),
        sum("Score") AS total_score
    FROM
        friend
        JOIN person ON person."PersonID" = friend."FriendID"
    GROUP BY
        friend."PersonID"
)
SELECT
    agg."PersonID",
    person."Name",
    "count",
    total_score
FROM
    agg
    JOIN person ON agg."PersonID" = person."PersonID"
WHERE
    total_score > 100;