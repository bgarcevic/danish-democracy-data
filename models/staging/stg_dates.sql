{% set sql_statement %}
    select min(individual_votes_updated_at) from {{ ref('fct_individual_votes') }}
{% endset %}

{%- set first_data_point = dbt_utils.get_single_value(sql_statement, default="'2014-01-01'") -%}

with date_spine as (

  {{ dbt_utils.date_spine(
      start_date = "cast('" + first_data_point + "' as date)",
      datepart = "day",
      end_date = "cast(date_trunc('year', current_date + interval 1 year) as date)"
     )
  }}

),

create_date_table as (
    select
        date_day as date,
        date_part('year', date_day) as year,
        date_trunc('year', date_day) as year_start_date,
        date_trunc('year', date_day) + interval '1 year' - interval '1 day' as year_end_date,
        date_day - date_trunc('year', date_day) + 1 as year_day_number,
        date_diff('year', current_date, date_day) as year_offset,
        if(date_diff('year', current_date, date_day) < 0, 1, 0) as year_completed,
        date_part('quarter', date_day) as quarter,
        date_trunc('quarter', date_day) as quarter_start_date,
        date_trunc('quarter', date_day) + interval '1 quarter' - interval '1 day' as quarter_end_date,
        date_day - date_trunc('quarter', date_day) + 1 as quarter_day_number,
        date_diff('quarter', current_date, date_day) as quarter_offset,
        if(date_diff('quarter', current_date, date_day) < 0, 1, 0) as quarter_completed,
        date_part('month', date_day) as month,
        date_trunc('month', date_day) as month_start_date,
        date_trunc('month', date_day) + interval '1 month' - interval '1 day' as month_end_date,
        date_day - date_trunc('month', date_day) + 1 as month_day_number,
        date_diff('month', current_date, date_day) as month_offset,
        if(date_diff('month', current_date, date_day) < 0, 1, 0) as month_completed
    from date_spine
)

select * from create_date_table
