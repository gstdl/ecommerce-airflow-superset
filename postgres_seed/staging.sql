\c ecommerce

DROP TABLE IF EXISTS staging.dim_customers;
CREATE TABLE staging.dim_customers (
    customer_id TEXT PRIMARY KEY,
    customer_unique_id TEXT,
    customer_zip_code_prefix TEXT,
    customer_city TEXT,
    customer_state TEXT
)
;

DROP TABLE IF EXISTS staging.dim_geolocation;
CREATE TABLE staging.dim_geolocation (
    geolocation_zip_code_prefix TEXT,
    geolocation_lat DOUBLE PRECISION,
    geolocation_lng DOUBLE PRECISION,
    geolocation_city TEXT,
    geolocation_state TEXT
)
;

DROP TABLE IF EXISTS staging.fact_order_items;
CREATE TABLE staging.fact_order_items (
    order_id TEXT,
    order_item_id INT,
    product_id TEXT,
    seller_id TEXT,
    shipping_limit_date TIMESTAMP,
    price DOUBLE PRECISION,
    freight_value DOUBLE PRECISION,
    insert_date DATE NOT NULL
)
;

DROP TABLE IF EXISTS staging.dim_order_payments;
CREATE TABLE staging.dim_order_payments (
    order_id TEXT,
    payment_sequential INT,
    payment_type TEXT,
    payment_installments INT,
    payment_value DOUBLE PRECISION,
    CONSTRAINT payment_type_validation CHECK (payment_type IN (
    'boleto',
    'credit_card',
    'debit_card',
    'not_defined',
    'voucher'
))
)
;

DROP TABLE IF EXISTS staging.fact_order_reviews;
CREATE TABLE staging.fact_order_reviews (
    review_id TEXT,
    order_id TEXT,
    review_score INT,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP,
    insert_date DATE NOT NULL,
    CONSTRAINT review_score_validation CHECK (review_score > 0 AND review_score < 6)
)
;

DROP TABLE IF EXISTS staging.fact_orders;
CREATE TABLE staging.fact_orders (
    order_id TEXT,
    customer_id TEXT,
    order_status TEXT,
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP,
    insert_date DATE NOT NULL,
    CONSTRAINT order_status_validation CHECK (order_status IN (
    'delivered',
    'shipped',
    'canceled',
    'unavailable',
    'invoiced',
    'processing',
    'created',
    'approved'
))
)
;

DROP TABLE IF EXISTS staging.dim_products;
CREATE TABLE staging.dim_products (
    product_id TEXT,
    product_category_name TEXT,
    product_category_name_en TEXT,
    product_name_length INT,
    product_description_lenght INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT
)
;

DROP TABLE IF EXISTS staging.dim_sellers;
CREATE TABLE staging.dim_sellers (
    seller_id TEXT,
    seller_zip_code_prefix TEXT,
    seller_city TEXT,
    seller_state TEXT
)
;

-- ALTER TABLE staging.fact_order_reviews
--     ADD CONSTRAINT order_id_fk
--     FOREIGN KEY (order_id)
--     REFERENCES staging.fact_orders(order_id)
-- ;

-- ALTER TABLE staging.fact_order_payments
--     ADD CONSTRAINT order_id_fk
--     FOREIGN KEY (order_id)
--     REFERENCES staging.fact_orders(order_id)
-- ;

-- ALTER TABLE staging.dim_customers;
--     ADD CONSTRAINT order_id_fk
--     FOREIGN KEY (order_id)
--     REFERENCES staging.fact_orders(order_id)
-- ;

-- ALTER TABLE staging.fact_order_items
--     ADD CONSTRAINT order_id_fk
--     FOREIGN KEY (order_id)
--     REFERENCES staging.fact_orders(order_id)
-- ;

-- ALTER TABLE staging.dim_products
--     ADD CONSTRAINT product_id_fk
--     FOREIGN KEY (product_id)
--     REFERENCES staging.fact_order_items(product_id)
-- ;

-- ALTER TABLE staging.fact_order_items
--     ADD CONSTRAINT seller_id_fk
--     FOREIGN KEY (seller_id)
--     REFERENCES staging.dim_sellers(seller_id)
-- ;

-- ALTER TABLE staging.dim_sellers;
--     ADD CONSTRAINT zip_code_prefix_fk
--     FOREIGN KEY (zip_code_prefix)
--     REFERENCES staging.dim_geolocation(zip_code_prefix)
-- ;

-- ALTER TABLE staging.dim_sellers;
--     ADD CONSTRAINT zip_code_prefix_fk
--     FOREIGN KEY (zip_code_prefix)
--     REFERENCES staging.dim_geolocation(zip_code_prefix)
-- ;