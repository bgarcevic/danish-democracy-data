with

renamed as (
    select
        date as date_holidays_id,
        date as holiday_date,
        name as holiday_name,
        countrycode as country_code,
        fixed,
        global as is_global_holiday,
        type as holiday_type,
        counties
    from {{ ref('publicholiday_dk') }}
)

select * from renamed
