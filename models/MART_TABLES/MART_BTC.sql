{{ config(
    materialized = 'incremental',
    incremental_strategy = 'merge',
  unique_key=['HASH_KEY', 'OUTPUT_ADDRESSS'],
) }}

SELECT
distinct  *
FROM {{ ref('INTR_BTC') }}

{% if is_incremental() %}
WHERE BLOCK_TIMESTAMP >= (
  SELECT max(BLOCK_TIMESTAMP)
  FROM {{ this }}
)
{% endif %}