with

source as (

    select * from {{ source('danish_parliament', 'raw_aktør') }}

),

renamed as (

    select
        id as member_id,
        typeid as type_id,
        gruppenavnkort as group_short_name,
        navn as name,
        fornavn as first_name,
        efternavn as last_name,
        biografi as biography,
        periodeid as period_id,
        opdateringsdato as updated_at,
        startdato as start_date,
        slutdato as end_date,
        filename as file_name
    from source
    
)

select * from renamed
