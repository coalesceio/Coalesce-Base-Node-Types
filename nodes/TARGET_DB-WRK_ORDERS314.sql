@id("78816ae1-5cc7-42a8-a074-fa2ebd3c76ab")
@nodeType("62f0cbc1-957e-4ad5-8ca2-5a2d8d6eef62")
@truncateBefore
SELECT
     "ORDER_ID" AS "ORDER_ID",
     "CUSTOMER_NAME" AS "CUSTOMER_NAME",
     "ORDER_DATA" AS "ORDER_DATA",
     CURRENT_DATE() AS cur_date
FROM {{ ref('SOURCE_DATA', 'ORDERS') }} "ORDERS"