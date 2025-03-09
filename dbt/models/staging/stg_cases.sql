with

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
        afg_relsesresultatkode as case_decision_result_code,
        opdateringsdato as case_updated_at,
        statsbudgetsag as case_state_budget,
        begrundelse as case_reason,
        paragrafnummer as case_paragraph_number,
        paragraf as case_paragraph,
        afg_relsesdato as case_decision_date,
        afg_relse as case_decision,
        r_dsm_dedato as case_council_meeting_date,
        lovnummer as case_law_number,
        lovnummerdato as case_law_number_date,
        fremsatundersagid as case_proposed_under_case_id,
        deltundersagid as case_shared_case_id
    from {{ source('danish_parliament', 'sag') }}
)

select * from renamed
