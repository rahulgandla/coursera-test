{{
    config(
        materialized='table'
    )
}}
WITH BIKE AS (

    select 
    distinct 
    START_STATIO_ID as STATION_ID, 
    START_STATION_NAME as STATION_NAME  ,
    START_LAT as STATION_LAT,
    START_LNG as STATION_LNG
    FROM 
{{ source('demo', 'BIKE') }}
where RIDE_ID!='RIDE_ID'

)
select * FROM BIKE