with

source as (

    select * from {{ source('danish_parliament', 'raw_stemme_type') }}

),

renamed as (
    select
        id as individual_voting_type_id,
        type as individual_voting_type,
        filename as file_name
    from source
)

select * from renamed
