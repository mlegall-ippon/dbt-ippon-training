with base_orders as (
select
    identifier as id
    , restaurant_identifier as restau_id
    , payment_method as payment_method
    , amount as amount
    , created_at as created_at
from
    {{ source('SOURCE', 'orders') }}
qualify 
        row_number() over (partition by id order by id desc) = 1
)

select * from base_orders