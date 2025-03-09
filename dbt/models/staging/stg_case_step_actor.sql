with

renamed as (
    select
        id as case_step_actor_id,
        sagstrinid as case_step_id,
        akt_rid as actor_id,
        opdateringsdato as case_step_actor_updated_at,
        rolleid as role_id,
        _dlt_load_id,
        _dlt_id
    from {{ source('danish_parliament', 'sagstrin_akt_r') }}
)

select * from renamed
