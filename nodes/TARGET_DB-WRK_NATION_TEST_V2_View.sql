@id("0111ecc7-5619-4a35-a845-d1eab37c288c")
@nodeType("695")
@materializationType("view")
@selectDistinct(true)
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" @nullable(false),
     "N_NAME" AS "N_NAME" @description("Nation Name"),
     "N_REGIONKEY" AS "N_REGIONKEY" @defaultValue(0),
     "N_COMMENT" AS "N_COMMENT",
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP"
FROM {{ ref('SOURCE_DATA', 'NATION_TEST') }} "NATION_TEST"