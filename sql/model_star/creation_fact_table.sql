-- Create fact table for the model star
CREATE OR REPLACE TABLE `use-case-eyfabernovel.dataset_eyfab.fact_session` AS 
SELECT
    fullVisitorId,
    visitId,
    visitStartTime,
    totals.pageviews AS pageviews,
    totals.timeOnSite AS time_on_site,
    totals.transactions AS transactions,
    totals.transactionRevenue AS transactionRevenue,
    totals.bounces AS bounces,
    totals.sessionQualityDim AS session_quality,
    trafficSource.source AS traffic_source,
    device.deviceCategory AS device_category,
    geoNetwork.country AS geo_country,
    PARSE_DATE('%Y%m%d', CAST(date AS STRING)) AS session_date,  
    product.productSKU AS product_sku,   
    product.productQuantity AS product_quantity,  
    product.productRevenue AS product_revenue  
FROM
    `bigquery-public-data.google_analytics_sample.ga_sessions_*`,
    UNNEST(hits) AS hits,
    UNNEST(hits.product) AS product  -- for the Array
WHERE
    _TABLE_SUFFIX BETWEEN '20160101' AND '20171231'; 

