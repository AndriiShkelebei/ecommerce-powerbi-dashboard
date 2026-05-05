# E-commerce Customer Retention & Delivery Impact

## Problem

E-commerce growth depends on both customer acquisition and retention.  
This project investigates why customer retention is extremely low (~3%) and evaluates whether delivery performance is a key driver of customer satisfaction and repeat purchases.

---

## Data

Dataset: Brazilian E-Commerce Public Dataset by Olist (Kaggle)  
Period: Jan 2017 – Aug 2018  
Size: ~100K orders, customers, payments, reviews  

Data adjustments:
- Removed early low-volume months  
- Excluded incomplete late months  

---

## Approach

I approached this project as a real business case, starting from identifying the problem and testing multiple hypotheses.

Steps:
Built analytical dataset using SQL (JOINs, CTEs, aggregations)
Calculated core business KPIs:
Revenue & Monthly Growth %
Average Order Value (AOV)
Returning Customer Rate
Delivery Delay Rate
Review Score distribution
Segmented customers (new vs returning)
Analyzed delivery impact on customer satisfaction
Performed deeper retention analysis:
Orders per customer distribution
Revenue contribution by returning customers
Retention by product category
Cross-category purchase behavior
Data validation (customer tracking consistency)
Built an interactive Power BI dashboard

---

## Key Insights

 **Customer retention is extremely low (~3%)**
 **~97% of customers make only one purchase**
 **Returning customers generate only ~5.8% of revenue**

### Delivery Impact
 Delayed orders: **~2.6 avg rating**
 On-time orders: **~4.2 avg rating**

→ Delivery strongly affects customer satisfaction  
→ But does NOT explain low retention

### Growth Pattern
 Rapid growth in 2017
 Plateau in 2018 (~6000–7000 customers/month)

### Category Analysis
 Most high-revenue categories have **low repeat purchase rates (1–3%)**
 High-retention categories do not generate significant revenue

---

## Key Finding

Low retention is **not caused by delivery issues or tracking errors**.

It reflects real customer behavior and a business model heavily dependent on **one-time purchases and continuous acquisition of new customers**.

This creates a **non-scalable growth model** — once new customer acquisition slows down, growth stagnates.

---

## Business Impact

 Heavy dependence on new customers increases marketing costs
 Low retention limits long-term revenue growth
 Growth becomes unstable and difficult to scale
 Customer experience issues (e.g. delivery delays) reduce satisfaction but are not the root cause

---

## Recommendations

 Improve post-purchase engagement (email, promotions, loyalty programs)
 Increase cross-category exposure to encourage repeat purchases
 Focus on categories with higher repeat potential
 Continue improving delivery performance to maintain customer satisfaction
 Track retention as a core business KPI

---

## Dashboard

![Dashboard](screenshots/overview_dashboard.png)

The dashboard includes:
 Revenue, Orders, Customers, AOV  
 Revenue trend & growth %  
 Returning customer rate  
 Delivery delay rate  
 Review score by delivery status  
 Category performance  

---

## SQL Analysis

SQL scripts used for data preparation and analysis:

 `01_create_analysis_table.sql`  
  → builds the main analytical dataset  

 `02_business_analysis_queries.sql`  
  → core business metrics (revenue, customers, delivery, reviews)  

 `03_retention_analysis.sql`  
  → advanced retention and customer behavior analysis  

---

## 🛠 Tools

- SQL (PostgreSQL)
- Power BI

---

## 📁 Project Structure
```
├── screenshots/
│ └── overview_dashboard.png
├── sql/
│ ├── 01_create_analysis_table.sql
│ ├── 02_business_analysis_queries.sql
│ └── README.md
├── customer_retention_analysis.pbix
├── README.md
├── LICENSE
└── .gitignore
```
---

## 👤 Author

**Andrii Shkelebei**
