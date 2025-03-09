{% snapshot votes_snapshot %}

{{
    config(
      target_schema='snapshots',
      unique_key='id',
      strategy='timestamp',
      updated_at='opdateringsdato',
    )
}}

select * from {{ source('danish_parliament', 'afstemning') }} --noqa:LT02

qualify row_number() over (partition by id order by opdateringsdato desc) = 1 --noqa:PRS

{% endsnapshot %}
