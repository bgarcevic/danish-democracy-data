with

renamed as (
    select
        id as voting_type_id,
        opdateringsdato as voting_type_updated_at,
        type as voting_type,
        _dlt_load_id,
        _dlt_id
    from {{ source('danish_parliament', 'afstemningstype') }}
)

select * from renamed
