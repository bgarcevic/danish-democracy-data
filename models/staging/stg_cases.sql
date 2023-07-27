with

source as (

    select * from {{ source('danish_parliament', 'raw_sag') }}

),

renamed as (
    select
        id as case_id,
        typeid as case_type_id,
        kategoriid as case_category_id,
        statusid as case_status_id,
        titel as case_title,
        titelkort as case_short_title,
        offentlighedskode as case_public_code,
        nummer as case_number,
        nummerprefix as case_number_prefix,
        nummernumerisk as case_number_numeric,
        nummerpostfix as case_number_postfix,
        resume as case_summary,
        afstemningskonklusion as case_voting_conclusion,
        periodeid as case_period_id,
        "afgørelsesresultatkode" as case_decision_result_code,
        baggrundsmateriale as case_background_material,
        opdateringsdato as case_updated_at,
        statsbudgetsag as case_state_budget,
        begrundelse as case_reason,
        paragrafnummer as case_paragraph_number,
        "afgørelsesdato" as case_decision_date,
        "afgørelse" as case_decision
    from source
)

select * from renamed
