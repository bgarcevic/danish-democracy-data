with

renamed as (

    select
        id as actor_id,
        typeid as actor_type_id,
        gruppenavnkort as group_short_name,
        navn as full_name,
        fornavn as first_name,
        efternavn as last_name,
        biografi as biography,
        periodeid as period_id,
        opdateringsdato as updated_at,
        startdato as valid_from,
        slutdato as valid_to,
        _dlt_load_id,
        _dlt_id,
        substring(
            biografi,
            position('<sex>' in biografi) + length('<sex>'),
            position('</sex>' in biografi)
            - position('<sex>' in biografi)
            - length('<sex>')
        ) as gender,
        try_strptime(substring(
            biografi,
            position('<born>' in biografi) + length('<born>'),
            position('</born>' in biografi)
            - position('<born>' in biografi)
            - length('<born>')
        ), '%d-%m-%Y') as birth_date,
        try_strptime(substring(
            biografi, position('<died>' in biografi) + length('<died>'),
            position('</died>' in biografi)
            - position('<died>' in biografi)
            - length('<died>')
        ), '%d-%m-%Y') as death_date,
        substring(
            biografi,
            position('<party>' in biografi) + length('<party>'),
            position('</party>' in biografi)
            - position('<party>' in biografi)
            - length('<party>')
        ) as party_name,
        substring(
            biografi,
            position('<partyShortname>' in biografi)
            + length('<partyShortname>'),
            position('</partyShortname>' in biografi)
            - position('<partyShortname>' in biografi)
            - length('<partyShortname>')
        ) as party_short_name,
        _dlt_load_id,
        _dlt_id
    from {{ source('danish_parliament', 'akt_r') }}

)

select * from renamed
