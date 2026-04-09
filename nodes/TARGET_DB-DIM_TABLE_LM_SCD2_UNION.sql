@id("df7d5213-a4a5-4a18-a6c6-39bceeef2682")
@nodeType("932f2d25-0815-4c57-8e77-4a7d2c9a4c75")
@materializationType("table")
@truncateBefore("false")
@selectDistinct("true")
@lastModifiedComparison("true")
@treatNullAsCurrentTimestamp("true")
@type2Dimension("true")
@preSQL(" ")
@postSQL(" ")

WITH ALL_NATIONS AS (

    SELECT nc1.N_NATIONKEY, nc1.N_NAME, nc1.N_REGIONKEY, nc1.N_COMMENT, nc1.N_LOAD_TIMESTAMP
    FROM {{ ref('SOURCE_DATA', 'NATION_COPY1') }} nc1

    UNION

    SELECT nc2.N_NATIONKEY, nc2.N_NAME, nc2.N_REGIONKEY, nc2.N_COMMENT, nc2.N_LOAD_TIMESTAMP
    FROM {{ ref('SOURCE_DATA', 'NATION_COPY2') }} nc2

)

SELECT
     0 AS "{{ node.name }}_KEY" @isSurrogateKey @nullable("false") @description("System generated value"),
     nation."N_NATIONKEY" AS "N_NATIONKEY" @isBusinessKey @defaultValue("0"),
     nation."N_NAME" AS "N_NAME" @defaultValue("John-Doe"),
     nation."N_REGIONKEY" AS "N_REGIONKEY" @defaultValue("0"),
     nation."N_COMMENT" AS "N_COMMENT" @description("Add comments") @nullable("true") @defaultValue("NA"),
     nation."N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @isLastModifiedColumn,
     0 AS "SYSTEM_VERSION" @isSystemVersion @defaultValue("1"),
     '' AS "SYSTEM_CURRENT_FLAG" @isSystemCurrentFlag @defaultValue("Y"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_START_DATE" @isSystemStartDate,
     CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE" @isSystemEndDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @isSystemUpdateDate
FROM ALL_NATIONS nation
WHERE nation.N_NATIONKEY = 2