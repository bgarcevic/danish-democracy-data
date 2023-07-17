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
    from {{ ref('stg_actors') }}
), 

final as (
    select
        -- key
        {{ dbt_utils.generate_surrogate_key(['vote_id']) }} as actor_sk,

        -- attributes
        *

        -- meta
        votes_source.updated_at
    from votes_source
)

select * from final
