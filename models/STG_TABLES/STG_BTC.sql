{{
    config(
        materialized='table'
    )
}}

WITH STG_BTC as (



    select * 
    FROM {{ source('BTC', 'BTC') }}
   
)
select * FROM STG_BTC