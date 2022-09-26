DROP TABLE IF EXISTS raw.products;

CREATE TABLE raw.products (
    product_id TEXT,
    product_category_name TEXT,
    product_name_lenght INT,
    product_description_lenght INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT
)
;

\COPY raw.products FROM '/raw_data/csv/products_dataset.csv' DELIMITER ',' CSV HEADER;
