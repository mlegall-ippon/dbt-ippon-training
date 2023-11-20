{#{% set payment_methods_query %}
select distinct payment_method from {{ source('SOURCE', 'orders') }}
order by 1
{% endset %}

{% set results = run_query(payment_methods_query) %}

{% if execute %}
{% set results_list = results.columns[0].values() %}
{% else %}
{% set results_list = [] %}
{% endif %}  Macro run query#}

{% set payment_methods = dbt_utils.get_column_values(table=source('SOURCE', 'orders'), column='payment_method') %}


with base_orders as (
    select * from {{ ref('base_orders') }}
)

, base_restaurants as (
    select * from {{ ref('base_restaurants') }}
)

, restaurants_orders as (
    select 
        r.restau_id
        , r.name
        , r.address
        , r.nb_employees
        , r.open_on_sunday
        , o.amount
        , o.payment_method
        , o.id 
    from
            base_restaurants r
    left join
            base_orders o
    on r.restau_id = o.restau_id
)

, restaurants_turnover as (
    select 
        restau_id
        , name
        , address
        , nb_employees
        , {% for payment_method in payment_methods %}
        sum(case when payment_method = '{{payment_method}}' then amount end) as {{payment_method}}_amount,
        {% endfor %}
        sum(amount) as turnover
    from 
        restaurants_orders
    group by 
        name, restau_id, address, nb_employees
    
)

select * from restaurants_turnover order by turnover desc