WITH date_cte AS (  
  SELECT DISTINCT
    {{ dbt_utils.generate_surrogate_key(['TransactionID', 'Date']) }} AS date_id,
    CAST(Date AS TIMESTAMP) as transaction_date
  FROM {{ source('sales', 'raw_sales') }}
  WHERE Date IS NOT NULL
)
SELECT
  date_id,
  EXTRACT(YEAR FROM transaction_date) AS year,
  EXTRACT(MONTH FROM transaction_date) AS month,
  EXTRACT(DAY FROM transaction_date) AS day
FROM date_cte
