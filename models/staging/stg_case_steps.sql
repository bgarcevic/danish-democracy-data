with

source as (

    select * from {{ source('danish_parliament', 'raw_sagstrin') }}

),

renamed as (
    select
        id as case_step_id,
        folketingstidende as danish_parliament,
        folketingstidendesidenummer as danish_parliament_page_number,
        folketingstidendeurl as danish_parliament_url,
        opdateringsdato as updated_at,
        sagid as case_id,
        statusid as status_id,
        titel as title,
        typeid as type_id,
        type as type,
        filename as file_name
    from source
)

select * from renamed
