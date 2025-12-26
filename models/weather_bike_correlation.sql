With CTE AS (

    select 
    t.*,
   w.* 
     FROM 
    {{ ref('trip_fact') }} t
    LEFT JOIN {{ ref('daily_weather') }}w
    ON t.TRIP_DATE=w.DAILY_WEATHER
    
)
select * FROM CTE