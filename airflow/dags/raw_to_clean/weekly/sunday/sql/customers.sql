CREATE EXTENSION IF NOT EXISTS unaccent;
BEGIN;
DELETE FROM staging.dim_customers WHERE 1=1;
INSERT INTO staging.dim_customers 
    SELECT
        customer_id,
        customer_unique_id,
        customer_zip_code_prefix,
        unaccent(customer_city) AS customer_city,
        unaccent(customer_state) AS customer_state
    FROM raw.customers;
COMMIT;
