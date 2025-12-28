{{
    config(
        materialized='table'
    )
}}

with CTE As 
(
select 

to_timestamp(started_at) as STARTED_AT,
date(to_timestamp(started_at)) as DATE_STARTED_AT,
HOUR(TO_TIMESTAMP(started_at)) as HOUR_STARTED_AT, 

{{day_type('started_at')}} AS DAY_TYPE,

{{get_season('started_at')}} AS STATION_OF_YEAR

FROM 
{{ ref('Stg_bike') }}


  
)select * FROM CTE 
