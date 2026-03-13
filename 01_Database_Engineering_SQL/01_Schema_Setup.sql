/*
Project: Fintech Transaction Intelligence
Author: Saurav Korde
Date: 2026-03-12
Goal: Establish the core relational schema in the isolated corporate_shield_db vault.
*/

-- =======================================================
-- 1. Create Users Dimension Landing Table
-- =======================================================
-- Step A: Audit
DROP TABLE IF EXISTS users CASCADE;

-- Step B: The Fix
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    current_age INT,
    retirement_age INT,
    birth_year INT,
    birth_month INT,
    gender VARCHAR(10),
    address VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(50),
    zipcode VARCHAR(20),
    latitude DECIMAL(10, 6),
    longitude DECIMAL(10, 6),
    per_capita_income_zipcode VARCHAR(50),
    yearly_income VARCHAR(50),
    total_debt VARCHAR(50),
    credit_score INT,
    num_credit_cards INT
);

-- Step C: Verify
SELECT table_name FROM information_schema.tables WHERE table_name = 'users';

-- =======================================================
-- 2. Create Cards Dimension Landing Table
-- =======================================================
-- Step A: Audit
DROP TABLE IF EXISTS cards CASCADE;

-- Step B: The Fix
CREATE TABLE cards (
    card_id SERIAL PRIMARY KEY, 
    user_id INT REFERENCES users(user_id),
    card_index INT,
    card_brand VARCHAR(50),
    card_type VARCHAR(50),
    card_number VARCHAR(50),
    expires_month INT,
    expires_year INT,
    has_chip VARCHAR(5),
    num_cards_issued INT,
    credit_limit VARCHAR(50),
    acct_open_date VARCHAR(20),
    year_pin_last_changed INT,
    card_on_dark_web VARCHAR(5)
);

-- Step C: Verify
SELECT table_name FROM information_schema.tables WHERE table_name = 'cards';

-- =======================================================
-- 3. Create Transactions Fact Landing Table
-- =======================================================
-- Step A: Audit
DROP TABLE IF EXISTS transactions CASCADE;

-- Step B: The Fix
CREATE TABLE transactions (
    transaction_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    card_index INT,
    year INT,
    month INT,
    day INT,
    time VARCHAR(20),
    amount VARCHAR(50),
    use_chip VARCHAR(50),
    merchant_name VARCHAR(150),
    merchant_city VARCHAR(100),
    merchant_state VARCHAR(50),
    zip VARCHAR(20),
    mcc VARCHAR(20),
    errors VARCHAR(100),
    is_fraud VARCHAR(10)
);

-- Step C: Verify
SELECT table_name FROM information_schema.tables WHERE table_name = 'transactions';