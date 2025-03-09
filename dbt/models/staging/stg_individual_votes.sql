with

renamed as (
    select
        id as individual_vote_id,
        afstemningid as vote_id,
        akt_rid as actor_id,
        opdateringsdato as individual_votes_updated_at,
        typeid as individual_voting_type_id,
        _dlt_load_id,
        _dlt_id
    from {{ source('danish_parliament', 'stemme') }}
)

select * from renamed
