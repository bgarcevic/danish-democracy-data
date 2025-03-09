with 

renamed as (
    select
        id as case_step_status_id,
        status as case_step_status,
        opdateringsdato as case_step_status_updated_at,
        _dlt_load_id,
        _dlt_id
    from {{ source('danish_parliament', 'sagstrinsstatus') }}
)

select * from renamed
