BEGIN;
DELETE FROM staging.dim_geolocation WHERE 1=1;
INSERT INTO staging.dim_geolocation 
    SELECT * 
    FROM raw.geolocation;
COMMIT;
