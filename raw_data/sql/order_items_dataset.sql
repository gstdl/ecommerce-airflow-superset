DROP TABLE IF EXISTS raw.order_items;

CREATE TABLE raw.order_items (
    order_id TEXT,
    order_item_id INT,
    product_id TEXT,
    seller_id TEXT,
    shipping_limit_date TIMESTAMP,
    price DOUBLE PRECISION,
    freight_value DOUBLE PRECISION 
)
;

\COPY raw.order_items FROM '/raw_data/csv/order_items_dataset.csv' DELIMITER ',' CSV HEADER;