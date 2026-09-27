-- Task 20: Customer Order Count
-- Archana - Data Analytics Track
-- Dataset: Online Retail Dataset
-- Purpose: Count orders per customer and identify frequent buyers

-- ============================================
-- STEP 1: Create the table structure
-- ============================================

CREATE TABLE IF NOT EXISTS online_retail (
    InvoiceNo VARCHAR(50),
    StockCode VARCHAR(50),
    Description TEXT,
    Quantity INT,
    InvoiceDate DATETIME,
    UnitPrice DECIMAL(10, 2),
    CustomerID VARCHAR(50),
    Country VARCHAR(100)
);

-- ============================================
-- STEP 2: Import data (example for different SQL environments)
-- ============================================

-- For MySQL:
-- LOAD DATA INFILE 'online_retail.csv' 
-- INTO TABLE online_retail 
-- FIELDS TERMINATED BY ',' 
-- LINES TERMINATED BY '\n' 
-- IGNORE 1 ROWS;

-- For PostgreSQL:
-- COPY online_retail FROM 'online_retail.csv' DELIMITER ',' CSV HEADER;

-- For SQLite:
-- .mode csv
-- .import online_retail.csv online_retail

-- ============================================
-- STEP 3: Data Cleaning - Remove NULL CustomerIDs
-- ============================================

CREATE TABLE IF NOT EXISTS clean_retail AS
SELECT *
FROM online_retail
WHERE CustomerID IS NOT NULL 
  AND CustomerID != ''
  AND InvoiceNo IS NOT NULL;

-- ============================================
-- STEP 4: Count Orders Per Customer
-- ============================================

-- This query counts unique orders (InvoiceNo) per customer
-- avoiding duplicate order lines

CREATE TABLE IF NOT EXISTS customer_order_count AS
SELECT 
    CustomerID,
    Country,
    COUNT(DISTINCT InvoiceNo) AS TotalOrders,
    MIN(InvoiceDate) AS FirstOrderDate,
    MAX(InvoiceDate) AS LastOrderDate,
    COUNT(DISTINCT InvoiceNo) * 1.0 / 
        DATEDIFF(DAY, MIN(InvoiceDate), MAX(InvoiceDate) + 1) * 30 AS AvgOrdersPerMonth
FROM clean_retail
GROUP BY CustomerID, Country
ORDER BY TotalOrders DESC;

-- ============================================
-- STEP 5: Identify Top 10 Frequent Buyers
-- ============================================

SELECT 
    CustomerID,
    Country,
    TotalOrders,
    FirstOrderDate,
    LastOrderDate,
    ROUND(AvgOrdersPerMonth, 2) AS AvgOrdersPerMonth
FROM customer_order_count
ORDER BY TotalOrders DESC
LIMIT 10;

-- ============================================
-- STEP 6: Customer Segmentation by Order Frequency
-- ============================================

SELECT 
    CASE 
        WHEN TotalOrders >= 50 THEN 'Very High Frequency'
        WHEN TotalOrders >= 20 THEN 'High Frequency'
        WHEN TotalOrders >= 10 THEN 'Medium Frequency'
        WHEN TotalOrders >= 5 THEN 'Low Frequency'
        ELSE 'Very Low Frequency'
    END AS FrequencySegment,
    COUNT(*) AS CustomerCount,
    ROUND(AVG(TotalOrders), 2) AS AvgOrdersInSegment
FROM customer_order_count
GROUP BY FrequencySegment
ORDER BY 
    CASE 
        WHEN FrequencySegment = 'Very High Frequency' THEN 1
        WHEN FrequencySegment = 'High Frequency' THEN 2
        WHEN FrequencySegment = 'Medium Frequency' THEN 3
        WHEN FrequencySegment = 'Low Frequency' THEN 4
        ELSE 5
    END;

-- ============================================
-- STEP 7: Geographic Distribution of Top Customers
-- ============================================

SELECT 
    Country,
    COUNT(*) AS CustomerCount,
    SUM(TotalOrders) AS TotalOrders,
    ROUND(AVG(TotalOrders), 2) AS AvgOrdersPerCustomer
FROM customer_order_count
WHERE TotalOrders >= 10
GROUP BY Country
ORDER BY TotalOrders DESC;

-- ============================================
-- STEP 8: Customer Behavior Analysis
-- ============================================

-- Find customers who placed orders in multiple months
SELECT 
    CustomerID,
    Country,
    TotalOrders,
    COUNT(DISTINCT MONTH(InvoiceDate)) AS ActiveMonths,
    COUNT(DISTINCT YEAR(InvoiceDate)) AS ActiveYears
FROM clean_retail
GROUP BY CustomerID, Country, TotalOrders
HAVING COUNT(DISTINCT MONTH(InvoiceDate)) > 3
ORDER BY ActiveMonths DESC, TotalOrders DESC
LIMIT 20;

-- ============================================
-- STEP 9: Summary Statistics
-- ============================================

SELECT 
    COUNT(DISTINCT CustomerID) AS TotalCustomers,
    COUNT(DISTINCT InvoiceNo) AS TotalOrders,
    ROUND(AVG(TotalOrders), 2) AS AvgOrdersPerCustomer,
    MAX(TotalOrders) AS MaxOrdersBySingleCustomer,
    MIN(TotalOrders) AS MinOrdersBySingleCustomer
FROM customer_order_count;

-- ============================================
-- INTERVIEW QUESTION ANSWERS
-- ============================================

-- Q1: Customer vs order count?
-- A: This query shows the relationship between customers and their order counts
SELECT 
    'Analysis Summary' AS Metric,
    CONCAT('Total Customers: ', COUNT(DISTINCT CustomerID)) AS Value
FROM customer_order_count
UNION ALL
SELECT 
    'Total Orders',
    CONCAT(COUNT(DISTINCT InvoiceNo), ' orders')
FROM clean_retail
UNION ALL
SELECT 
    'Avg Orders/Customer',
    CONCAT(ROUND(AVG(TotalOrders), 2), ' orders')
FROM customer_order_count;

-- Q2: Why is customer ID important?
-- A: Customer ID is the primary key for tracking individual customer behavior,
-- enabling personalization, loyalty programs, and targeted marketing.
-- Without CustomerID, we cannot distinguish between repeat purchases from
-- the same customer vs one-time purchases from different customers.
