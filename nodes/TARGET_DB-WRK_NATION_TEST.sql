@id("bfd38227-681f-4dca-b148-bd7b6fc79a67")
@nodeType("62f0cbc1-957e-4ad5-8ca2-5a2d8d6eef62")
@truncateBefore
@selectDistinct
@testsEnabled
@tests("SELECT 1 FROM {{ this }}", "Before", true)
@tests("SELECT 2 FROM {{ this }}", "Before", true)
@tests("SELECT 3 FROM {{ this }}", "After", true)
@tests("SELECT 4 FROM {{ this }}", "After", true)
@preSQL("SELECT 1 FROM {{ this }} GROUP BY N_COMMENT HAVING COUNT(*) > 1")
@postSQL("SELECT 1 FROM {{ this }} GROUP BY N_COMMENT HAVING COUNT(*) > 1")
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY",
     "N_NAME" AS "N_NAME" @notNull,
     "N_REGIONKEY" AS "N_REGIONKEY" @defaultValue("0"),
     "N_COMMENT" AS "N_COMMENT" @description("Nation comment"),
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP"
FROM {{ ref('SOURCE_DATA', 'NATION_TEST') }} "NATION_TEST"