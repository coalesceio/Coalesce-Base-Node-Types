@id("171de2ea-41e9-492e-bfaf-272d422c15cc")
@nodeType("695")
@groupByAll(true)
@tests("SELECT 1 FROM {{ this }}", "Before", true)
@preSQL("SELECT 1 FROM {{ this }} GROUP BY N_COMMENT HAVING COUNT(*) > 1")
@postSQL("SELECT 1 FROM {{ this }} GROUP BY N_COMMENT HAVING COUNT(*) > 1")
@materializationType("view")
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" @nullable(false) @inHash("2|GH_COL"),
     "N_NAME" AS "N_NAME" @description("Nation name"),
     "N_REGIONKEY" AS "N_REGIONKEY" @defaultValue("0") @nullable(false) @inHash("1|GH_COL"),
     "N_COMMENT" AS "N_COMMENT" @tests("null", "unique"),
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP",
     {{ get_hash('GH_COL') }}::STRING AS "GH_COL"
FROM {{ ref('SOURCE_DATA', 'NATION_TEST') }} "NATION_TEST"