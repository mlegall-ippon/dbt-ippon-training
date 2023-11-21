{{
  config(
    materialized='table'
  )
}}

with base_fuzzy as(
    select * from {{ ref('base_fuzzy') }}
)

, fuzzy_lateral_flatten as (
    select
        *
    from base_fuzzy, lateral FLATTEN(input => parse_json(dishes_names))
)

, fuzzy_flatten as (
    select 
        seq as id
        , value as dish
        , payment_method
        , amount
        , created_at
    from 
        fuzzy_lateral_flatten
)

select * from fuzzy_flatten