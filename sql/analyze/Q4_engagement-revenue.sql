WITH user_engagement AS (
    SELECT
        fullVisitorId AS client_id, 
        COUNT(DISTINCT visitId) AS session_count, 
        SUM(transactionRevenue) AS total_revenue  
    FROM
        `use-case-eyfabernovel.dataset_eyfab.fact_session`
    WHERE
        session_date BETWEEN '2017-01-01' AND '2017-12-31'
    GROUP BY
        client_id
)

SELECT
    CASE 
        WHEN session_count < 5 THEN 'Low'  
        WHEN session_count BETWEEN 5 AND 20 THEN 'Medium'  
        ELSE 'High'  
    END AS engagement_level_sessions,

    AVG(total_revenue) AS avg_revenue  
FROM
    user_engagement
GROUP BY
    engagement_level_sessions
ORDER BY
    engagement_level_sessions;
