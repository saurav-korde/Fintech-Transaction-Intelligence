/*
Project: Fintech Transaction Intelligence
Author: Saurav Korde
Date: 2026-03-13
Goal: Bulk ingest raw CSV files into PostgreSQL using the high-performance COPY command.
*/

-- =======================================================
-- 1. Ingest Users Dimension Data
-- =======================================================
-- Step A: Audit (Ensure table is empty)
SELECT COUNT(*) AS users_count_before FROM users;

-- Step B: The Fix (Execute COPY)
COPY users FROM '/Users/sauravsunilkorde/Desktop/Data Analyst/Projects/Fintech-Transaction-Intelligence/raw_data/sd254_users.csv' DELIMITER ',' CSV HEADER;

-- Step C: Verify (Check row count)
SELECT COUNT(*) AS users_count_after FROM users;

-- =======================================================
-- 2. Ingest Cards Dimension Data
-- =======================================================
-- Step A: Audit
SELECT COUNT(*) AS cards_count_before FROM cards;

-- Step B: The Fix 
COPY cards FROM '/Users/sauravsunilkorde/Desktop/Data Analyst/Projects/Fintech-Transaction-Intelligence/raw_data/sd254_cards.csv' DELIMITER ',' CSV HEADER;

-- Step C: Verify 
SELECT COUNT(*) AS cards_count_after FROM cards;

-- =======================================================
-- 3. Ingest Transactions Fact Data (The 2.35 GB Behemoth)
-- =======================================================
-- Step A: Audit
SELECT COUNT(*) AS transactions_count_before FROM transactions;

-- Step B: The Fix 
COPY transactions FROM '/Users/sauravsunilkorde/Desktop/Data Analyst/Projects/Fintech-Transaction-Intelligence/raw_data/credit_card_transactions-ibm_v2.csv' DELIMITER ',' CSV HEADER;

-- Step C: Verify 
SELECT COUNT(*) AS transactions_count_after FROM transactions;