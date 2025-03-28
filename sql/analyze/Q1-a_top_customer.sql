SELECT 
        fullVisitorId AS client_id,
        SUM(transactionRevenue) AS total_purchase_amount
    FROM 
        `use-case-eyfabernovel.dataset_eyfab.fact_session`
    WHERE 
        session_date BETWEEN '2017-01-01' AND '2017-12-31'
    GROUP BY 
        client_id
    ORDER BY 
        total_purchase_amount DESC
    LIMIT 5