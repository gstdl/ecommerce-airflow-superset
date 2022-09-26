-- ALTER TABLE raw.order_reviews
--     ADD CONSTRAINT order_id_fk
--     FOREIGN KEY (order_id)
--     REFERENCES raw.orders(order_id)
-- ;

-- ALTER TABLE raw.order_payments
--     ADD CONSTRAINT order_id_fk
--     FOREIGN KEY (order_id)
--     REFERENCES raw.orders(order_id)
-- ;

-- ALTER TABLE raw.customers
--     ADD CONSTRAINT order_id_fk
--     FOREIGN KEY (order_id)
--     REFERENCES raw.orders(order_id)
-- ;

-- ALTER TABLE raw.order_items
--     ADD CONSTRAINT order_id_fk
--     FOREIGN KEY (order_id)
--     REFERENCES raw.orders(order_id)
-- ;

-- ALTER TABLE raw.products
--     ADD CONSTRAINT product_id_fk
--     FOREIGN KEY (product_id)
--     REFERENCES raw.order_items(product_id)
-- ;

-- ALTER TABLE raw.order_items
--     ADD CONSTRAINT seller_id_fk
--     FOREIGN KEY (seller_id)
--     REFERENCES raw.sellers(seller_id)
-- ;

-- ALTER TABLE raw.sellers
--     ADD CONSTRAINT zip_code_prefix_fk
--     FOREIGN KEY (zip_code_prefix)
--     REFERENCES raw.geolocation(zip_code_prefix)
-- ;

-- ALTER TABLE raw.sellers
--     ADD CONSTRAINT zip_code_prefix_fk
--     FOREIGN KEY (zip_code_prefix)
--     REFERENCES raw.geolocation(zip_code_prefix)
-- ;
