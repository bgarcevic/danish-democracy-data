with 

renamed as (
    select
        id as individual_voting_type_id,
        type as individual_voting_type,
        _dlt_load_id,
        _dlt_id
    from {{ source('danish_parliament', 'stemmetype') }}
)

select * from renamed
