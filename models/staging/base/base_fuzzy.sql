with base_fuzzy as (
select
    dishes_names as dishes_names
    , payment_method as payment_method
    , amount as amount
    , created_at as created_at
from
    {{ source('SOURCE', 'fuzzy_orders') }}
)

select * from base_fuzzy