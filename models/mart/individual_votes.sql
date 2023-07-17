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

final as (
    select
        -- surrogate keys
        {{ dbt_utils.generate_surrogate_key(['individual_vote_id']) }} as individual_vote_sk,
        {{ dbt_utils.generate_surrogate_key(['vote_id']) }} as vote_sk,
        {{ dbt_utils.generate_surrogate_key(['actor_id']) }} as actor_sk,
        {{ dbt_utils.generate_surrogate_key(['individual_voting_type_id']) }} as individual_voting_type_sk,
        -- meta
        updated_at
    from individual_votes_source
)

select * from final