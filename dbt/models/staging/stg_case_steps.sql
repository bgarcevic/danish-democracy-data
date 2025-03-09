with

renamed as (
    select
        id as case_step_id,
        folketingstidende as danish_parliament,
        folketingstidendesidenummer as danish_parliament_page_number,
        folketingstidendeurl as danish_parliament_url,
        opdateringsdato as case_step_updated_at,
        sagid as case_id,
        statusid as case_step_status_id,
        titel as case_step_title,
        typeid as case_step_type_id,
        _dlt_load_id,
        _dlt_id
    from {{ source('danish_parliament', 'sagstrin') }}
)

select * from renamed
