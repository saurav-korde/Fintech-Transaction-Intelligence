# Enterprise Fraud Intelligence Platform: End-to-End Data Pipeline & Analytics

![Power BI](https://img.shields.io/badge/Power_BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
![DAX](https://img.shields.io/badge/DAX-0078D4?style=for-the-badge&logo=microsoft&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)

## 📌 Executive Summary
This project demonstrates a full-stack data analytics architecture, processing **48.7 million raw credit card transactions** to uncover systemic fraud vulnerabilities. Designed for a conceptual financial institution ("Vertex Financial"), the platform bridges the gap between backend data engineering and frontend executive intelligence.

The architecture is split into two distinct phases: 
1. **The Engine (Backend):** A PostgreSQL ETL pipeline that ingests, cleans, and normalizes 2GB+ of raw CSV data into a highly efficient relational database.
2. **The Command Center (Frontend):** A high-performance Power BI dashboard utilizing a custom Star Schema and advanced DAX to provide instant, cross-filtered insights into geographical, temporal, and categorical fraud trends.

---

## 🏗️ System Architecture & Workflow

### Phase 1: Data Engineering & ETL Pipeline (PostgreSQL)
*See the [`01_Data_Engineering_SQL`](./01_Data_Engineering_SQL) directory for full SQL scripts and schema documentation.*

* **Massive Data Ingestion:** Successfully loaded and processed a 48,773,800-row transactional dataset, bypassing standard memory limitations using optimized SQL `COPY` commands and flat-file chunking.
* **Database Normalization:** Engineered a robust relational model, breaking down flat, redundant data into a central Fact Table (`fact_transactions_clean`) and isolated Dimension Tables (`dim_users_clean`, `dim_cards_clean`).
* **Data Integrity & Cleaning:** Authored advanced SQL scripts to strip string characters from financial columns (e.g., converting `$1,200.50` to exact numerics), handle null values, and forge composite primary keys to guarantee 1-to-Many relational integrity.

### Phase 2: Business Intelligence & UI Design (Power BI)
*See the [`02_Business_Intelligence_PowerBI`](./02_Business_Intelligence_PowerBI) directory for the `.pbit` template and DAX dictionary.*

* **Star Schema Optimization:** Imported the cleaned PostgreSQL views into Power BI, manually architecting a perfect Star Schema. Leveraged the VertiPaq engine to compress the 48.7M rows, enabling sub-second query responses during heavy dashboard cross-filtering.
* **Advanced DAX Logic:** Developed custom financial measures including `Total Processed Volume`, `Fraud Loss Volume`, and a dynamic `Fraud Loss Rate %` to provide normalized risk assessments rather than raw row counts.
* **On-the-Fly Data Translation:** Authored a DAX `SWITCH` engine to translate raw ISO Merchant Category Codes (e.g., 5311, 4411) into executive-readable labels ("Department Stores", "Cruise Lines") directly within the visual layer.
* **Enterprise UI/UX ("Vertex Financial"):** Designed a premium, dark-mode/inverted-header Command Center. Deployed the "Rule of Three" for slicer controls and established a strict Z-pattern visual hierarchy for immediate stakeholder comprehension.

---

## 📊 The Vertex Financial Command Center
*(Interactive Power BI Dashboard Preview)*

![Vertex Financial Dashboard Preview](02_Business_Intelligence_PowerBI/assets/dashboard_preview.png)

## 💡 Key Business Insights Discovered
1. **The Vulnerability Peak:** Time-series analysis revealed immense volatility in the fraud landscape, with localized loss spikes severely concentrated around the 2011 and 2015 financial years.
2. **Geographical Concentration:** Risk is not evenly distributed. A Top 10 regional drill-down identified **California ($0.80M)** and **Texas ($0.61M)** as the absolute highest-density targets for financial exploitation.
3. **Primary Merchant Targets:** Part-to-whole categorical analysis exposed that **Department Stores** and **Cruise Lines & Travel** absorb over 55% of the total fraud impact, heavily outweighing standard online retail or grocery sectors.

---

## ⚙️ How to Run This Project

### 1. Rebuild the Database (Phase 1)
To recreate the backend engine:
1. Install PostgreSQL and pgAdmin4.
2. Execute the `01_schema_setup.sql` file to build the empty tables.
3. Run the `02_data_cleaning.sql` to normalize the imported data.

### 2. Launch the Dashboard (Phase 2)
To bypass GitHub's 100MB file limit on `.pbix` files, this repository uses a lightweight Power BI Template (`.pbit`).
1. Open the `Fintech_Fraud_Intelligence_Model.pbit` file in Power BI Desktop.
2. The template contains all DAX formulas, UI layouts, and the Star Schema. *Note: You will need to connect it to your local PostgreSQL instance to repopulate the 48.7M rows of data.*

---
*Architected and Developed by Saurav Korde.*