-- Create dimension table : geoNetwork(localisation)
CREATE OR REPLACE TABLE `use-case-eyfabernovel.dataset_eyfab.dim_geo` AS
SELECT DISTINCT
    geoNetwork.country,
    geoNetwork.region,
    geoNetwork.city
FROM
    `bigquery-public-data.google_analytics_sample.ga_sessions_*`
WHERE
    _TABLE_SUFFIX BETWEEN '20160101' AND '20171231';
