with

renamed as (
    select
        id as vote_id,
        nummer as vote_number,
        konklusion as conclusion,
        vedtaget as approved,
        kommentar as vote_comment,
        m_deid as meeting_id,
        typeid as voting_type_id,
        sagstrinid as case_step_id,
        opdateringsdato as votes_updated_at,
        _dlt_load_id,
        _dlt_id
    from {{ source('danish_parliament', 'afstemning') }}
)

select * from renamed
