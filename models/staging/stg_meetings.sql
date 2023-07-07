with

source as (

    select * from {{ source('danish_parliament', 'raw_møde') }}

),

renamed as (
    select
        id as meeting_id,
        dagsordenurl as agenda_url,
        dato as date,
        lokale as room,
        nummer as number,
        offentlighedskode as public_code,
        opdateringsdato as updated_at,
        periodeid as period_id,
        starttidsbemærkning as start_time_note,
        statusid as status_id,
        titel as title,
        typeid as type_id,
        filename as file_name
    from source
)

select * from renamed
