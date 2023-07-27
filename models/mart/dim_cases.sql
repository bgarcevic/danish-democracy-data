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

cases_source as (
    select * from {{ ref('stg_cases') }}
),

case_type_source as (
    select * from {{ ref('stg_case_types') }}
),

final as (
    select
        -- key
        {{ dbt_utils.generate_surrogate_key(
            ['case_steps_source.case_step_id']
        ) }} as case_sk,

        -- attributes
        case_type_source.case_type,
        cases_source.case_category_id,
        cases_source.case_status_id,
        cases_source.case_short_title,
        cases_source.case_number,
        cases_source.case_number_prefix,
        cases_source.case_number_numeric,
        cases_source.case_number_postfix,
        cases_source.case_period_id,
        cases_source.case_decision_result_code,
        cases_source.case_state_budget,
        cases_source.case_reason,
        cases_source.case_paragraph_number,
        cases_source.case_decision_date,
        cases_source.case_decision,
        case_step_statuses_source.case_step_status,
        case_steps_source.case_step_title,
        case_step_types_source.case_step_type,

        -- meta
        case_steps_source.case_step_updated_at,
        case_step_types_source.case_step_type_updated_at,
        case_step_statuses_source.case_step_status_updated_at,
        cases_source.case_updated_at
    from case_steps_source
    left join case_step_types_source
        on case_steps_source.case_step_type_id = case_step_types_source.case_step_type_id --noqa: LT05
    left join case_step_statuses_source
        on case_steps_source.case_step_status_id = case_step_statuses_source.case_step_status_id --noqa: LT05
    left join cases_source
        on case_steps_source.case_id = cases_source.case_id
    left join case_type_source
        on cases_source.case_type_id = case_type_source.case_type_id
)

select * from final
