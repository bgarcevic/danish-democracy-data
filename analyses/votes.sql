with

votes as (
    select * from {{ ref('dim_votes') }}
),

actors as (
    select * from {{ ref('dim_actors') }}
),

meetings as (
    select * from {{ ref('dim_meetings') }}
),

cases as (
    select * from {{ ref('dim_cases') }}
),

dates as (
    select * from {{ ref('dim_dates') }}
),

individual_voting_types as (
    select * from {{ ref('stg_individual_voting_types') }}
),

individual_votes as (
    select * from {{ ref('fct_individual_votes') }}
),


joins as (
    select
        votes.* exclude (vote_sk),
        actors.* exclude (actor_sk),
        meetings.* exclude (meeting_sk),
        cases.* exclude (case_sk),
        dates.* exclude (date_sk)
    from individual_votes
    left join votes
        on individual_votes.vote_sk = votes.vote_sk
    left join actors
        on individual_votes.actor_sk = actors.actor_sk
    left join meetings
        on individual_votes.meeting_sk = meetings.meeting_sk
    left join cases
        on individual_votes.case_sk = cases.case_sk
    left join dates
        on individual_votes.date_sk = dates.date_sk
    left join individual_voting_types
        on
            individual_votes.individual_voting_type_sk
            = individual_voting_types.individual_voting_type_sk
)

select * from joins
