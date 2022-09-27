CREATE VIEW mart.rfm_ordinal AS
    SELECT 
        customer_unique_id, 
        recency, 
        frequency, 
        monetary,
        CASE
            WHEN recency BETWEEN -90 AND 0 THEN 5
            WHEN recency BETWEEN -180 AND -91  THEN 4
            WHEN recency BETWEEN -270 AND -181  THEN 3
            WHEN recency BETWEEN -366 AND -271 THEN 2
            ELSE 1
            END r,
        CASE 
            WHEN frequency = 1 THEN 1
            WHEN frequency BETWEEN 2 AND 3 THEN 2
            WHEN frequency BETWEEN 4 AND 5 THEN 3
            WHEN frequency BETWEEN 6 AND 7 THEN 4
            ELSE 5
            END f,
        CASE 
            WHEN monetary <= 100 THEN 1 
            WHEN monetary BETWEEN 100.0000000000000001 AND 250 THEN 2 
            WHEN monetary BETWEEN 250.0000000000000001 AND 500 THEN 3
            WHEN monetary BETWEEN 500.0000000000000001 AND 1000 THEN 4
            ELSE 5
            END m
    FROM mart.rfm
;