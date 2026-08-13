@id("b28e4d76-919f-40ec-be4a-984a2e3e1f1f")
@nodeType("62f0cbc1-957e-4ad5-8ca2-5a2d8d6eef62")
@truncateBefore
SELECT
    c.c_name AS nation,
    r.r_name AS region,
    c.c_custkey AS customer_key,
    o.o_orderkey AS order_key,
    l.l_linenumber AS line_number,
    l.l_extendedprice AS extended_price
FROM {{ ref('SOURCE_DATA', 'CUSTOMER') }} c
JOIN {{ ref('SOURCE_DATA', 'NATION_TEST') }} n
    ON c.c_nationkey = n.n_nationkey
JOIN {{ ref('SOURCE_DATA', 'REGION_PK') }} r
    ON n.n_regionkey = r.r_regionkey
JOIN {{ ref('SOURCE_DATA', 'ORDERS') }} o
    ON c.c_custkey = o.o_custkey
JOIN {{ ref('SOURCE_DATA', 'LINEITEM') }} l
    ON o.o_orderkey = l.l_orderkey