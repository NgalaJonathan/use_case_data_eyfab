SELECT
    traffic_source,
    SUM(transactions) / COUNT(fullVisitorId) AS conversion_rate
FROM
    `use-case-eyfabernovel.dataset_eyfab.fact_session`
WHERE
    session_date BETWEEN '2017-01-01' AND '2017-12-31'
GROUP BY
    traffic_source
ORDER BY
    conversion_rate DESC;
