SELECT DISTINCT
    {{ dbt_utils.generate_surrogate_key(['ProductName', 'UnitPrice']) }} as product_id,
		ProductName AS product_name,
    ProductCategory AS product_category,
    UnitPrice AS unit_price
FROM {{ source('sales', 'raw_sales') }}
WHERE ProductName IS NOT NULL
AND UnitPrice > 0