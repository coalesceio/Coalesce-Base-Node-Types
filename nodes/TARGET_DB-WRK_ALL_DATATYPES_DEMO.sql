@id("b6ce57c9-37e8-4ac6-8217-c6fba61bc818")
@nodeType("695")
SELECT
     "COL_NUMBER"           AS "COL_NUMBER"           @defaultValue(0),
     "COL_DECIMAL"          AS "COL_DECIMAL"          @defaultValue(0.00),
     "COL_INT"              AS "COL_INT"              @defaultValue(0),
     "COL_FLOAT"            AS "COL_FLOAT"            @defaultValue(0.0),
     "COL_DOUBLE"           AS "COL_DOUBLE"           @defaultValue(0.0),
     "COL_BOOLEAN"          AS "COL_BOOLEAN"          @defaultValue(false),
     "COL_VARCHAR"          AS "COL_VARCHAR"          @defaultValue("N``'''/``A"),
     "COL_STRING"           AS "COL_STRING"           @defaultValue('N/A'),
     "COL_CHAR"             AS "COL_CHAR"             @defaultValue("'A'"),
     "COL_TEXT"             AS "COL_TEXT"             @defaultValue('N/A'),
     "COL_DATE"             AS "COL_DATE"             @defaultValue("TO_DATE('2000-01-01')"),
     "COL_TIME"             AS "COL_TIME"             @defaultValue("TO_TIME('00:00:00')"),
     "COL_TIMESTAMP"        AS "COL_TIMESTAMP"        @defaultValue("TO_TIMESTAMP('2000-01-01 00:00:00')"),
     "COL_TIMESTAMP_NTZ"    AS "COL_TIMESTAMP_NTZ"    @defaultValue("TO_TIMESTAMP_NTZ('2000-01-01 00:00:00')"),
     "COL_TIMESTAMP_LTZ"    AS "COL_TIMESTAMP_LTZ"    @defaultValue("TO_TIMESTAMP_LTZ('2000-01-01 00:00:00')"),
     "COL_TIMESTAMP_TZ"     AS "COL_TIMESTAMP_TZ"     @defaultValue("TO_TIMESTAMP_TZ('2000-01-01 00:00:00 +0000')"),
     "COL_BINARY"           AS "COL_BINARY",
     "COL_VARIANT"          AS "COL_VARIANT"          @defaultValue('{}'),
     "COL_OBJECT"           AS "COL_OBJECT"           @defaultValue('{}'),
     "COL_ARRAY"            AS "COL_ARRAY"            @defaultValue('[]'),
     "COL_GEOGRAPHY"        AS "COL_GEOGRAPHY"        @defaultValue('POINT(0 0)'),
     "COL_GEOMETRY"         AS "COL_GEOMETRY"         @defaultValue('POINT(0 0)'),
     "COL_XML"              AS "COL_XML"              @defaultValue('<root/>')
FROM {{ ref('SOURCE_DATA', 'ALL_DATATYPES_DEMO') }} "ALL_DATATYPES_DEMO"