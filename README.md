# E-commerce Customer Retention & Delivery Impact

## About the project

This is my data analytics project based on the Brazilian E-Commerce Public Dataset by Olist.

I chose this dataset because it contains real e-commerce data: orders, customers, payments, delivery information, products, and reviews. At first, I wanted to analyze general business performance, but during the work I noticed that customer retention was very low. Because of that, I focused more on repeat purchases, delivery performance, and customer satisfaction.

The project includes SQL analysis and a Power BI dashboard.

## Dataset

The dataset was taken from Kaggle: Brazilian E-Commerce Public Dataset by Olist. It contains around 100,000 orders and covers the period from January 2017 to August 2018.

For the analysis, I used order, customer, payment, delivery, product, and review data. I also removed early low-volume months and incomplete late months, because they could distort revenue trends and growth calculations.

## Questions I wanted to answer

In this project, I wanted to understand how the business performs over time and why customers rarely come back after the first purchase.

The main questions were: what is the customer retention rate, how many customers buy more than once, how much revenue comes from returning customers, how delivery delays affect review scores, and which product categories generate the most revenue.

## Tools

I used SQL PostgreSQL for data preparation and analysis. Power BI was used for building the dashboard and visualizing the main KPIs. GitHub was used to store and present the project.

## What I did

First, I prepared the data in SQL. I joined several tables from the dataset and created an analytical table for further analysis. I aggregated revenue and payments by order, added customer information, review scores, and delivery dates.

I also created a delivery status column. If the actual delivery date was later than the estimated delivery date, the order was marked as delayed. This helped me compare customer reviews for on-time and delayed deliveries.

After preparing the data, I calculated the main business metrics: revenue, number of orders, number of customers, average order value, monthly revenue growth, returning customer rate, delivery delay rate, and average review score.

Then I analyzed customer retention more deeply. I checked how many customers made more than one purchase, how much revenue returning customers generated, and whether delivery delays could explain the low retention rate.

Finally, I created a Power BI dashboard to show the main results in a clear visual format.

## Key findings

Customer retention was very low. Only around 3% of customers made more than one purchase. This means that most customers bought only once, and the business depends mainly on attracting new customers.

Returning customers also generated only a small part of total revenue — around 5.8%. This confirms that repeat purchases did not have a strong impact on overall revenue in this dataset.

Delivery delays had a clear negative effect on customer reviews. On-time orders had an average review score of around 4.2, while delayed orders had an average score of around 2.6. This shows that delivery performance is strongly connected with customer satisfaction.

However, delivery delays do not fully explain the low retention rate. The retention problem seems to be broader. It may be connected with customer behavior, product categories, and the fact that many purchases in this dataset are one-time purchases.

Revenue grew strongly during 2017, but in 2018 it became more stable at around $1M per month. This may mean that further growth becomes harder when the business mostly relies on new customers instead of repeat buyers.

## Dashboard

The Power BI dashboard includes the main KPIs and visualizations: revenue, orders, customers, average order value, revenue trend, monthly revenue growth, returning customer rate, delivery delay rate, review score by delivery status, and top product categories by revenue.

![Dashboard](screenshots/overview_dashboard.png)

## SQL files

The SQL folder contains the main scripts used in the project.

`01_create_analysis_table.sql` creates the main analytical table for the dashboard and analysis.

`02_business_analysis_queries.sql` includes SQL queries for business metrics such as revenue growth, customer retention, delivery delay rate, review score analysis, and product category performance.

`03_retention_analysis.sql` includes deeper analysis of customer retention, returning customers, and revenue contribution from repeat purchases.

## Project structure
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
Conclusion

The main problem I found in this dataset is very low customer retention. Most customers bought only once, and returning customers generated only a small share of total revenue.

Delivery delays also had a strong negative effect on customer satisfaction, because delayed orders received much lower review scores. However, delivery delays are probably not the only reason for low retention.

From a business point of view, the company should track retention more carefully, improve post-purchase communication, and test ways to encourage repeat purchases, especially in categories where customers are more likely to buy again.
---

## 👤 Author

**Andrii Shkelebei**
