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

individual_votes as (
    select * from {{ ref('fct_individual_votes') }}
),

joins as (
    select * 
    from individual_votes
    left join votes
        on individual_votes.vote_sk = votes.vote_sk
    left join actors
        on individual_votes.actor_sk = actors.actor_sk
    left join meetings
        on individual_votes.meeting_sk = meetings.meeting_sk
    left join cases
        on individual_votes.case_sk = cases.case_sk
)

select * from joins