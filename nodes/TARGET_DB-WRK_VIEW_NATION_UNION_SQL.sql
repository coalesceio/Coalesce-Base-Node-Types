@id("e7a0bed5-1b61-4dc2-916c-56451eacafc1")
@nodeType("eb41edb0-7fd7-477a-be93-ba669aa6193d")
@materializationType("view")

WITH ALL_NATIONS AS (

    SELECT N_NATIONKEY, N_NAME, N_REGIONKEY, N_COMMENT
    FROM {{ ref('SOURCE_DATA', 'NATION_COPY1') }}

    UNION

    SELECT N_NATIONKEY, N_NAME, N_REGIONKEY, N_COMMENT
    FROM {{ ref('SOURCE_DATA', 'NATION_COPY2') }}

)

SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" @description("Primary Key"),
     "N_NAME" AS "N_NAME" @nullable("false"),
     "N_REGIONKEY" AS "N_REGIONKEY" @defaultValue("0"),
     "N_COMMENT" AS "N_COMMENT" @description("Add comments") @nullable("true") @defaultValue("NA")
FROM ALL_NATIONS