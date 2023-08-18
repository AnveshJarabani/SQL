-- Active: 1688765630308@@localhost@5432@uct_data
SELECT
    *
FROM
    shp;

WITH pn_hrs AS (
    SELECT
        "Material",
        ROUND(
            Sum(
                (
                    "Setup" +(
                        CASE
                            WHEN "Unit_Labor Run" = 'MIN' THEN "Labor Run" / 60 :: float
                            ELSE "Labor Run"
                        END
                    )
                ) / "Base Quantity"
            ) :: decimal,
            2
        ) AS Direct_hrs
    FROM
        st_bm_br_rout
    WHERE
        "STD_KEY" IN (
            SELECT
                "ST KEY"
            FROM
                st_bm_br_br
        )
    GROUP BY
        1
),
pn_asps AS (
    SELECT
        "PART_NUMBER",
        AVG("SHP_AMOUNT" / "SHIPPED_QTY") AS ASP
    FROM
        shp
    WHERE
        extract(
            year
            FROM
                "SHIPPED_DATE"
        ) = 2023
    GROUP BY
        1
)
SELECT
    i."Product Code",
    i."Material",
    ph.Direct_hrs,
    asp.ASP
FROM
    itpr_codes i
    JOIN pn_hrs ph ON ph."Material" = i."Material"
    JOIN pn_asps asp ON asp."PART_NUMBER" = ph."Material";