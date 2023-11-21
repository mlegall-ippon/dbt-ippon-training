{% macro mockable_source(test_input, real_schema, real_table) %}
    {%- set target_name = target.name.lower() -%}
    {% if target_name in ['ci','default','dev'] %}
        select * from {{ ref(test_input) }}
    {% else %}
        select * from {{ source(real_schema,real_table) }}
    {% endif %}
{% endmacro %}