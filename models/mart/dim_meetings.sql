with

meetings_source as (
    select * from {{ ref('stg_meetings') }}
),

meeting_types_source as (
    select * from {{ ref('stg_meeting_types') }}
),

meeting_status_source as (
    select * from {{ ref('stg_meeting_statuses') }}
),

meetings as (
    select
        meetings_source.meeting_id as meeting_sk,
        meetings_source.meeting_date,
        meetings_source.meeting_room,
        meetings_source.meeting_number,
        meetings_source.public_code,
        meetings_source.meeting_period_id,
        meetings_source.meeting_start_time_note,
        meetings_source.meeting_title,
        meeting_types_source.meeting_type,
        meeting_status_source.meeting_status,
        meetings_source.meeting_updated_at
    from meetings_source
    left join meeting_types_source
        on meetings_source.meeting_type_id = meeting_types_source.meeting_type_id --noqa: LT05
    left join meeting_status_source
        on meetings_source.meeting_status_id = meeting_status_source.meeting_status_id --noqa: LT05
)

select * from meetings
