
with WHALES as (
select output_addresss,sum(output_value) as total_sent,
count(*) as Tx_count
FROM 
{{ ref('stg_btc_transcation') }}

where output_addresss is not null
group by 1
)

select 
w.output_addresss,
w.total_sent,
w.Tx_count,

{{ convert_to_usd('w.total_sent') }} as total_sent_usd


  FROM WHALES w
 
order by total_sent desc