WITH top_products AS (
    SELECT
        product_sku,
        SUM(product_quantity) AS total_sold
    FROM
        `use-case-eyfabernovel.dataset_eyfab.fact_session`
    WHERE
        session_date BETWEEN '2017-10-01' AND '2017-12-31'
    GROUP BY
        product_sku
    ORDER BY
        total_sold DESC
    LIMIT 10
)

SELECT
    EXTRACT(YEAR FROM f.session_date) AS year,
    EXTRACT(MONTH FROM f.session_date) AS month,
    f.product_sku,
    SUM(f.product_quantity) AS monthly_sales,
    (SUM(f.product_quantity) - LAG(SUM(f.product_quantity)) OVER (PARTITION BY f.product_sku ORDER BY f.session_date)) / 
    LAG(SUM(f.product_quantity)) OVER (PARTITION BY f.product_sku ORDER BY f.session_date) AS monthly_growth_rate
FROM
    `use-case-eyfabernovel.dataset_eyfab.fact_session` AS f
JOIN top_products AS t
    ON f.product_sku = t.product_sku
WHERE
    f.session_date BETWEEN '2017-10-01' AND '2017-12-31'
GROUP BY
    year, month, f.product_sku
ORDER BY
    year, month, f.product_sku;
