with

renamed as (
    select
        id as meeting_type_id,
        type as meeting_type,
        opdateringsdato as meeting_type_updated_at,
        _dlt_load_id,
        _dlt_id
    from {{ source('danish_parliament', 'm_detype') }}
)

select * from renamed
