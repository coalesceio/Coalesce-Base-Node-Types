@id("f55fe302-8d76-4ddf-b74c-55193f816bc8")
@nodeType("695")
WITH max_date AS (
    SELECT MAX(O_ORDERDATE) AS max_order_date
    FROM {{ ref('SOURCE_DATA', 'ORDERS') }}
),

recent_orders AS (
    SELECT
        "O_ORDERKEY" AS order_key,
        "O_CUSTKEY" AS customer_key,
        "O_TOTALPRICE" AS order_total,
        "O_ORDERDATE" AS order_date
    FROM {{ ref('SOURCE_DATA', 'ORDERS') }} "STG_ORDERS"
    CROSS JOIN max_date
    WHERE "STG_ORDERS"."O_ORDERDATE" >= DATEADD(MONTH, -3, max_date.max_order_date)
),

order_summary AS (
    SELECT
        order_date,
        COUNT(*) AS order_count,
        SUM(order_total) AS total_spend
    FROM recent_orders
    GROUP BY order_date
)

SELECT
    order_date,
    order_count,
    total_spend,
    total_spend / order_count AS avg_order_value
FROM order_summary