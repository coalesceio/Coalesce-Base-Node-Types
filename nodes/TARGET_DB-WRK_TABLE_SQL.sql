@id("3aa536f6-ebd5-4814-ac14-8b7ecaecc1af")
@nodeType("eb41edb0-7fd7-477a-be93-ba669aa6193d")
@materializationType("table")
@truncateBefore
@selectDistinct
@preSQL("SELECT count(*) FROM TANVI_DEV.SOURCE.NATION")
@postSQL("SELECT count(*) FROM TANVI_DEV.SOURCE.NATION")

SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" @description("Primary Key"),
     "N_NAME" AS "N_NAME" @nullable("false") @description("Primary Key"),
     "N_REGIONKEY" AS "N_REGIONKEY" @defaultValue("0"),
     "N_COMMENT" AS "N_COMMENT" @description("Add comments") @nullable("false") @defaultValue("NA")
FROM {{ ref('SOURCE_DATA', 'NATION') }} "NATION"
WHERE N_NATIONKEY = 2