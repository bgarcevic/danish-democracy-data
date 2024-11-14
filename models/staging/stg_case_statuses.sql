with

renamed as (
    select
        id as case_status_id,
        status as case_status,
        opdateringsdato as case_status_updated_at,
        _dlt_load_id,
        _dlt_id
    from {{ source('danish_parliament', 'sagsstatus') }}
)

select * from renamed
