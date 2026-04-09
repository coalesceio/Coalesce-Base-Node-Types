@id("58548972-aa58-4a55-be1e-69d4d9fe0979")
@nodeType("932f2d25-0815-4c57-8e77-4a7d2c9a4c75")
@materializationType("table")
@truncateBefore
@lastModifiedComparison
@treatNullAsCurrentTimestamp
@type2Dimension
@selectDistinct
@groupByAll

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
FROM {{ ref('SOURCE_DATA', 'NATION') }} nation