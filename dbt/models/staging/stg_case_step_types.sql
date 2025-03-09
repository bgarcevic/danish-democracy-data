with

renamed as (
    select
        id as case_step_type_id,
        type as case_step_type,
        opdateringsdato as case_step_type_updated_at,
        _dlt_load_id,
        _dlt_id
    from {{ source('danish_parliament', 'sagstrinstype') }}
)

select * from renamed
