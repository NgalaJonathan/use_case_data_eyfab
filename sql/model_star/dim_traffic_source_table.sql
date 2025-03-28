-- Create dimension table traffic source for the model star
CREATE OR REPLACE TABLE `use-case-eyfabernovel.dataset_eyfab.dim_traffic_source` AS
SELECT DISTINCT
    trafficSource.source,
    trafficSource.medium,
    trafficSource.campaign,
    trafficSource.referralPath
FROM
    `bigquery-public-data.google_analytics_sample.ga_sessions_*`
WHERE
    _TABLE_SUFFIX BETWEEN '20160101' AND '20171231';
