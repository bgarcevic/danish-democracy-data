with

renamed as (

    select
        id as actor_type_id,
        type as actor_type,
        opdateringsdato as updated_at,
        _dlt_load_id,
        _dlt_id
    from {{ source('danish_parliament', 'akt_rtype') }}

)

select * from renamed
