with

source as (

    select * from {{ source('danish_parliament', 'raw_aktoer_type') }}

),

renamed as (

    select
        id as actor_type_id,
        type as actor_type,
        opdateringsdato as updated_at
    from source

)

select * from renamed
