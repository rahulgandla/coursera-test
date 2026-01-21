{% macro convert_to_usd(column_expr) %}
(
  {{ column_expr }} * (
    select price
    from {{ ref('btcusdmax') }}
    where to_date(replace(snapped_at,'UTC','')) = current_date()
    qualify row_number() over (order by snapped_at desc) = 1
  )
)
{% endmacro %}
