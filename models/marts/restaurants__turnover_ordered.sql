

with restaurants_turnover as (
    select * from {{ ref('stg_restaurants__turnover') }}
)

, restaurants_turnover_ordered as (
    select
        restau_id
        , name
        , address
        , nb_employees
        , turnover
    from 
        restaurants_turnover
    order by
        turnover desc
)

select * from restaurants_turnover_ordered limit {{var('nb_restaurants_to_show')}}