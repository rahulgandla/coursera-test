{{
    config(
        materialized='table'
    )
}}
WITH BIKE AS (

    select 
    distinct 
    start_station_id as STATION_ID, 
    START_STATION_NAME as STATION_NAME  ,
    START_LAT as STATION_LAT,
    START_LNG as STATION_LNG
    FROM {{ ref('Stg_bike') }}
where RIDE_ID!='RIDE_ID'

)
select * FROM BIKE