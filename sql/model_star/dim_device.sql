-- Create dimension table : device
CREATE OR REPLACE TABLE `use-case-eyfabernovel.dataset_eyfab.dim_device` AS
SELECT DISTINCT
    device.deviceCategory,
    device.browser,
    device.operatingSystem,
FROM
    `bigquery-public-data.google_analytics_sample.ga_sessions_*`
WHERE
    _TABLE_SUFFIX BETWEEN '20160101' AND '20171231';
