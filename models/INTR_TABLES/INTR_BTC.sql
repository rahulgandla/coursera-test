{{
    config(
        materialized='table'
    )
}}

with INTR_BTC as (

     
    select distinct 
    t.HASH_KEY          ,
    t.BLOCK_HASH,
    t.BLOCK_NUMBER,
    t.BLOCK_TIMESTAMP,
    t.FEE,
    t.INPUT_VALUE,
    t.OUTPUT_VALUE,
    t.FEE_PER_BYTE,
    t.IS_COINBASE,
   f.value:address::string as addresss,
     CURRENT_TIMESTAMP()::TIMESTAMP_NTZ  AS ROW_CTD_DT,
      CURRENT_TIMESTAMP()::TIMESTAMP_NTZ  as ROW_MDF_DT
     FROM 
    {{ ref('STG_BTC') }}  T,
    lateral flatten (INPUT => t.OUTPUTS) f

)
select * FROm INTR_BTC 