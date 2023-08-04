with

dates as (
    select * from {{ ref('stg_dates') }}
),

holidays as (
    select * from {{ ref('stg_dates_holidays') }}
    -- remove one random of the overlapping holiday as we only want one of them
    qualify row_number() over (partition by holiday_date order by holiday_type desc) = 1
),

final as (
    select
       -- Date specific fields
        {{ dbt_utils.generate_surrogate_key(
                ['dates.date_id']
            ) 
        }} as date_sk,
        date,

        -- Year specific fields
        year,
        iso_year,
        year_start_date,
        year_end_date,
        year_day_number,
        year_offset,
        year_completed,

        -- Quarter specific fields
        quarter,
        quarter_start_date,
        quarter_end_date,
        quarter_day_number,
        quarter_offset,
        quarter_completed,

        -- Month specific fields
        month,
        month_start_date,
        month_end_date,
        month_name,
        month_name_short,
        month_initial,
        month_and_year,
        month_and_year_number,
        month_day_number,
        month_offset,
        month_completed,

        -- Week specific fields
        week,
        iso_week_of_year,
        week_start_date,
        week_end_date,
        week_day_number,
        week_offset,
        week_completed,
        iso_week_year_number,

        -- Holiday specific fields
        has_53_iso_weeks,
        coalesce(holiday_name, 'Not a holiday') as holiday_name,
        if(holiday_date is null, false, true) as is_holiday,
        coalesce(is_global_holiday, false) as is_global_holiday,
        coalesce(holiday_type, 'Not a holiday') as holiday_type,
        coalesce(fixed, false) as fixed,

        -- Day flags
        is_after_today,
        is_before_today,
        is_weekend,
        is_weekday
    from dates
    left join holidays
        on dates.date_id = holidays.date_holidays_id
)

select * from final
