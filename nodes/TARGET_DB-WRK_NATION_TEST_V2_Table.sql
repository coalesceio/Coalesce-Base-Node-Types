@id("1a37917d-4e93-4b98-be0f-0c14eafc5624")
@nodeType("695")
@orderby(true)
@orderbycolumn("N_NAME", "desc")
@orderbycolumn("N_REGIONKEY", "desc")
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" @nullable(false),
     "N_NAME" AS "N_NAME" @description("Nation Name"),
     "N_REGIONKEY" AS "N_REGIONKEY" @defaultValue(0),
     "N_COMMENT" AS "N_COMMENT",
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP"
FROM {{ ref('SOURCE_DATA', 'NATION_TEST') }} "NATION_TEST"