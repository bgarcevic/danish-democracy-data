with renamed as (
    select
        id as period_id,
        startdato as period_start_date,
        slutdato as period_end_date,
        type as period_type,
        kode as period_code,
        titel as period_title,
        opdateringsdato as period_updated_at,
        _dlt_load_id,
        _dlt_id
    from {{ source('danish_parliament', 'periode') }}
)

select * from renamed
