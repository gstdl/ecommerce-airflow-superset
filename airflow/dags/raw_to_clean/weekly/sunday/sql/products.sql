BEGIN;
DELETE FROM staging.dim_products WHERE 1=1;
INSERT INTO staging.dim_products 
    SELECT
        products.product_id,
        products.product_category_name,
        en.product_category_name_english,
        products.product_name_lenght AS product_name_lenght,
        products.product_description_lenght,
        products.product_photos_qty,
        products.product_weight_g,
        products.product_length_cm,
        products.product_height_cm,
        products.product_width_cm
    FROM raw.products AS products
    LEFT JOIN raw.product_category_name_translation AS en
    ON products.product_category_name = en.product_category_name;
COMMIT;
