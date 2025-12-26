
    


WITH stg_bike AS (
  SELECT
    ride_id,
    replace (started_at,'"','') as  started_at,
    replace (ended_at,'"','') as ended_at,
    start_station_name,
    START_STATIO_ID as start_station_id,
    end_station_name,
    end_station_id,
    start_lat,
    start_lng,
    end_lat,
    end_lng,
    MEMBER_CSUAL as member_casual
FROM {{ source('demo', 'BIKE') }}
where RIDE_ID!='RIDE_ID'
AND TRY_TO_TIMESTAMP(started_at) IS NOT NULL
    AND TRY_TO_TIMESTAMP(ended_at) IS NOT NULL
  
)
SELECT * FROM stg_bike 

