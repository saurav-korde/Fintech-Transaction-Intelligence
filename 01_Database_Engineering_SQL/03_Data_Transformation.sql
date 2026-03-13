/*
Project: Fintech Transaction Intelligence
Author: Saurav Korde
Date: 2026-03-13
Goal: Create cleaned analytical views for downstream ML and dashboarding. 
Action: Strip currency symbols, cast data types, and standardize formats.
*/

-- =======================================================
-- 1. Create Clean Transactions View
-- =======================================================
DROP VIEW IF EXISTS v_transactions_clean;

CREATE VIEW v_transactions_clean AS
SELECT 
    user_id,
    card_index,
    year,
    month,
    day,
    time,
    -- Keep the original for auditing
    amount AS amount_raw, 
    -- The Magic: Replace the '$' with nothing, then cast the text to a Decimal number
    CAST(REPLACE(amount, '$', '') AS DECIMAL(10,2)) AS amount_numeric,
    use_chip,
    merchant_name,
    merchant_city,
    merchant_state,
    zip,
    mcc,
    errors,
    is_fraud
FROM transactions;

-- Verify the View works side-by-side
SELECT amount_raw, amount_numeric FROM v_transactions_clean LIMIT 5;

-- =======================================================
-- 2. Create Clean Users View
-- =======================================================
DROP VIEW IF EXISTS v_users_clean;

CREATE VIEW v_users_clean AS
SELECT 
    person,
    current_age,
    retirement_age,
    birth_year,
    birth_month,
    gender,
    address,
    apartment,
    city,
    state,
    zipcode,
    latitude,
    longitude,
    -- Clean the financial columns
    CAST(REPLACE(per_capita_income_zipcode, '$', '') AS DECIMAL(10,2)) AS per_capita_income_numeric,
    CAST(REPLACE(yearly_income, '$', '') AS DECIMAL(10,2)) AS yearly_income_numeric,
    CAST(REPLACE(total_debt, '$', '') AS DECIMAL(10,2)) AS total_debt_numeric,
    fico_score,
    num_credit_cards
FROM users;

-- =======================================================
-- 3. Create Clean Cards View
-- =======================================================
DROP VIEW IF EXISTS v_cards_clean;

CREATE VIEW v_cards_clean AS
SELECT 
    user_id,
    card_index,
    card_brand,
    card_type,
    card_number,
    expires,
    cvv,
    has_chip,
    num_cards_issued,
    -- Clean the credit limit
    CAST(REPLACE(credit_limit, '$', '') AS DECIMAL(10,2)) AS credit_limit_numeric,
    acct_open_date,
    year_pin_last_changed,
    card_on_dark_web
FROM cards;