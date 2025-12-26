{{
    config(
        materialized='table'
    )
}}

WITH DAILY_WEATHER AS (

    select 
date(TIME) as DAILY_WEATHER,
WEATHER,
TEMP,
PRESSURE,
HUMIDITY,
CLOUDS
    FROM 
    {{ source('demo', 'WEATHER') }}
   
)
, 
DAILY_WEATHER_AGG AS (

    select DAILY_WEATHER
    ,WEATHER,

round(avg(TEMP),2) as avg_temp ,
round( avg(PRESSURE),2) as avg_PRESSURE,
round(avg(HUMIDITY),2) as avg_HUMIDITY,
round(avg(CLOUDS),2) as avg_CLOUDS
    
    FROM DAILY_WEATHER
    group by DAILY_WEATHER,WEATHER
    qualify row_number() OVER(partition by DAILY_WEATHER order by count(WEATHER) desc)=1
)
select * FROM DAILY_WEATHER_AGG 
--order by DAILY_WEATHER