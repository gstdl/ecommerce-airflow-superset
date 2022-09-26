DROP TABLE IF EXISTS raw.order_reviews;

CREATE TABLE raw.order_reviews (
    review_id TEXT,
    order_id TEXT,
    review_score INT,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP,
    CONSTRAINT review_score_validation CHECK (review_score > 0 AND review_score < 6)
)
;

\COPY raw.order_reviews FROM '/raw_data/csv/order_reviews_dataset.csv' DELIMITER ',' CSV HEADER;