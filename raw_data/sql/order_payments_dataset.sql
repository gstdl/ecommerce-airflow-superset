DROP TABLE IF EXISTS raw.order_payments;

CREATE TABLE raw.order_payments (
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

\COPY raw.order_payments FROM '/raw_data/csv/order_payments_dataset.csv' DELIMITER ',' CSV HEADER;