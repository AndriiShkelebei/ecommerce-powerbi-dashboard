-- =========================================
-- Retention Analysis Queries
-- Dataset: Brazilian E-Commerce Public Dataset by Olist
-- Purpose: Customer retention, returning customers, category repeat behavior,
--          delivery impact, and data quality validation
-- =========================================


-- =========================================
-- 1. Customer Segmentation: New vs Returning
-- =========================================
WITH customer_orders AS (
    SELECT 
        customer_unique_id,
        COUNT(DISTINCT order_id) AS total_orders
    FROM analysis_table
    GROUP BY customer_unique_id
),

customer_segment AS (
    SELECT
        customer_unique_id,
        CASE 
            WHEN total_orders = 1 THEN 'New'
            ELSE 'Returning'
        END AS segment
    FROM customer_orders
)

SELECT
    segment,
    COUNT(DISTINCT customer_unique_id) AS customers,
    ROUND(
        100.0 * COUNT(DISTINCT customer_unique_id)
        / SUM(COUNT(DISTINCT customer_unique_id)) OVER (),
        2
    ) AS customer_share_percent
FROM customer_segment
GROUP BY segment
ORDER BY customers DESC;


-- =========================================
-- 2. Revenue Contribution: New vs Returning Customers
-- =========================================
WITH customer_orders AS (
    SELECT 
        customer_unique_id,
        COUNT(DISTINCT order_id) AS total_orders
    FROM analysis_table
    GROUP BY customer_unique_id
),

customer_segment AS (
    SELECT
        customer_unique_id,
        CASE 
            WHEN total_orders = 1 THEN 'New'
            ELSE 'Returning'
        END AS segment
    FROM customer_orders
)

SELECT
    cs.segment,
    ROUND(SUM(a.revenue), 2) AS total_revenue,
    ROUND(
        100.0 * SUM(a.revenue)
        / SUM(SUM(a.revenue)) OVER (),
        2
    ) AS revenue_share_percent
FROM analysis_table a
JOIN customer_segment cs
    ON a.customer_unique_id = cs.customer_unique_id
GROUP BY cs.segment
ORDER BY total_revenue DESC;


-- =========================================
-- 3. Orders per Customer Distribution
-- Purpose: Check whether low retention is real customer behavior
--          or a possible tracking/data issue
-- =========================================
WITH customer_orders AS (
    SELECT
        customer_unique_id,
        COUNT(DISTINCT order_id) AS orders_per_customer
    FROM analysis_table
    GROUP BY customer_unique_id
)

SELECT
    orders_per_customer,
    COUNT(*) AS customers
FROM customer_orders
GROUP BY orders_per_customer
ORDER BY orders_per_customer;


-- =========================================
-- 4. Average Time Between Repeat Orders
-- Purpose: Understand how long returning customers usually take
--          before placing another order
-- =========================================
WITH customer_orders AS (
    SELECT
        customer_unique_id,
        order_id,
        order_purchase_timestamp,
        LAG(order_purchase_timestamp) OVER (
            PARTITION BY customer_unique_id
            ORDER BY order_purchase_timestamp
        ) AS previous_order_timestamp
    FROM analysis_table
)

SELECT
    AVG(order_purchase_timestamp - previous_order_timestamp) AS avg_time_between_orders
FROM customer_orders
WHERE previous_order_timestamp IS NOT NULL;


-- =========================================
-- 5. Retention vs Delivery Status
-- Purpose: Check whether delayed delivery explains low retention
-- =========================================
WITH customer_orders AS (
    SELECT 
        customer_unique_id,
        COUNT(DISTINCT order_id) AS total_orders
    FROM analysis_table
    GROUP BY customer_unique_id
),

customer_segment AS (
    SELECT
        customer_unique_id,
        CASE 
            WHEN total_orders = 1 THEN 'New'
            ELSE 'Returning'
        END AS segment
    FROM customer_orders
)

SELECT
    a.delivery_status,
    cs.segment,
    COUNT(DISTINCT a.customer_unique_id) AS customers
FROM analysis_table a
JOIN customer_segment cs
    ON a.customer_unique_id = cs.customer_unique_id
GROUP BY 
    a.delivery_status,
    cs.segment
ORDER BY 
    a.delivery_status,
    cs.segment;


-- =========================================
-- 6. Average Review Score by Delivery Status
-- Purpose: Check how delivery performance affects customer satisfaction
-- =========================================
SELECT
    delivery_status,
    ROUND(AVG(review_score), 2) AS avg_review_score
FROM analysis_table
WHERE review_score IS NOT NULL
GROUP BY delivery_status
ORDER BY avg_review_score DESC;


