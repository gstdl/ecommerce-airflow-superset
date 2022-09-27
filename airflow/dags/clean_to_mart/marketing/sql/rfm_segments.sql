CREATE VIEW mart.rfm_segments AS
    SELECT 
        customer_unique_id, 
        recency, 
        frequency, 
        monetary, 
        r, 
        f, 
        m, 
        CONCAT(r::TEXT,f::TEXT,m::TEXT) AS rfm_segment, 
        (r+f+m) AS rfm_score,
        CASE
            WHEN m < 3 THEN CONCAT(rf_segmentation, ' Low Spender')
            WHEN m > 3 AND r > 3 AND f > 3 THEN 'Best Customer'
            ELSE CONCAT(rf_segmentation, ' High Spender')
        END rfm_segmentation
        FROM (
            SELECT 
                *, 
                CASE
                    WHEN r > 3 THEN CONCAT('New ', f_segmentation)
                    WHEN r = 3 AND f > 2 THEN f_segmentation
                    ELSE CONCAT('Churned ', f_segmentation)
                END rf_segmentation
            FROM (
                SELECT 
                    *,
                    CASE 
                        WHEN f > 2 THEN 'Frequent'
                        ELSE ''
                        END f_segmentation
                FROM mart.rfm_ordinal) f_segment
            ) rf_segment
    ORDER BY rfm_segmentation, rfm_score DESC, Recency
;