CREATE DATABASE ecommerce;
\c ecommerce
CREATE SCHEMA raw;
CREATE SCHEMA staging;
CREATE SCHEMA mart;

\i /raw_data/sql/customers_dataset.sql
\i /raw_data/sql/geolocation_dataset.sql
\i /raw_data/sql/order_items_dataset.sql
\i /raw_data/sql/order_payments_dataset.sql
\i /raw_data/sql/order_reviews_dataset.sql
\i /raw_data/sql/orders_dataset.sql
\i /raw_data/sql/product_category_name_translation.sql
\i /raw_data/sql/products_dataset.sql
\i /raw_data/sql/sellers_dataset.sql

\i /raw_data/sql/foreign_key_alter.sql