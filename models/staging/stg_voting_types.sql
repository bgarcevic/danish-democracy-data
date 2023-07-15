with

source as (

    select * from {{ source('danish_parliament', 'raw_afstemningstype') }}

),

renamed as (
    select
        id as voting_type_id,
        opdateringsdato as updated_at,
        type as voting_type,
        filename as file_name
    from source
)

select * from renamed
