with source as (
    {{ mockable_source('sample_restaurants','SOURCE','restaurants') }}
)
, base_restaurants as (
    select 
        identifier as restau_id
        , name as name
        , address as address
        , nb_employees as nb_employees
        , open_on_sunday as open_on_sunday
    from 
        source
)

select * from base_restaurants