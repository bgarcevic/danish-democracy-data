with

votes_source as (
    select * from {{ ref('stg_votes') }}
),

voting_types_source as (
    select * from {{ ref('stg_voting_types') }}
),

final as (
    select
        -- key
        {{ dbt_utils.generate_surrogate_key(['vote_id']) }} as vote_sk,

        -- attributes
        votes_source.vote_number,
        votes_source.conclusion,
        votes_source.approved,
        votes_source.vote_comment,
        voting_types_source.voting_type,

        -- meta
        votes_source.votes_updated_at,
        voting_types_source.voting_type_updated_at,
    from votes_source
    left join voting_types_source
        on votes_source.voting_type_id = voting_types_source.voting_type_id
)

select * from final
