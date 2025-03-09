with

renamed as (
    select
        id as meeting_id,
        dagsordenurl as agenda_url,
        dato as meeting_date,
        lokale as meeting_room,
        nummer as meeting_number,
        offentlighedskode as public_code,
        opdateringsdato as meeting_updated_at,
        periodeid as meeting_period_id,
        starttidsbem_rkning as meeting_start_time_note,
        statusid as meeting_status_id,
        titel as meeting_title,
        typeid as meeting_type_id,
        _dlt_load_id,
        _dlt_id
    from {{ source('danish_parliament', 'm_de') }}
)

select * from renamed
