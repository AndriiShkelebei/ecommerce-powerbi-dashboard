# E-commerce Customer Retention & Delivery Impact

## Overview
This project analyzes customer behavior, revenue trends, and delivery performance using the Olist Brazilian e-commerce dataset.

The focus is on understanding why customer retention is low and how delivery performance affects customer satisfaction.

---

## Key Findings

 Customer retention is very low (~3%)
 Delayed deliveries account for ~8% of orders
 Average review score:
   On-time delivery: ~4.2
   Delayed delivery: ~2.6
 Revenue grew rapidly in 2017 and stabilized in 2018 (~$1M/month)

Conclusion: delivery delays are strongly associated with lower customer satisfaction and likely contribute to low retention.

---

## Dashboard

The dashboard includes:

 Revenue, Orders, Customers, AOV
 Revenue trend over time
 Revenue growth (selected period)
 Delivery delay rate
 Customer retention (new vs returning)
 Review score by delivery status
 Top product categories by revenue

![Dashboard](screenshots/overview_dashboard.png)

---

## Data

Dataset: Olist Brazilian E-commerce Dataset (Kaggle)

Scope adjustments:
- Early low-volume months removed
- Late incomplete months excluded  
- Analysis period: Jan 2017 – Aug 2018

---

## SQL

SQL scripts are used to prepare and analyze the data:

 `01_create_analysis_table.sql` — builds the main dataset
 `02_business_analysis_queries.sql` — business metrics and analysis

Key calculations:
 Monthly revenue and growth
 Retention rate
 Delivery delay rate
 Category revenue share
 Review score analysis

---

## Tools

 SQL (PostgreSQL)
 Power BI

---

## Project Structure
screenshots/
overview_dashboard.png

sql/
01_create_analysis_table.sql
02_business_analysis_queries.sql

customer_retention_analysis.pbix
README.md

---

## Author

Andrii Shkelebei