-- =========================================
-- 7. Retention by Product Category
-- Purpose: Identify categories with higher repeat purchase behavior
-- =========================================
WITH customer_category_orders AS (
    SELECT
        a.customer_unique_id,
        p.product_category_name,
        COUNT(DISTINCT a.order_id) AS orders_count
    FROM analysis_table a
    JOIN order_items oi
        ON a.order_id = oi.order_id
    JOIN products p
        ON oi.product_id = p.product_id
    WHERE p.product_category_name IS NOT NULL
    GROUP BY
        a.customer_unique_id,
        p.product_category_name
),

category_retention AS (
    SELECT
        product_category_name,
        COUNT(DISTINCT customer_unique_id) AS total_customers,
        COUNT(DISTINCT CASE 
            WHEN orders_count > 1 THEN customer_unique_id
        END) AS returning_customers
    FROM customer_category_orders
    GROUP BY product_category_name
)

SELECT
    product_category_name,
    total_customers,
    returning_customers,
    ROUND(
        100.0 * returning_customers / total_customers,
        2
    ) AS retention_rate_percent
FROM category_retention
WHERE total_customers >= 100
ORDER BY retention_rate_percent DESC;


-- =========================================
-- 8. Category Retention with Revenue
-- Purpose: Check whether high-retention categories also generate strong revenue
-- =========================================
WITH customer_category_orders AS (
    SELECT
        a.customer_unique_id,
        p.product_category_name,
        COUNT(DISTINCT a.order_id) AS orders_count,
        SUM(a.revenue) AS customer_category_revenue
    FROM analysis_table a
    JOIN order_items oi
        ON a.order_id = oi.order_id
    JOIN products p
        ON oi.product_id = p.product_id
    WHERE p.product_category_name IS NOT NULL
    GROUP BY
        a.customer_unique_id,
        p.product_category_name
),

category_metrics AS (
    SELECT
        product_category_name,
        COUNT(DISTINCT customer_unique_id) AS total_customers,
        COUNT(DISTINCT CASE 
            WHEN orders_count > 1 THEN customer_unique_id
        END) AS returning_customers,
        SUM(customer_category_revenue) AS total_revenue
    FROM customer_category_orders
    GROUP BY product_category_name
)

SELECT
    product_category_name,
    total_customers,
    returning_customers,
    ROUND(
        100.0 * returning_customers / total_customers,
        2
    ) AS retention_rate_percent,
    ROUND(total_revenue, 2) AS total_revenue
FROM category_metrics
WHERE total_customers >= 100
ORDER BY retention_rate_percent DESC, total_revenue DESC;


-- =========================================
-- 9. Cross-Category Purchase Behavior
-- Purpose: Check whether customers buy from multiple product categories
-- =========================================
WITH customer_categories AS (
    SELECT
        a.customer_unique_id,
        COUNT(DISTINCT p.product_category_name) AS category_count
    FROM analysis_table a
    JOIN order_items oi
        ON a.order_id = oi.order_id
    JOIN products p
        ON oi.product_id = p.product_id
    WHERE p.product_category_name IS NOT NULL
    GROUP BY a.customer_unique_id
)

SELECT
    category_count,
    COUNT(*) AS customers
FROM customer_categories
GROUP BY category_count
ORDER BY category_count;


-- =========================================
-- 10. Monthly Customer Trend
-- Purpose: Check whether customer acquisition is growing or plateauing
-- =========================================
SELECT
    DATE_TRUNC('month', order_purchase_timestamp) AS month,
    COUNT(DISTINCT customer_unique_id) AS customers
FROM analysis_table
GROUP BY DATE_TRUNC('month', order_purchase_timestamp)
ORDER BY month;


-- =========================================
-- 11. Average Order Value
-- Purpose: Check average revenue per order
-- =========================================
SELECT
    ROUND(AVG(revenue), 2) AS avg_order_value
FROM analysis_table
WHERE revenue IS NOT NULL;


-- =========================================
-- 12. Review Score Distribution
-- Purpose: Check overall customer satisfaction
-- =========================================
SELECT
    review_score,
    COUNT(*) AS orders
FROM analysis_table
WHERE review_score IS NOT NULL
GROUP BY review_score
ORDER BY review_score;


-- =========================================
-- 13. Data Validation: customer_unique_id with multiple customer_id
-- Purpose: Validate whether repeat customers can be tracked across orders
-- =========================================
SELECT
    customer_unique_id,
    COUNT(DISTINCT customer_id) AS customer_id_count
FROM customers
GROUP BY customer_unique_id
HAVING COUNT(DISTINCT customer_id) > 1
ORDER BY customer_id_count DESC;


-- =========================================
-- 14. Data Validation: customers with multiple zip codes
-- Purpose: Check possible inconsistencies in customer identification
-- =========================================
SELECT
    customer_unique_id,
    COUNT(DISTINCT customer_zip_code_prefix) AS zip_count
FROM customers
GROUP BY customer_unique_id
HAVING COUNT(DISTINCT customer_zip_code_prefix) > 1
ORDER BY zip_count DESC;
