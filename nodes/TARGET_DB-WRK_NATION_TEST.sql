@id("ee0e2096-3872-4115-a47b-b1b1efb9117e")
@nodeType("695")
@truncateBefore(false)
@description("adfg''ad,")
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" @nullable(false) @inHash("1|GH_COL"),
     "N_NAME" AS "N_NAME" @description("Nation Name"),
     "N_REGIONKEY" AS "N_REGIONKEY" @defaultValue(0),
     "N_COMMENT" AS "N_COMMENT",
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP",
     {{ get_hash('GH_COL') }}::STRING AS "GH_COL"
FROM {{ ref('SOURCE_DATA', 'NATION_TEST') }} "NATION_TEST"