with

votes as (
    select * from {{ ref('stg_votes') }}
),

voting_types as (
    select * from {{ ref('stg_voting_types') }}
),

final as (
    select
        -- key
        {{ dbt_utils.generate_surrogate_key(['vote_id']) }} as vote_sk,

        -- attributes
        votes.vote_number,
        votes.approved,
        votes.vote_comment,
        voting_types.voting_type,

        -- meta
        votes.votes_updated_at,
        voting_types.voting_type_updated_at
    from votes
    left join voting_types
        on votes.voting_type_id = voting_types.voting_type_id
)

select * from final
