with

source as (

    select * from {{ source('danish_parliament', 'raw_sagstype') }}

),

renamed as (
    select
        id as case_type_id,
        type as case_type,
        opdateringsdato as case_type_updated_at,
        filename as file_name
    from source
)

select * from renamed
