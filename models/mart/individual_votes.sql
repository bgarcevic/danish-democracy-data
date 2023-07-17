with

individual_votes_source as (
    select {{ 
        dbt_utils.star(
            from=ref('stg_individual_votes'), 
            except=['file_name']
        )
    }} 
    from {{ ref('stg_individual_votes') }}
),

individual_voting_types_source as (
    select {{ 
        dbt_utils.star(
            from=ref('stg_individual_voting_types'), 
            except=['file_name']
        )
    }} 
    from {{ ref('stg_individual_voting_types') }}
),

final as (
    select
        -- surrogate keys
        {{ dbt_utils.generate_surrogate_key(['individual_vote_id']) }} as individual_vote_sk,
        {{ dbt_utils.generate_surrogate_key(['vote_id']) }} as vote_sk,
        {{ dbt_utils.generate_surrogate_key(['actor_id']) }} as actor_sk,
        individual_voting_types_source.individual_voting_type
        -- meta
        updated_at
    from individual_votes_source
    left join individual_voting_types_source
        on individual_votes_source.individual_voting_type_id = individual_voting_types_source.individual_voting_type_id
)

select * from final