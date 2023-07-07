with 

source as (

    select * from {{ source('danish_parliament', 'raw_afstemning') }}

),

renamed as (
    select 
        id as vote_id,
        nummer as vote_number,
        konklusion as conclusion,
        vedtaget as approved,
        kommentar as comment,
        mødeid as meeting_id,
        typeid as type_id,
        sagsstrinid as case_step_id,
        opdateringsdato as updated_at,
        filename as file_name
    from source 
)

select * from renamed
