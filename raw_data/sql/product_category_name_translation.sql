DROP TABLE IF EXISTS raw.product_category_name_translation;

CREATE TABLE raw.product_category_name_translation (
    product_category_name TEXT,
    product_category_name_english TEXT
)
;

\COPY raw.product_category_name_translation FROM '/raw_data/csv/product_category_name_translation.csv' DELIMITER ',' CSV HEADER;
