@id("fc2b4b08-cd7e-4d74-bee1-271acf5d743c")
@nodeType("1f58cb9f-3814-4120-a223-10dad03d4a91")
@groupByAll(true)
@preSQL("SELECT 1 FROM {{ this }} GROUP BY N_COMMENT HAVING COUNT(*) > 1")
@postSQL("SELECT 1 FROM {{ this }} GROUP BY N_COMMENT HAVING COUNT(*) > 1")
@testsEnabled(true)
@orderby(true)
@orderbycolumn("N_REGIONKEY", "desc")
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" @defaultValue("00"),
     "N_NAME" AS "N_NAME" @description("hello"),
     "N_REGIONKEY" AS "N_REGIONKEY" @nullable(false) @inHash("1|GH_COL"),
     "N_COMMENT" AS "N_COMMENT",
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @tests("null", "unique"),
     {{ get_hash('GH_COL') }}::STRING AS "GH_COL",
     SHA1(NVL(CAST(GH_COL AS VARCHAR), 'null'))::STRING AS "GH_Key"
FROM {{ ref('SOURCE_DATA', 'NATION_TEST') }} "NATION_TEST"