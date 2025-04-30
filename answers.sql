-- Question 1
-- Step 1: Recursive CTE to split comma-separated values
WITH RECURSIVE product_split AS (
    SELECT 
        OrderID,
        CustomerName,
        TRIM(SUBSTRING_INDEX(Products, ',', 1)) AS Product,
        SUBSTRING(Products, LENGTH(SUBSTRING_INDEX(Products, ',', 1)) + 2) AS rest
    FROM ProductDetail

    UNION ALL

    SELECT
        OrderID,
        CustomerName,
        TRIM(SUBSTRING_INDEX(rest, ',', 1)) AS Product,
        SUBSTRING(rest, LENGTH(SUBSTRING_INDEX(rest, ',', 1)) + 2)
    FROM product_split
    WHERE rest IS NOT NULL AND rest != ''
)

-- Step 2: Select the normalized data
SELECT 
    OrderID,
    CustomerName,
    Product
FROM 
    product_split;

-- Question 2
-- Step 1: Orders Table 
SELECT DISTINCT
    OrderID,
    CustomerName
FROM OrderDetails;

-- step 2:  OrderItems Table
SELECT
    OrderID,
    Product,
    Quantity
FROM OrderDetails;

