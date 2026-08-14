@id("b818a573-6e61-4c5f-b83d-da04a72f6495")
@nodeType("1f58cb9f-3814-4120-a223-10dad03d4a91")
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" @defaultValue("00"),
     "N_NAME" AS "N_NAME" @description("hello"),
     "N_REGIONKEY" AS "N_REGIONKEY" @nullable(false),
     "N_COMMENT" AS "N_COMMENT",
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP"
FROM {{ ref('SOURCE_DATA', 'NATION_TEST') }} "NATION_TEST"