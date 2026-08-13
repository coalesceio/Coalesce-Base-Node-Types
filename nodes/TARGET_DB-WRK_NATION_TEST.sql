@id("eb77e25d-7c4d-4093-9f3e-cbe99f10fd7e")
@nodeType("62f0cbc1-957e-4ad5-8ca2-5a2d8d6eef62")
@description("This node creates the WRK_NATION_TEST table and populates it with distinct records extracted from the NATION_TEST source table.")
SELECT
     NATION_TEST."N_NATIONKEY" AS "N_NATIONKEY_RENAMED",
     "NATION_TEST"."N_NAME" AS "N_NAME",
     "N_REGIONKEY" AS "N_REGIONKEY" @defaultValue("100"),
     "N_COMMENT" AS "N_COMMENT"@description("Comment-changed"),
     1000 AS "N_AREA"
FROM {{ ref('SOURCE_DATA', 'NATION_TEST') }} "NATION_TEST"