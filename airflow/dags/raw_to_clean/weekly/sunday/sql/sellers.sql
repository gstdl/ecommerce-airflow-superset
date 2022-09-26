BEGIN;
DELETE FROM staging.dim_sellers WHERE 1=1;
INSERT INTO staging.dim_sellers 
    SELECT * 
    FROM raw.sellers;
COMMIT;
