@id("38f8c4d1-a11b-4db6-9a31-040b0f8f535a")
@nodeType("695")
@deployEnabled(false)
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" @defaultValue("00"),
     "N_NAME" AS "N_NAME" @defaultValue("0''adkfhljkdahjwhk\\`krwk0"),
     "N_REGIONKEY" AS "N_REGIONKEY",
     "N_COMMENT" AS "N_COMMENT",
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP"
FROM {{ ref('SOURCE_DATA', 'NATION_TEST') }} "NATION_TEST"
where n_nationkey = {{ parameters.nationkey }}