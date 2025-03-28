WITH user_sessions AS (
    SELECT
        fullVisitorId AS client_id,
        EXTRACT(MONTH FROM session_date) AS month,
        COUNT(DISTINCT visitId) AS session_count
    FROM
        `use-case-eyfabernovel.dataset_eyfab.fact_session`
    WHERE
        session_date BETWEEN '2017-01-01' AND '2017-12-31'
    GROUP BY
        client_id, month
)

SELECT
    month,
    COUNT(DISTINCT client_id) AS total_users,
    COUNT(DISTINCT CASE WHEN session_count = 1 THEN client_id END) AS churned_users,
    COUNT(DISTINCT CASE WHEN session_count = 1 THEN client_id END) / COUNT(DISTINCT client_id) AS churn_rate
FROM
    user_sessions
GROUP BY
    month
ORDER BY
    month;
