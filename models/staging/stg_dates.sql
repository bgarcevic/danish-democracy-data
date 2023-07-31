{% set sql_statement %}
    select min(individual_votes_updated_at) from {{ref('fct_individual_votes')}}
{% endset %}

{%- set first_data_point = dbt_utils.get_single_value(sql_statement, default="'2014-01-01'") -%}

WITH date_spine AS (

  {{ dbt_utils.date_spine(
      start_date = "cast('" + first_data_point + "' as date)",
      datepart = "day",
      end_date = "cast(date_trunc('year', current_date + interval 1 year) as date)"
     )
  }}

)

select * from date_spine
