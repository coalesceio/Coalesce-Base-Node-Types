@id("389f90fa-3ce2-41d4-becb-0e296dce312c")
@nodeType("eb41edb0-7fd7-477a-be93-ba669aa6193d")
@materializationType("table")
@truncateBefore("false")
@selectDistinct("true")
@preSQL(" ")
@postSQL(" ")
@groupByAll("true")
@insertStrategy("UNION")

SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" @description("Primary Key"),
     "N_NAME" AS "N_NAME" @nullable("false"),
     "N_REGIONKEY" AS "N_REGIONKEY" @defaultValue("0"),
     "N_COMMENT" AS "N_COMMENT" @description("Add comments") @nullable("true") @defaultValue("NA")
FROM {{ ref('SOURCE_DATA', 'NATION') }} "NATION"