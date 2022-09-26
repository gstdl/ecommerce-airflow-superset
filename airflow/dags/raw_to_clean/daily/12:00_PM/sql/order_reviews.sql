BEGIN;
INSERT INTO staging.fact_order_reviews
    SELECT *, '{{ ds }}'::DATE AS insert_date
    FROM raw.order_reviews
    WHERE review_creation_date::DATE = '{{ ds }}'
      AND order_id IN (SELECT order_id FROM staging.fact_orders);
COMMIT;
