@id("ffbd0e1b-e536-4a54-a510-48c0242e43ef")
@nodeType("695")
WITH regional_sales AS (
    SELECT
        r.r_regionkey,
        r.r_name AS region_name,
        n.n_nationkey,
        n.n_name AS nation_name,
        o.o_orderkey,
        o.o_orderdate,
        SUM(
            l.l_extendedprice * (1 - l.l_discount)
        ) AS order_revenue
    FROM {{ ref('SOURCE_DATA', 'ORDERS') }} o
    INNER JOIN {{ ref('SOURCE_DATA', 'LINEITEM') }} l
        ON o.o_orderkey = l.l_orderkey
    INNER JOIN {{ ref('SOURCE_DATA', 'NATION_TEST') }} n
        ON o.o_custkey % 25 = n.n_nationkey      -- example join for demo
    INNER JOIN {{ ref('SOURCE_DATA', 'REGION_PK') }} r
        ON n.n_regionkey = r.r_regionkey
    WHERE o.o_orderdate >= DATE '1995-01-01'
    GROUP BY
        r.r_regionkey,
        r.r_name,
        n.n_nationkey,
        n.n_name,
        o.o_orderkey,
        o.o_orderdate
),

nation_summary AS (
    SELECT
        region_name,
        nation_name,
        COUNT(DISTINCT o_orderkey) AS total_orders,
        SUM(order_revenue) AS total_revenue,
        AVG(order_revenue) AS avg_order_revenue
    FROM regional_sales
    GROUP BY
        region_name,
        nation_name
    HAVING SUM(order_revenue) > 100000
)

SELECT
    region_name,
    nation_name,
    total_orders,
    total_revenue,
    avg_order_revenue,
    CASE
        WHEN total_revenue >= 1000000 THEN 'HIGH'
        WHEN total_revenue >= 500000 THEN 'MEDIUM'
        ELSE 'LOW'
    END AS revenue_band,
    RANK() OVER (
        PARTITION BY region_name
        ORDER BY total_revenue DESC
    ) AS region_rank
FROM nation_summary
QUALIFY region_rank <= 5
ORDER BY
    region_name,
    total_revenue DESC;