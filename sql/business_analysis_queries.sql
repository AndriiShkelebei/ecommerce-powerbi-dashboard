-- =========================================
-- Business Analysis Queries
-- Dataset: Brazilian E-Commerce Public Dataset by Olist
-- Purpose: Revenue, customers, delivery and review analysis
-- =========================================


-- =========================================
-- 1. Monthly Revenue Growth (%)
-- Excludes incomplete early/late months
-- =========================================
WITH monthly_revenue AS (
    SELECT 
        DATE_TRUNC('month', o.order_purchase_timestamp) AS month,
        SUM(op.payment_value) AS revenue
    FROM orders o
    JOIN order_payments op 
        ON o.order_id = op.order_id
    WHERE DATE_TRUNC('month', o.order_purchase_timestamp) 
          BETWEEN '2017-01-01' AND '2018-08-01'
    GROUP BY month
)

SELECT
    month,
    revenue,
    LAG(revenue) OVER (ORDER BY month) AS previous_month_revenue,
    ROUND(
        100.0 * (revenue - LAG(revenue) OVER (ORDER BY month)) 
        / LAG(revenue) OVER (ORDER BY month),
        2
    ) AS revenue_growth_percent
FROM monthly_revenue
ORDER BY month;


-- =========================================
-- 2. Customer Retention Rate
-- Returning customers = customers with more than 1 order
-- =========================================
WITH customer_orders AS (
    SELECT 
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS total_orders
    FROM customers c
    JOIN orders o 
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
)

SELECT 
    COUNT(*) AS total_customers,
    SUM(CASE WHEN total_orders > 1 THEN 1 ELSE 0 END) AS returning_customers,
    ROUND(
        100.0 * SUM(CASE WHEN total_orders > 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS retention_rate_percent
FROM customer_orders;


-- =========================================
-- 3. New vs Returning Customers
-- =========================================
WITH customer_orders AS (
    SELECT 
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS total_orders
    FROM customers c
    JOIN orders o 
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
)

SELECT 
    CASE 
        WHEN total_orders = 1 THEN 'New Customer'
        ELSE 'Returning Customer'
    END AS customer_type,
    COUNT(*) AS customer_count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS customer_share_percent
FROM customer_orders
GROUP BY customer_type;


-- =========================================
-- 4. Delayed Delivery Rate
-- Delayed = delivered after estimated delivery date
-- =========================================
SELECT
    COUNT(*) AS delivered_orders,
    SUM(
        CASE 
            WHEN order_delivered_customer_date > order_estimated_delivery_date 
            THEN 1 ELSE 0 
        END
    ) AS delayed_orders,
    ROUND(
        100.0 * SUM(
            CASE 
                WHEN order_delivered_customer_date > order_estimated_delivery_date 
                THEN 1 ELSE 0 
            END
        ) / COUNT(*),
        2
    ) AS delayed_delivery_rate_percent
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;


-- =========================================
-- 5. Average Review Score by Delivery Status
-- =========================================
SELECT 
    CASE 
        WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date 
            THEN 'Delayed'
        ELSE 'On Time'
    END AS delivery_status,
    COUNT(*) AS total_orders,
    ROUND(AVG(r.review_score), 2) AS avg_review_score
FROM orders o
JOIN order_reviews r 
    ON o.order_id = r.order_id
WHERE o.order_delivered_customer_date IS NOT NULL
GROUP BY delivery_status
ORDER BY avg_review_score DESC;


-- =========================================
-- 6. Top 10 Product Categories by Revenue Share
-- =========================================
WITH category_revenue AS (
    SELECT 
        p.product_category_name,
        SUM(oi.price + oi.freight_value) AS revenue
    FROM order_items oi
    JOIN products p 
        ON oi.product_id = p.product_id
    GROUP BY p.product_category_name
),
total_revenue AS (
    SELECT SUM(revenue) AS total_revenue
    FROM category_revenue
)

SELECT
    product_category_name,
    revenue,
    ROUND(100.0 * revenue / total_revenue, 2) AS revenue_share_percent
FROM category_revenue, total_revenue
ORDER BY revenue DESC
LIMIT 10;


-- =========================================
-- 7. Top 10 Product Categories by Number of Orders
-- =========================================
SELECT 
    p.product_category_name,
    COUNT(DISTINCT oi.order_id) AS total_orders
FROM order_items oi
JOIN products p 
    ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_orders DESC
LIMIT 10;


-- =========================================
-- 8. Average Order Value (AOV)
-- =========================================
SELECT 
    ROUND(
        SUM(payment_value) / COUNT(DISTINCT order_id),
        2
    ) AS avg_order_value
FROM order_payments;


-- =========================================
-- 9. Monthly AOV Trend
-- =========================================
SELECT 
    DATE_TRUNC('month', o.order_purchase_timestamp) AS month,
    ROUND(
        SUM(op.payment_value) / COUNT(DISTINCT o.order_id),
        2
    ) AS avg_order_value
FROM orders o
JOIN order_payments op 
    ON o.order_id = op.order_id
WHERE DATE_TRUNC('month', o.order_purchase_timestamp) 
      BETWEEN '2017-01-01' AND '2018-08-01'
GROUP BY month
ORDER BY month;


-- =========================================
-- 10. Review Score Distribution
-- =========================================
SELECT 
    review_score,
    COUNT(*) AS total_reviews,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS review_share_percent
FROM order_reviews
GROUP BY review_score
ORDER BY review_score;


-- =========================================
-- 11. Order Value Segment vs Review Score
-- =========================================
SELECT 
    CASE 
        WHEN op.payment_value < 100 THEN 'Low Value'
        WHEN op.payment_value BETWEEN 100 AND 500 THEN 'Medium Value'
        ELSE 'High Value'
    END AS order_value_segment,
    COUNT(DISTINCT op.order_id) AS total_orders,
    ROUND(AVG(r.review_score), 2) AS avg_review_score
FROM order_payments op
JOIN order_reviews r 
    ON op.order_id = r.order_id
GROUP BY order_value_segment
ORDER BY avg_review_score DESC;


-- =========================================
-- 12. Low-Rated Sellers
-- Sellers with more than 50 order items
-- =========================================
SELECT 
    oi.seller_id,
    COUNT(*) AS total_order_items,
    ROUND(AVG(r.review_score), 2) AS avg_review_score
FROM order_items oi
JOIN order_reviews r 
    ON oi.order_id = r.order_id
GROUP BY oi.seller_id
HAVING COUNT(*) > 50
ORDER BY avg_review_score ASC
LIMIT 10;
