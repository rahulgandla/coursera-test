{{
    config(
        materialized='incremental',incremental_strategy='append'
       
    )
}}

with MART as (
select * FROM 
{{ ref('INTR_BTC') }}

{% if is_incremental() %}
    -- this filter will only be applied on an incremental run
    where BLOCK_TIMESTAMP > (select max(BLOCK_TIMESTAMP) from {{ this }}) 
{% endif %}
 
)
select * FROM MART