with

case_steps_source as (
    select * from {{ ref('stg_case_steps') }}
),

final as (
    select
        -- key
        {{ dbt_utils.generate_surrogate_key(
            ['case_steps_source.case_step_id']
        ) }} as case_sk,

        -- attributes
        case_steps_source.case_id,
        case_steps_source.case_step_status_id,
        case_steps_source.case_step_title,
        case_steps_source.case_step_type_id,

        -- meta
        case_steps_source.case_step_updated_at
    from case_steps_source
)

select * from final
