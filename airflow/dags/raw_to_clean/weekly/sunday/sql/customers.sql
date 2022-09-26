BEGIN;
DELETE FROM staging.dim_customers WHERE 1=1;
INSERT INTO staging.dim_customers 
    SELECT * 
    FROM raw.customers;
COMMIT;
