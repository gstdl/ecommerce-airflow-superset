DROP TABLE IF EXISTS raw.geolocation;

CREATE TABLE raw.geolocation (
    geolocation_zip_code_prefix TEXT,
    geolocation_lat DOUBLE PRECISION,
    geolocation_lng DOUBLE PRECISION,
    geolocation_city TEXT,
    geolocation_state TEXT
)
;

\COPY raw.geolocation FROM '/raw_data/csv/geolocation_dataset.csv' DELIMITER ',' CSV HEADER;