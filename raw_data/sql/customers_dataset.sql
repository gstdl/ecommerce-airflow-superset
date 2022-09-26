DROP TABLE IF EXISTS raw.customers;

CREATE TABLE raw.customers (
    customer_id TEXT PRIMARY KEY,
    customer_unique_id TEXT,
    customer_zip_code_prefix TEXT,
    customer_city TEXT,
    customer_state TEXT
)
;

\COPY raw.customers FROM '/raw_data/csv/customers_dataset.csv' DELIMITER ',' CSV HEADER;