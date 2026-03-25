@id("616b5ff2-7fe8-4255-8476-0382fd4cbbef")
@nodeType("eb41edb0-7fd7-477a-be93-ba669aa6193d")
SELECT 
    CASE 
        WHEN C_ACCTBAL > 1000 THEN 1 
        ELSE 0 
    END AS NUMERIC_CASE_TEST
FROM {{ ref('SRC', 'CUSTOMER') }}
