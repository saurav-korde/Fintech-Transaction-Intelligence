/*
Project: Fintech Transaction Intelligence
Author: Saurav Korde
Date: 2026-03-13
Goal: Perform exploratory data analysis (EDA) and business intelligence queries.
*/

-- =======================================================
-- Query 1: Top 5 Merchants by Total Transaction Volume
-- =======================================================
SELECT 
    merchant_name,
    COUNT(*) AS total_transactions,
    SUM(amount_numeric) AS total_revenue_processed
FROM v_transactions_clean
GROUP BY merchant_name
ORDER BY total_revenue_processed DESC
LIMIT 5;

-- =======================================================
-- Query 2: The Baseline Fraud Rate
-- Goal: What percentage of our total transactions are actually fraudulent?
-- =======================================================
SELECT 
    is_fraud,
    COUNT(*) AS total_transactions,
    ROUND((COUNT(*) * 100.0) / (SELECT COUNT(*) FROM v_transactions_clean), 4) AS percentage_of_total
FROM v_transactions_clean
GROUP BY is_fraud;

-- =======================================================
-- Query 3: Fraud Risk by Transaction Method
-- Goal: Are online transactions riskier than physical chip transactions?
-- =======================================================
SELECT 
    use_chip AS transaction_method,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN is_fraud = 'Yes' THEN 1 ELSE 0 END) AS fraud_count,
    ROUND((SUM(CASE WHEN is_fraud = 'Yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 4) AS fraud_rate_percentage
FROM v_transactions_clean
GROUP BY use_chip
ORDER BY fraud_rate_percentage DESC;

-- =======================================================
-- Query 4: High-Risk Merchant Categories (MCC)
-- Goal: Which types of businesses attract the most fraud volume?
-- =======================================================
SELECT 
    mcc AS merchant_category_code,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN is_fraud = 'Yes' THEN 1 ELSE 0 END) AS fraud_count,
    SUM(CASE WHEN is_fraud = 'Yes' THEN amount_numeric ELSE 0 END) AS total_fraud_financial_loss
FROM v_transactions_clean
GROUP BY mcc
HAVING SUM(CASE WHEN is_fraud = 'Yes' THEN 1 ELSE 0 END) > 0
ORDER BY total_fraud_financial_loss DESC
LIMIT 10;

-- =======================================================
-- Query 5: Fraud Patterns by Time of Day
-- Goal: Do fraudsters strike more often at night or during business hours?
-- =======================================================
SELECT 
    EXTRACT(HOUR FROM CAST(time AS TIME)) AS hour_of_day,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN is_fraud = 'Yes' THEN 1 ELSE 0 END) AS fraud_count
FROM v_transactions_clean
GROUP BY EXTRACT(HOUR FROM CAST(time AS TIME))
ORDER BY hour_of_day ASC;