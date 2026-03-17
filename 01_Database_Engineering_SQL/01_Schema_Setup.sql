/*
Project: Fintech Transaction Intelligence
Author: Saurav Korde
Date: 2026-03-13
Goal: Establish the core relational landing zone. Tables must exactly mirror the raw CSVs.
*/

-- =======================================================
-- 1. Create Users Dimension Landing Table
-- =======================================================
DROP TABLE IF EXISTS users CASCADE;
CREATE TABLE users (
    person VARCHAR(150),
    current_age INT,
    retirement_age INT,
    birth_year INT,
    birth_month INT,
    gender VARCHAR(10),
    address VARCHAR(255),
    apartment VARCHAR(100), -- The hidden column!
    city VARCHAR(100),
    state VARCHAR(50),
    zipcode VARCHAR(20),
    latitude VARCHAR(50),
    longitude VARCHAR(50),
    per_capita_income_zipcode VARCHAR(50),
    yearly_income VARCHAR(50),
    total_debt VARCHAR(50),
    fico_score INT,
    num_credit_cards INT
);

-- =======================================================
-- 2. Create Cards Dimension Landing Table
-- =======================================================
DROP TABLE IF EXISTS cards CASCADE;
CREATE TABLE cards (
    user_id INT, -- Removed the SERIAL ID. Mirroring CSV exactly.
    card_index INT,
    card_brand VARCHAR(50),
    card_type VARCHAR(50),
    card_number VARCHAR(50),
    expires VARCHAR(20),
    cvv VARCHAR(10),
    has_chip VARCHAR(5),
    num_cards_issued INT,
    credit_limit VARCHAR(50),
    acct_open_date VARCHAR(20),
    year_pin_last_changed INT,
    card_on_dark_web VARCHAR(5)
);

-- =======================================================
-- 3. Create Transactions Fact Landing Table
-- =======================================================
DROP TABLE IF EXISTS transactions CASCADE;
CREATE TABLE transactions (
    user_id INT, -- Removed the SERIAL ID. Mirroring CSV exactly.
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