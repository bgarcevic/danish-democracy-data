with

source as (

    select * from {{ source('danish_parliament', 'raw_stemme') }}

),

renamed as (
    select
        id as individual_vote_id,
        afstemningsid as vote_id,
        aktørid as actor_id,
        opdateringsdato as updated_at,
        typeid as type_id,
        filename as file_name
    from source
)

select * from renamed
