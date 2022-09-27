CREATE VIEW mart.rfm AS
    WITH orders AS (
        SELECT
            customer_id,
            order_id,
            order_purchase_timestamp::DATE AS order_purchase_date
        FROM staging.fact_orders
        WHERE order_status NOT IN ('cancelled','created','unavailable','approved')  
          AND order_purchase_timestamp IS NOT NULL
    ), order_payments AS (
        SELECT
            order_id,
            SUM(payment_value) AS total_payment_value
        FROM staging.dim_order_payments
        GROUP BY 1
    ), base AS (
        SELECT
            customers.customer_unique_id,
            orders.order_id,
            orders.order_purchase_date,
            MAX(orders.order_purchase_date) OVER(PARTITION BY customers.customer_unique_id) AS latest_purchase_date,
            order_payments.total_payment_value
        FROM orders
        LEFT JOIN order_payments
        ON orders.order_id = order_payments.order_id
        LEFT JOIN staging.dim_customers AS customers
        ON orders.customer_id = customers.customer_id
        WHERE customers.customer_unique_id IS NOT NULL
    )
    SELECT 
        customer_unique_id,
        MIN(order_purchase_date - latest_purchase_date) recency,
        COUNT(DISTINCT order_id) AS frequency, 
        SUM(total_payment_value) AS monetary 
        FROM base
        GROUP BY 1
;