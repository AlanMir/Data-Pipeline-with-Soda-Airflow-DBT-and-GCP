WITH fct_transactions_cte AS (
    SELECT
        TransactionID AS transaction_id,
        {{ dbt_utils.generate_surrogate_key(['TransactionID', 'Date']) }} AS date_id,
        Date AS transaction_date,
        {{ dbt_utils.generate_surrogate_key(['ProductName', 'UnitPrice']) }} as product_id,
        PaymentMethod as payment_method,
        UnitsSold AS units_sold,
        TotalRevenue AS total_revenue,
        Region as region
    FROM {{ source('sales', 'raw_sales') }}
    WHERE UnitsSold > 0
)
SELECT
    ft.transaction_id,
    ft.transaction_date,
    dp.product_id,
    ft.units_sold,
    ft.total_revenue
FROM fct_transactions_cte ft
INNER JOIN {{ ref('dim_date') }} dt ON ft.date_id = dt.date_id
INNER JOIN {{ ref('dim_product') }} dp ON ft.product_id = dp.product_id
