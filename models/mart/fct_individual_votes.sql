with

individual_votes_source as (
    select * from {{ ref('stg_individual_votes') }}
),

votes_source as (
    select * from {{ ref('stg_votes') }}
),

final as (
    select
        -- surrogate keys
        {{ dbt_utils.generate_surrogate_key(
                ['individual_votes_source.individual_vote_id']
            ) 
        }} as individual_vote_sk,
        {{ dbt_utils.generate_surrogate_key(
                ['individual_votes_source.vote_id']
            ) 
        }} as vote_sk,
        {{ dbt_utils.generate_surrogate_key(
                ['individual_votes_source.actor_id']
            ) 
        }} as actor_sk,
        {{ dbt_utils.generate_surrogate_key(
                ['individual_votes_source.individual_voting_type_id']
            )
        }} as individual_voting_type_sk,
        {{ dbt_utils.generate_surrogate_key(
                ['votes_source.meeting_id']
            ) 
        }} as meeting_sk,
        -- meta
        individual_votes_source.individual_votes_updated_at
    from individual_votes_source
    left join votes_source
        on individual_votes_source.vote_id = votes_source.vote_id
)

select * from final
