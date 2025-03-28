WITH conversion_rates AS (
    SELECT
        EXTRACT(YEAR FROM session_date) AS year,
        EXTRACT(MONTH FROM session_date) AS month,
        traffic_source,
        SUM(transactions) / COUNT(fullVisitorId) AS conversion_rate
    FROM
        `use-case-eyfabernovel.dataset_eyfab.fact_session`
    WHERE
        session_date BETWEEN '2017-07-01' AND '2017-12-31'
    GROUP BY
        year, month, traffic_source
)

SELECT
    year,
    month,
    traffic_source,
    conversion_rate,
    (conversion_rate - LAG(conversion_rate) OVER (PARTITION BY traffic_source ORDER BY year, month)) / 
    LAG(conversion_rate) OVER (PARTITION BY traffic_source ORDER BY year, month) AS monthly_conversion_rate_change
FROM
    conversion_rates
ORDER BY
    year, month, traffic_source;
