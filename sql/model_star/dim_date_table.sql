-- Create dimension table : date
CREATE OR REPLACE TABLE `use-case-eyfabernovel.dataset_eyfab.dim_date` AS
SELECT DISTINCT
    PARSE_DATE('%Y%m%d', CAST(date AS STRING)) AS date,
    EXTRACT(MONTH FROM PARSE_DATE('%Y%m%d', CAST(date AS STRING))) AS month,
    EXTRACT(YEAR FROM PARSE_DATE('%Y%m%d', CAST(date AS STRING))) AS year,
    EXTRACT(WEEK FROM PARSE_DATE('%Y%m%d', CAST(date AS STRING))) AS week
FROM
    `bigquery-public-data.google_analytics_sample.ga_sessions_*`
WHERE
    _TABLE_SUFFIX BETWEEN '20160101' AND '20171231';
