{{
    config(
        materialized='table'
    )
}}

with CTE As 
(
select 

to_timestamp(STARTED_AT) as STARTED_AT,
date(to_timestamp(STARTED_AT)) as DATE_STARTED_AT,
HOUR(TO_TIMESTAMP(STARTED_AT)) as HOUR_STARTED_AT, 

{{day_type('STARTED_AT')}} AS DAY_TYPE,

{{get_season('STARTED_AT')}} AS STATION_OF_YEAR

FROM 
{{ source('demo', 'BIKE') }}


  
)select * FROM CTE 
