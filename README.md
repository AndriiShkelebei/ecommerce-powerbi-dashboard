# E-commerce Customer Retention & Delivery Impact

## About the project

This is a data analytics project based on the Brazilian E-Commerce Public Dataset by Olist.

I worked with this dataset to understand customer behavior, revenue trends, delivery performance, and customer reviews. During the analysis, I noticed that customer retention is very low, so I focused more on repeat purchases and possible reasons why customers do not come back.

The project includes SQL analysis and a Power BI dashboard.

---

## Dataset

Dataset: Brazilian E-Commerce Public Dataset by Olist  
Source: Kaggle  
Period: January 2017 – August 2018  
Size: around 100,000 orders

The dataset includes information about:

- orders
- customers
- payments
- products
- delivery dates
- reviews

I excluded early low-volume months and incomplete late months to make the analysis more stable.

---

## Main questions

In this project, I tried to answer these questions:

- How much revenue does the business generate over time?
- What is the customer retention rate?
- How many customers buy more than once?
- How many orders are delivered late?
- How do delivery delays affect customer reviews?
- Which product categories generate the most revenue?
- Are delivery problems the main reason for low retention?

---

## Tools

- SQL PostgreSQL
- Power BI
- GitHub

---

## What I did

First, I prepared the data in SQL. I joined several tables, aggregated revenue and payments by order, added review scores, and created delivery status based on estimated and actual delivery dates.

Then I calculated the main business metrics:

- revenue
- number of orders
- number of customers
- average order value
- monthly revenue growth
- returning customer rate
- delivery delay rate
- average review score

After that, I analyzed customer retention more deeply. I checked how many customers made repeat purchases, how much revenue returning customers generated, and whether delayed delivery could explain low retention.

Finally, I created a Power BI dashboard to show the main results visually.

---

## Key findings

### Customer retention is very low

Only around 3% of customers made more than one purchase.

This means that most customers bought only once. Because of this, the business depends mostly on new customers.

### Returning customers generate a small part of revenue

Returning customers generated only around 5.8% of total revenue.

This confirms that repeat purchases do not have a big impact on total revenue in this dataset.

### Delivery delays affect reviews

Delayed delivery has a clear negative impact on customer reviews.

Average review score:

- On-time delivery: around 4.2
- Delayed delivery: around 2.6

So customers who received their orders late were much less satisfied.

### Delivery is not the only reason for low retention

Even though delayed delivery lowers customer satisfaction, it does not fully explain why retention is so low.

The problem seems to be broader. It may be connected with customer behavior, product categories, and the fact that many purchases in this dataset are one-time purchases.

### Revenue growth slowed down

Revenue grew strongly during 2017, but in 2018 it became more stable at around $1M per month.

This may mean that further growth is harder when the business mostly relies on attracting new customers instead of repeat buyers.

---

## Dashboard

The dashboard shows:

- revenue
- orders
- customers
- average order value
- revenue trend
- monthly revenue growth
- returning customer rate
- delivery delay rate
- review score by delivery status
- top product categories by revenue

![Dashboard](screenshots/overview_dashboard.png)

---

## SQL files

The SQL folder contains scripts used for data preparation and analysis:

- `01_create_analysis_table.sql` — creates the main analysis table
- `02_business_analysis_queries.sql` — calculates business metrics
- `03_retention_analysis.sql` — analyzes customer retention in more detail

The SQL analysis includes:

- joining tables
- creating aggregated tables
- calculating revenue
- calculating monthly growth
- calculating retention rate
- analyzing delivery delays
- comparing review scores
- analyzing product categories

---

## Project Structure
```
├── screenshots/
│ └── overview_dashboard.png
├── sql/
│ ├── 01_create_analysis_table.sql
│ ├── 02_business_analysis_queries.sql
│ ├── 03_retention_analysis.sql
│ └── README.md
├── ecommerce_dashboard.pbix
├── README.md
├── LICENSE
└── .gitignore
```
---

## 👤 Author

**Andrii Shkelebei**
