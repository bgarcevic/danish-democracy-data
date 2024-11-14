with

renamed as (
    select
        id as case_category_id,
        kategori as case_category,
        opdateringsdato as case_category_updated_at,
        _dlt_load_id,
        _dlt_id
    from {{ source('danish_parliament', 'sagskategori') }}
)

select * from renamed
