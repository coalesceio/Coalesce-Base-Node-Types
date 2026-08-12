@id("495a425d-74fb-4f75-bde5-6ddf5b71f78c")
@nodeType("45cf1e3d-4897-4b2f-8f13-eb6171f93bcd")
@truncateBefore
@materializationType("table")
@testsEnabled
@tests("SELECT 1 FROM {{ this }}", "Before", true)
@tests("SELECT 1 FROM {{ this }}", "After", true)
@selectDistinct
@preSQL("SELECT 1 FROM {{ this }} GROUP BY N_COMMENT HAVING COUNT(*) > 1")
@postSQL("SELECT 1 FROM {{ this }} GROUP BY N_COMMENT HAVING COUNT(*) > 1")
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" @description("Nation Name"),
     "N_NAME" AS "N_NAME" @notNull,
     "N_REGIONKEY" AS "N_REGIONKEY" @defaultValue("0"),
     "N_COMMENT" AS "N_COMMENT",
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP"
FROM {{ ref('SOURCE_DATA', 'NATION_TEST') }} "NATION_TEST"