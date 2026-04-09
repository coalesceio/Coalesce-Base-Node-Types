@id("e8e13e6f-f79e-4ee9-9f8a-ad039a2d3d7a")
@nodeType("eb41edb0-7fd7-477a-be93-ba669aa6193d")
@materializationType("view")
@selectDistinct

SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" @description("Primary Key"),
     "N_NAME" AS "N_NAME" @nullable("false") @description("Primary Key"),
     "N_REGIONKEY" AS "N_REGIONKEY" @defaultValue("0"),
     "N_COMMENT" AS "N_COMMENT" @description("Add comments") @nullable("false") @defaultValue("NA")
FROM {{ ref('SOURCE_DATA', 'NATION') }} "NATION"
WHERE N_NATIONKEY = 2