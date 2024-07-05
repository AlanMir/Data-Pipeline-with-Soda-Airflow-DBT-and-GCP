with product as (
    select product_id,product_category,product_name
    from `brave-aviary-428415-v5`.`sales`.`dim_product`
),
transactions as (
    select product_id,
    total_revenue
    from `brave-aviary-428415-v5`.`sales`.`fct_transactions`
)
select product_name,
product_category,
sum(total_revenue) as revenue
from product p
join transactions t
on p.product_id = t.product_id
group by 1,2
order by 3 desc
limit 10