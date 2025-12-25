{{
    config(
        materialized='table'
    )
}}

WITH TRIPS as (

    select 
    RIDE_ID,
 RIDEABLE_TYPE,
DATE(TO_TIMESTAMP(STARTED_AT)) as TRIP_DATE,
START_STATIO_ID as START_STATION_ID,
 END_STATION_ID,
 MEMBER_CSUAL as  MEMBER_CASUAL,
--TimestampDIFF(second,TO_TIMESTAMP(STARTED_AT),TO_TIMESTAMP(ENDED_AT)) AS TRIP_DUARTION_SECONDS
timestampdiff(
            second,
            try_to_timestamp(started_at),
            try_to_timestamp(ended_at)
        ) as trip_duration_seconds


    FROM {{ source('demo', 'BIKE') }}
    where RIDE_ID!='RIDE_ID'
  and try_to_timestamp(started_at) is not null
      and try_to_timestamp(ended_at) is not null
)
select * FROM TRIPS
