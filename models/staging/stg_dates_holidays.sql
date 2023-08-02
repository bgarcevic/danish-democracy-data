with

source as (
    select * from {{ ref('publicholiday_dk') }}
),

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
    from source
)

select * from renamed
-- remove one random of the overlapping holiday as we only want one of them
qualify row_number() over (partition by holiday_date order by holiday_type desc) = 1