@id("8b3f1ea5-43df-4ad8-be67-c4887d845247")
@nodeType("62f0cbc1-957e-4ad5-8ca2-5a2d8d6eef62")
@materializationType("view")
@truncateBefore
@selectDistinct
@testsEnabled
@tests("SELECT 1 FROM {{ this }}")
@tests("SELECT 2 FROM {{ this }}", "Before", true)
@tests("SELECT 3 FROM {{ this }}")
@tests("SELECT 4 FROM {{ this }}", "After", true)
@preSQL("SELECT 1 FROM {{ this }} GROUP BY N_COMMENT HAVING COUNT(*) > 1")
@postSQL("SELECT 1 FROM {{ this }} GROUP BY N_COMMENT HAVING COUNT(*) > 1")
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" @tests("unique") @inHash("GH_COL1", 2) @inHash("GH_COL2", 1),
     "N_NAME" AS "N_NAME" @notNull,
     "N_REGIONKEY" AS "N_REGIONKEY" @tests("unique", "null") @inHash("GH_COL1", 1) @inHash("GH_COL2", 2),
     "N_COMMENT" AS "N_COMMENT" @description("Nation comment")  @tests("null", "unique"),
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @tests("null"),
     {{ get_hash('GH_COL1') }}::STRING AS "GH_COL1",
     {{ get_hash('GH_COL2') }}::STRING AS "GH_COL2"
FROM {{ ref('SOURCE_DATA', 'NATION_TEST') }} "NATION_TEST"