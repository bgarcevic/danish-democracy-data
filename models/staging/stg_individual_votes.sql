with

source as (

    select * from {{ source('danish_parliament', 'raw_stemme') }}

),

renamed as (
    select
        id as individual_vote_id,
        afstemningid as vote_id,
        "aktørid" as member_id,
        opdateringsdato as updated_at,
        typeid as individual_voting_type_id,
        filename as file_name
    from source
)

select * from renamed
