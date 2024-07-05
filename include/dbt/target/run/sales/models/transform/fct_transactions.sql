
  
    

    create or replace table `brave-aviary-428415-v5`.`sales`.`fct_transactions`
    
    

    OPTIONS()
    as (
      WITH fct_transactions_cte AS (
    SELECT
        TransactionID AS transaction_id,
        to_hex(md5(cast(coalesce(cast(TransactionID as STRING), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(Date as STRING), '_dbt_utils_surrogate_key_null_') as STRING))) AS date_id,
        Date AS transaction_date,
        to_hex(md5(cast(coalesce(cast(ProductName as STRING), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(UnitPrice as STRING), '_dbt_utils_surrogate_key_null_') as STRING))) as product_id,
        PaymentMethod as payment_method,
        UnitsSold AS units_sold,
        TotalRevenue AS total_revenue,
        Region as region
    FROM `brave-aviary-428415-v5`.`sales`.`raw_sales`
    WHERE UnitsSold > 0
)
SELECT
    ft.transaction_id,
    ft.transaction_date,
    dp.product_id,
    ft.units_sold,
    ft.total_revenue
FROM fct_transactions_cte ft
INNER JOIN `brave-aviary-428415-v5`.`sales`.`dim_date` dt ON ft.date_id = dt.date_id
INNER JOIN `brave-aviary-428415-v5`.`sales`.`dim_product` dp ON ft.product_id = dp.product_id
    );
  