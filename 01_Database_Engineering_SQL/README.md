# 🛡️ Corporate Shield: Database Engineering & SQL Analytics

> **Scale:** 48.7 Million Rows | **Size:** 2.35 GB | **Engine:** PostgreSQL

## ⚙️ The Objective
Processing nearly 50 million rows of financial transaction data will crash standard local environments like Python/Pandas or Excel. The objective of this phase was to architect a high-performance, enterprise-grade relational database on a local machine to safely ingest, clean, and analyze this massive payload using a strict ELT (Extract, Load, Transform) pipeline.

## 🏗️ Architecture & Pipeline Flow

The backend infrastructure is executed in four distinct stages:

### 1. The Landing Zone (`01_Schema_Setup.sql`)
Established the foundational relational schema (`users`, `cards`, `transactions`). To prevent data loss or type-mismatch failures during the heavy load phase, the tables were explicitly designed as 1-to-1 mirrors of the raw CSV structures.

### 2. High-Speed Data Ingestion (`02_Data_Ingestion.sql`)
Utilized PostgreSQL's highly optimized `COPY` command to bypass local RAM constraints. 
* **Performance Metric:** Streamed a 2.35 GB payload directly to the disk, successfully ingesting **48,773,800 rows** in minutes.

### 3. The Analytics Zone (`03_Data_Transformation.sql`)
Engineered virtual SQL `VIEW`s to clean and standardize the data on the fly. 
* **The Architecture:** Stripped string artifacts (like `$` symbols) and cast financial data to strict `DECIMAL(10,2)` types for heavy mathematical aggregations. This provided clean data for downstream analytics without mutating or risking the underlying 48.7 million rows of raw data.

### 4. Business Intelligence Extraction (`04_Analytics_Queries.sql`)
Executed a suite of exploratory data analysis (EDA) queries to extract immediate fraud intelligence from the clean views.
* **Calculated Baseline Fraud Rate:** Determined the exact percentage of fraudulent vs. legitimate transactions across the entire dataset.
* **Merchant Volume Aggregations:** Identified the top 5 processing entities by total financial volume.
* **Risk Analysis:** Evaluated fraud frequency by transaction method (Chip vs. Online).
* **Temporal Patterns:** Mapped the peak hours for fraudulent activity to identify vulnerability windows.

## 🛠️ Tech Stack & Methodologies
* **Core Engine:** PostgreSQL (Local)
* **IDE/Client:** DBeaver
* **Key Techniques:** ELT Architecture, Bulk Disk Ingestion (`COPY`), Virtual Views, Type Casting, Advanced Aggregations, Data Anonymization Handling.