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
)
SELECT
    i."Product Code",
    i."Material",
    p.Direct_hrs
FROM
    itpr_codes i
    JOIN pn_hrs p ON p."Material" = i."Material"
WHERE
    "Product Code" iLIKE 'LAM_IND';

SELECT
    DISTINCT "Product Code"
FROM
    itpr_codes;
select * from lbr_pln_hr;