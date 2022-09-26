BEGIN;
WITH orders AS (
INSERT INTO staging.fact_orders
    SELECT *, '{{ ds }}'::DATE AS insert_date
    FROM raw.orders
    WHERE order_purchase_timestamp::DATE = '{{ ds }}'
RETURNING order_id
)
INSERT INTO staging.fact_order_items
    SELECT *, '{{ ds }}'::DATE AS insert_date
    FROM raw.order_items
    WHERE order_id IN (
        SELECT order_id
        FROM orders
    );
DELETE FROM staging.dim_order_payments WHERE 1=1;
INSERT INTO staging.dim_order_payments 
    SELECT * 
    FROM raw.order_payments
    WHERE order_id IN (
        SELECT order_id
        FROM staging.fact_orders
    );
COMMIT;
