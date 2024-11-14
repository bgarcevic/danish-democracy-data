with

renamed as (
    select
        id as case_type_id,
        type as case_type,
        opdateringsdato as case_type_updated_at,
        _dlt_load_id,
        _dlt_id
    from {{ source('danish_parliament', 'sagstype') }}
)

select * from renamed
