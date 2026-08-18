@id("fdccd367-f639-4dd8-aac7-b605e5a2d874")
@nodeType("62f0cbc1-957e-4ad5-8ca2-5a2d8d6eef62")
@truncateBefore
@testsEnabled
@tests("SELECT 1 FROM {{ this }}")
@tests("SELECT 2 FROM {{ this }}", "Before", true)
@tests("SELECT 3 FROM {{ this }}", "After", true)
@tests("SELECT 4 FROM {{ this }}", "After", true)
@preSQL("SELECT 1 FROM {{ this }} GROUP BY N_COMMENT HAVING COUNT(*) > 1")
@postSQL("SELECT 1 FROM {{ this }} GROUP BY N_COMMENT HAVING COUNT(*) > 2")
@preSQL("SELECT 1 FROM {{ this }} GROUP BY N_COMMENT HAVING COUNT(*) > 3")
@postSQL("SELECT 1 FROM {{ this }} GROUP BY N_COMMENT HAVING COUNT(*) > 4")
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" @tests("unique") @inHash("GH_COL1", 2),
     "N_NAME" AS "N_NAME" @inHash("GH_COL2", 1),
     "N_REGIONKEY" AS "N_REGIONKEY"  @tests("null") @tests("unique") @inHash("GH_COL1", 1) @inHash("GH_COL2", 2),
     "N_COMMENT" AS "N_COMMENT" @description("'Nation Comment'") @defaultValue("NA") @notNull,
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @tests("null"),
     {{ get_hash('GH_COL1') }}::STRING AS "GH_COL1",
     {{ get_hash('GH_COL2') }}::STRING AS "GH_COL2"
FROM {{ ref('SOURCE_DATA', 'NATION_TEST') }} "NATION_TEST"
WHERE N_NATIONKEY > {{ parameters.nationkey }}