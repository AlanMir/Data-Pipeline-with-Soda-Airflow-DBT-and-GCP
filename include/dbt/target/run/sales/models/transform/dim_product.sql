
  
    

    create or replace table `brave-aviary-428415-v5`.`sales`.`dim_product`
    
    

    OPTIONS()
    as (
      SELECT DISTINCT
    to_hex(md5(cast(coalesce(cast(ProductName as STRING), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(UnitPrice as STRING), '_dbt_utils_surrogate_key_null_') as STRING))) as product_id,
		ProductName AS product_name,
    ProductCategory AS product_category,
    UnitPrice AS unit_price
FROM `brave-aviary-428415-v5`.`sales`.`raw_sales`
WHERE ProductName IS NOT NULL
AND UnitPrice > 0
    );
  