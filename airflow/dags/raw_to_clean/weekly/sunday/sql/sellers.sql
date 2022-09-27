CREATE EXTENSION IF NOT EXISTS unaccent;
BEGIN;
DELETE FROM staging.dim_sellers WHERE 1=1;
INSERT INTO staging.dim_sellers 
    SELECT
        seller_id,
        seller_zip_code_prefix,
        unaccent(seller_city) AS seller_city,
        unaccent(seller_state) AS seller_state
    FROM raw.sellers;
COMMIT;
