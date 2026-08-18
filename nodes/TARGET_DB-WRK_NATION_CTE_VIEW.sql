@id("98cafdec-6223-4d32-887b-11c9ac5c5f8d")
@nodeType("62f0cbc1-957e-4ad5-8ca2-5a2d8d6eef62")
@description("a join example using two'' CTEs")
@materializationType("view")
WITH nation_cte AS (
    SELECT
        N_NATIONKEY,
        N_NAME,
        N_REGIONKEY
    FROM {{ ref('SOURCE_DATA', 'NATION_TEST') }} "NATION_TEST"
),
region_cte AS (
    SELECT
        N_REGIONKEY,
        COUNT(*) AS nation_count
    FROM {{ ref('SOURCE_DATA', 'NATION_TEST') }} "NATION_TEST"
    GROUP BY N_REGIONKEY
)
SELECT
    n.N_NAME @notNull @defaultValue("N/'A"),
    r.nation_count @description("Region''' Count")
FROM nation_cte n
JOIN region_cte r
    ON n.N_REGIONKEY = r.N_REGIONKEY