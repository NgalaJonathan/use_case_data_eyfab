SELECT 
    f.fullVisitorId,
    d.month,
    d.year,
    SUM(f.transactionRevenue) AS monthly_spent
FROM `use-case-eyfabernovel.dataset_eyfab.fact_session` f
JOIN `use-case-eyfabernovel.dataset_eyfab.dim_date` d 
    ON f.session_date = d.date
WHERE f.session_date BETWEEN '2017-01-01' AND '2017-12-31'
AND f.fullVisitorId IN (
    SELECT fullVisitorId
    FROM `use-case-eyfabernovel.dataset_eyfab.fact_session`
    WHERE session_date BETWEEN '2017-01-01' AND '2017-12-31'
    GROUP BY fullVisitorId
    ORDER BY SUM(transactionRevenue) DESC
    LIMIT 5
)
GROUP BY f.fullVisitorId, d.year, d.month
ORDER BY f.fullVisitorId, d.year, d.month;
