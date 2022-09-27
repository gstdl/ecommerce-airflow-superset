CREATE EXTENSION IF NOT EXISTS unaccent;
BEGIN;
DELETE FROM staging.dim_geolocation WHERE 1=1;
INSERT INTO staging.dim_geolocation 
    SELECT
        geolocation_zip_code_prefix,
        geolocation_lat,
        geolocation_lng,
        unaccent(geolocation_city) AS geolocation_city,
        unaccent(geolocation_state) AS geolocation_state
    FROM raw.geolocation;
COMMIT;
