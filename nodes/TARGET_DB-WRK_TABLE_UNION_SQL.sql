@id("332835b5-8959-4d7e-ae6f-225ffad4ff5d")
@nodeType("eb41edb0-7fd7-477a-be93-ba669aa6193d")
@materializationType("table")
@truncateBefore
@selectDistinct
@preSQL("SELECT count(*) FROM TANVI_DEV.SOURCE.NATION")

WITH ALL_NATIONS AS (

    SELECT N_NATIONKEY, N_NAME, N_REGIONKEY, N_COMMENT
    FROM {{ ref('SOURCE_DATA', 'NATION_COPY1') }}

    UNION

    SELECT N_NATIONKEY, N_NAME, N_REGIONKEY, N_COMMENT
    FROM {{ ref('SOURCE_DATA', 'NATION_COPY2') }}

)

SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" @description("Primary Key"),
     "N_NAME" AS "N_NAME" @nullable("false"),
     "N_REGIONKEY" AS "N_REGIONKEY" @defaultValue("0"),
     "N_COMMENT" AS "N_COMMENT" @description("Add comments") @nullable("true") @defaultValue("NA")
FROM ALL_NATIONS
WHERE N_NATIONKEY = 2