-- =========================================
-- Data preparation for Power BI Dashboard
-- Dataset: Olist E-commerce
-- =========================================

-- =========================================
-- MAIN ANALYSIS TABLE
-- =========================================
CREATE TABLE analysis_table AS
WITH order_revenue AS (
    SELECT 
        order_id,
        SUM(price + freight_value) AS revenue
    FROM order_items
    GROUP BY order_id
),

order_payments_agg AS (
    SELECT
        order_id,
        SUM(payment_value) AS payment_value
    FROM order_payments
    GROUP BY order_id
),

order_reviews_agg AS (
    SELECT
        order_id,
        AVG(review_score) AS review_score
    FROM order_reviews
    GROUP BY order_id
)

CREATE TABLE analysis_table AS
SELECT
    o.order_id,
    o.order_purchase_timestamp,
    DATE_TRUNC('month', o.order_purchase_timestamp) AS order_month,

    c.customer_unique_id,

    o.order_status,

    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,

    CASE 
        WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 'Delayed'
        ELSE 'On Time'
    END AS delivery_status,

    r.revenue,
    p.payment_value,
    rv.review_score

FROM orders o

JOIN customers c 
    ON o.customer_id = c.customer_id

LEFT JOIN order_revenue r 
    ON o.order_id = r.order_id

LEFT JOIN order_payments_agg p 
    ON o.order_id = p.order_id

LEFT JOIN order_reviews_agg rv 
    ON o.order_id = rv.order_id;


-- =========================================
-- CATEGORY ANALYSIS TABLE
-- =========================================

CREATE TABLE category_analysis_table AS
SELECT
    oi.order_id,
    DATE_TRUNC('month', o.order_purchase_timestamp) AS order_month,

    COALESCE(p.product_category_name, 'unknown') AS category,

    SUM(oi.price + oi.freight_value) AS revenue

FROM order_items oi

JOIN orders o 
    ON oi.order_id = o.order_id

LEFT JOIN products p 
    ON oi.product_id = p.product_id

GROUP BY
    oi.order_id,
    DATE_TRUNC('month', o.order_purchase_timestamp),
    COALESCE(p.product_category_name, 'unknown');
