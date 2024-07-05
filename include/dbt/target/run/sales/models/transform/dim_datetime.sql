
  
    

    create or replace table `brave-aviary-428415-v5`.`sales`.`dim_datetime`
    
    

    OPTIONS()
    as (
      WITH date_cte AS (  
  SELECT DISTINCT
    to_hex(md5(cast(coalesce(cast(Transaction ID as STRING), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(Date as STRING), '_dbt_utils_surrogate_key_null_') as STRING))) AS date_id,
    Date as transaction_date
  FROM `brave-aviary-428415-v5`.`sales`.`raw_sales`
  WHERE Date IS NOT NULL
)
SELECT
  date_id,
  EXTRACT(YEAR FROM transaction_date) AS year,
  EXTRACT(MONTH FROM transaction_date) AS month,
  EXTRACT(DAY FROM transaction_date) AS day
FROM datetime_cte
    );
  