DROP TABLE IF EXISTS raw.sellers;

CREATE TABLE raw.sellers (
    seller_id TEXT,
    seller_zip_code_prefix TEXT,
    seller_city TEXT,
    seller_state TEXT
)
;

\COPY raw.sellers FROM '/raw_data/csv/sellers_dataset.csv' DELIMITER ',' CSV HEADER;
