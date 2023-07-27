with

case_steps_source as (
    select * from {{ ref('stg_case_steps') }}
),

case_step_types_source as (
    select * from {{ ref('stg_case_step_types') }}
),

case_step_statuses_source as (
    select * from {{ ref('stg_case_step_statuses') }}
),

cases as (
    select * from {{ ref('stg_cases') }}
),

final as (
    select
        -- key
        {{ dbt_utils.generate_surrogate_key(
            ['case_steps_source.case_step_id']
        ) }} as case_sk,

        -- attributes
        cases.case_type_id,
        cases.case_category_id,
        case_status_id,
        cases.case_short_title,
        cases.case_number,
        cases.case_number_prefix,
        cases.case_number_numeric,
        cases.case_number_postfix,
        cases.case_period_id,
        cases.case_decision_result_code,
        cases.case_state_budget,
        cases.case_reason,
        cases.case_paragraph_number,
        cases.case_decision_date,
        cases.case_decision,
        case_step_statuses_source.case_step_status,
        case_steps_source.case_step_title,
        case_step_types_source.case_step_type,

        -- meta
        case_steps_source.case_step_updated_at,
        case_step_types_source.case_step_type_updated_at,
        case_step_statuses_source.case_step_status_updated_at,
        cases.case_updated_at
    from case_steps_source
    left join case_step_types_source
        on case_steps_source.case_step_type_id = case_step_types_source.case_step_type_id
    left join case_step_statuses_source
        on case_steps_source.case_step_status_id = case_step_statuses_source.case_step_status_id
    left join cases
        on case_steps_source.case_id = cases.case_id
)

select * from final
where case_state_budget = 'true'