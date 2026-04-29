# 📊 E-commerce Performance Dashboard (SQL + Power BI)

## 🔍 Overview

This project analyzes a real-world e-commerce dataset (Olist) using **SQL and Power BI**.

It simulates a real data analyst workflow:

* data extraction and transformation in SQL
* creation of an analysis-ready dataset
* development of an interactive dashboard for business insights

This project complements a separate Excel-based analysis, demonstrating multiple approaches to the same dataset.

---

## 🎯 Objectives

* Analyze overall business performance
* Track revenue trends over time
* Evaluate customer behavior
* Identify top-performing product categories
* Understand how delivery impacts customer satisfaction

---

## 🛠 Tools & Technologies

* **PostgreSQL** — data preparation
* **SQL (CTE, JOINs, aggregations)** — data transformation
* **Power BI** — data visualization and dashboarding

---

## 🧱 Data Preparation (SQL)

Two analytical tables were created:

### `analysis_table`

Main dataset used for KPIs and trend analysis:

* revenue (aggregated from order_items)
* payment_value
* review_score (average)
* delivery_status (On Time / Delayed)
* order_month

### `category_analysis_table`

Used for category-level analysis:

* revenue by product category
* supports Top 10 categories visualization

Data was transformed using joins, aggregations, and CTEs to create a flat structure optimized for BI reporting.

---

## 📈 Dashboard Features

* **KPI Cards**

  * Total Revenue
  * Total Orders
  * Total Customers
  * Average Order Value (AOV)

* **Revenue Trend**

  * Monthly revenue growth

* **Customer Satisfaction**

  * Review score comparison:

    * On Time vs Delayed deliveries

* **Top 10 Categories**

  * Revenue distribution by category

* **Interactive Slicer**

  * Filter data by month

* **Custom Tooltip**

  * Displays additional metrics on hover (mini-dashboard experience)

---

## 📊 Key Insights

* Revenue shows consistent growth with peaks in late 2017
* A small number of categories generate the majority of revenue (Pareto effect)
* Delivery delays significantly reduce customer satisfaction
* Customer retention is very low — most users make only one purchase

---

## 💡 Recommendations

* Improve delivery performance to increase customer satisfaction
* Implement retention strategies (loyalty programs, remarketing)
* Focus on high-performing categories for growth
* Monitor underperforming sellers

---

## 📂 Project Structure

```text id="e7l4ap"
ecommerce-powerbi-dashboard/
├── ecommerce_dashboard.pbix
├── README.md
├── screenshots/
│   └── dashboard.png
└── sql/
    └── create_analysis_table.sql
```

---

## 🖼 Dashboard Preview

![Dashboard](screenshots/dashboard.png)

---

## 🚀 How to Use

1. Open `ecommerce_dashboard.pbix` in Power BI Desktop
2. Connect to your PostgreSQL database (or use imported data)
3. Interact with slicers, filters, and tooltips

---

## 📌 Notes

This project demonstrates a full analytics workflow: from SQL data modeling to interactive BI dashboard development.

---

## 👤 Author

Andrii Shkelebei
Aspiring Data Analyst focused on SQL, Power BI, and Business Intelligence
