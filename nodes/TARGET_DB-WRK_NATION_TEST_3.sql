@id("2b7c7b9a-8aa7-452d-a3b1-d8e25faa70f1")
@nodeType("695")
@materializationType("view")
@selectDistinct(true)

@tests("SELECT 1 FROM {{ this }}", "Before", true)
@testsEnabled(true)
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY",
     "N_NAME" AS "N_NAME",
     "N_REGIONKEY" AS "N_REGIONKEY" @nullable(false),
     "N_COMMENT" AS "N_COMMENT" @tests("null"),
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP"
FROM {{ ref('SOURCE_DATA', 'NATION_TEST') }} "NATION_TEST"