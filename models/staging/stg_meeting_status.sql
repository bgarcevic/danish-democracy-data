with

source as (

    select * from {{ source('danish_parliament', 'raw_møde_type') }}

),

renamed as (
    select
        id as meeting_type_id,
        type as meeting_status,
        opdateringsdato as meeting_status_updated_at,
        filename as file_name
    from source
)

select * from renamed
