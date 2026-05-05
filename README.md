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

I built an analytical dataset in SQL using JOINs, CTEs, and aggregations, and calculated key business metrics such as revenue growth, average order value, returning customer rate, delivery delay rate, and review score distribution.

I then segmented customers into new and returning, analyzed the impact of delivery on customer satisfaction, and performed deeper retention analysis, including orders per customer distribution, revenue contribution of returning users, retention by category, and cross-category behavior.

To ensure reliability, I also validated customer tracking consistency. All results were visualized in an interactive Power BI dashboard.

---

## Key Insights

Customer retention is extremely low at around 3%, with approximately 97% of customers making only one purchase. Returning users contribute only about 5.8% of total revenue.

Delivery performance has a strong impact on customer satisfaction. On-time orders have an average rating of 4.2, while delayed orders drop to 2.6. However, delivery does not explain low retention.

The business experienced rapid growth in 2017, followed by a plateau in 2018. At the same time, most high-revenue categories show low repeat purchase rates, typically between 1–3%.

This indicates that the business relies primarily on new customers and one-time purchases rather than building a returning customer base.

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
