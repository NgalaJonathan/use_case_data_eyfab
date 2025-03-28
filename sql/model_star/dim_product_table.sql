-- Create dimension table : product
CREATE OR REPLACE TABLE `use-case-eyfabernovel.dataset_eyfab.dim_product` AS
SELECT DISTINCT
    product.productSKU AS product_sku,
    product.v2ProductName AS product_name,
    product.v2ProductCategory AS product_category,
    product.productPrice AS product_price
FROM
    `bigquery-public-data.google_analytics_sample.ga_sessions_*`,
    UNNEST(hits) AS hits,
    UNNEST(hits.product) AS product
WHERE
    _TABLE_SUFFIX BETWEEN '20160101' AND '20171231'
    AND product.productSKU IS NOT NULL;
