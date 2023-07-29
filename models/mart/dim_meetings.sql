with

meetings as (
    select * from {{ ref('stg_meetings') }}
),

meeting_types as (
    select * from {{ ref('stg_meeting_types') }}
),

meeting_status as (
    select * from {{ ref('stg_meeting_statuses') }}
),

meetings as (
    select
        meetings.meeting_id as meeting_sk,
        meetings.meeting_date,
        meetings.meeting_room,
        meetings.meeting_number,
        meetings.public_code,
        meetings.meeting_period_id,
        meetings.meeting_start_time_note,
        meetings.meeting_title,
        meeting_types.meeting_type,
        meeting_status.meeting_status,
        meetings.meeting_updated_at
    from meetings
    left join meeting_types
        on meetings.meeting_type_id = meeting_types.meeting_type_id
    left join meeting_status
        on meetings.meeting_status_id = meeting_status.meeting_status_id
)

select * from meetings
