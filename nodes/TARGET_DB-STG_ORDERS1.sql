@id("192b5063-16b6-4cfb-bfb8-adbc799a4485")
@nodeType("eb41edb0-7fd7-477a-be93-ba669aa6193d")
WITH order_math AS (
    SELECT 
        O_ORDERKEY,
        O_CUSTKEY,
        O_TOTALPRICE,
        CEIL(O_TOTALPRICE) AS CEILED_PRICE,
        FLOOR(O_TOTALPRICE) AS FLOORED_PRICE,
        O_TOTALPRICE * 0.075 AS RAW_TAX
    FROM {{ ref('SRC', 'ORDERS') }}
),
formatted_orders AS (
    SELECT 
        *,
        ROUND(RAW_TAX, 2) AS FINAL_TAX,
        ABS(O_TOTALPRICE + RAW_TAX) AS TOTAL_WITH_TAX
    FROM order_math
)
SELECT 
    fo.O_ORDERKEY,
    fo.CEILED_PRICE,
    fo.FLOORED_PRICE,
    fo.TOTAL_WITH_TAX,
    c.C_NAME AS CUSTOMER_NAME,
    CASE 
        WHEN fo.TOTAL_WITH_TAX > 5000 THEN 'High Value'
        WHEN fo.TOTAL_WITH_TAX > 1000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS ORDER_RANK
FROM formatted_orders fo
JOIN {{ ref('SRC', 'CUSTOMER') }} c ON fo.O_CUSTKEY = c.C_CUSTKEY