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
CASE WHEN DAYNAME (TO_TIMESTAMP(STARTED_AT)) in ( 'Sat','Sun')
Then 'WEEKEND'
ELSE 'BUSINESSDAY'
END AS DAY_TYPE,
Case when MONTH (TO_TIMESTAMP(STARTED_AT)) in ( 12,1,2)
THEN 'WINTER'
WHEN   MONTH (TO_TIMESTAMP(STARTED_AT)) in ( 3,4,5)
THEN 'SPRING'
WHEN   MONTH (TO_TIMESTAMP(STARTED_AT)) in ( 6,7,8)
THEN 'SUMMER'
ELSE 'AUTUM'
END AS STATION_OF_YEAR


FROM 
{{ source('demo', 'BIKE') }}


  
)select * FROM CTE 
