DROP TABLE IF EXISTS raw.orders;

CREATE TABLE raw.orders (
    order_id TEXT,
    customer_id TEXT,
    order_status TEXT,
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP,
    CONSTRAINT order_status_validation CHECK (order_status IN (
    'delivered',
    'shipped',
    'canceled',
    'unavailable',
    'invoiced',
    'processing',
    'created',
    'approved'
))
)
;

\COPY raw.orders FROM '/raw_data/csv/orders_dataset.csv' DELIMITER ',' CSV HEADER;