with

votes_source as (
    select {{ 
        dbt_utils.star(
            from=ref('stg_votes'), 
            except=[ 
                'file_name'
            ]
        )
    }}
    from {{ ref('stg_votes') }}
), 

meetings_source as (
    select {{ 
        dbt_utils.star(
            from=ref('stg_meetings'), 
            except=[ 
                'file_name'
            ]
        )
    }}
    from {{ ref('stg_meetings') }}
), 

voting_types_source as (
    select {{ 
        dbt_utils.star(
            from=ref('stg_voting_types'), 
            except=[ 
                'file_name'
            ]
        )
    }}
    from {{ ref('stg_voting_types') }}
),

case_steps_source as (
    select {{ 
        dbt_utils.star(
            from=ref('stg_case_steps'), 
            except=[ 
                'file_name'
            ]
        )
    }}
    from {{ ref('stg_case_steps') }}
),

final as (
    select
        -- key
        {{ dbt_utils.generate_surrogate_key(['vote_id']) }} as vote_sk,

        -- attributes
        votes_source.vote_number,
        votes_source.conclusion,
        votes_source.approved,
        votes_source.comment,
        meetings_source.agenda_url,
        meetings_source.meeting_date,
        meetings_source.meeting_room,
        meetings_source.meeting_number,
        meetings_source.public_code,
        meetings_source.meeting_period_id,
        meetings_source.meeting_start_time_note,
        meetings_source.meeting_status_id,
        meetings_source.meeting_title,
        meetings_source.type_id,
        voting_types_source.voting_type,
        case_steps_source.case_id,
        case_steps_source.status_id,
        case_steps_source.title,
        case_steps_source.type_id,
        
        -- meta
        votes_source.votes_updated_at,
        meetings_source.meeting_updated_at,
        voting_types_source.voting_type_updated_at,
        case_steps_source.case_step_updated_at
    from votes_source
    left join meetings_source
        on votes_source.meeting_id = meetings_source.meeting_id
    left join voting_types_source
        on votes_source.voting_type_id = voting_types_source.voting_type_id
    left join case_steps_source
        on votes_source.case_step_id = case_steps_source.case_step_id
)

select * from final
