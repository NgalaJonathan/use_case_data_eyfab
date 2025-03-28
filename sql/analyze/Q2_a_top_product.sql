SELECT
    product_sku,
    SUM(product_quantity) AS total_sold,
    SUM(product_revenue) AS total_revenue
FROM
    `use-case-eyfabernovel.dataset_eyfab.fact_session`
WHERE
    session_date BETWEEN '2017-10-01' AND '2017-12-31'
GROUP BY
    product_sku
ORDER BY
    total_sold DESC
LIMIT 10;
