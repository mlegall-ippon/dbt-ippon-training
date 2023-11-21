with source as (
    {{ mockable_source('sample_orders','SOURCE','orders') }}
)
, base_orders as (
    select
        identifier as id
        , restaurant_identifier as restau_id
        , dishes_ids as dishes_ids
        , payment_method as payment_method
        , amount as amount
        , created_at as created_at
    from
        source
    qualify 
            row_number() over (partition by id order by id desc) = 1
)

select * from base_orders