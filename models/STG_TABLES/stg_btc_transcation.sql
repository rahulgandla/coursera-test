{{
    config(
        materialized='table'
       
    )
}}
select * FROM 
{{ ref('MART_BTC_APPEND') }}
where IS_COINBASE=false