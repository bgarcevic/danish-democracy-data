with

actors_source as (
    select {{ 
        dbt_utils.star(
            from=ref('stg_actors'), 
            except=[
                'first_name', 
                'last_name', 
                'biography', 
                'file_name', 
                'valid_from', 
                'valid_to', 
                'period_id'
            ]
        )
    }}
    from {{ ref('stg_actors') }}
), 

actor_types_source as (
    select {{ 
        dbt_utils.star(
            from=ref('stg_actor_types'), 
            except=['file_name']
        )
    }}
    from {{ ref('stg_actor_types') }}
),

final as (
    select
        -- key
        {{ dbt_utils.generate_surrogate_key(['actor_id']) }} as actor_sk,

        -- attributes
        actors_source.full_name,
        actors_source.gender,
        actors_source.birth_date,
        actors_source.death_date,
        actors_source.group_short_name,
        actors_source.party_name,
        actors_source.party_short_name,
        actor_types_source.actor_type,

        -- meta
        actors_source.updated_at
    from actors_source
    left join actor_types_source
        on actors_source.actor_type_id = actor_types_source.actor_type_id
)

select * from final
