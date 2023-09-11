WITH CTE AS (
    SELECT
        DISTINCT ON ("MATERIAL", "OP_NUMBER") "PLANT",
        "MATERIAL",
        "SETUP",
        CASE
            WHEN "RUN_UNIT" = 'MIN' THEN ROUND("RUN" :: DECIMAL / 60, 2)
            ELSE "RUN"
        END AS "RUN"
    FROM
        st_bm_br_rout
    WHERE
        "STD_KEY" IN (
            SELECT
                "ST KEY"
            FROM
                st_bm_br_br
        )
)
SELECT
    "PLANT",
    "MATERIAL",
    round(SUM("SETUP") :: DECIMAL + SUM("RUN") :: DECIMAL,2) AS "ROUT_HRS"
FROM
    CTE
GROUP BY
    1,
    2;

SELECT
    DISTINCT ON ("OP_NUMBER") *
FROM
    st_bm_br_rout
WHERE
    "MATERIAL" = '0154388-010'