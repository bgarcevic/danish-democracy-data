with

renamed as (
    select
        id as meeting_status_id,
        status as meeting_status,
        opdateringsdato as meeting_status_updated_at,
        _dlt_load_id,
        _dlt_id
    from {{ source('danish_parliament', 'm_destatus') }}
)

select * from renamed
