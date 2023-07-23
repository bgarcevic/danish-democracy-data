with

source as (

    select * from {{ source('danish_parliament', 'raw_moede_type') }}

),

renamed as (
    select
        id as meeting_type_id,
        type as meeting_type,
        opdateringsdato as meeting_type_updated_at,
        filename as file_name
    from source
)

select * from renamed
