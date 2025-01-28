
 {{config(
    materialized="table"
 )}}
 
  with Cust as (
      select CUSTOMER_ID, min(ORDER_DATE) as first_order_date
      from DATA_S.PUBLIC.customer_orders
      group by CUSTOMER_ID
  ),
  CTE as (
      select
          co.order_date,
          co.ORDER_AMOUNT,
          sum(case when co.order_date = c.first_order_date then 1 else 0 end) as new_customer_count,
          sum(case when co.order_date <> c.first_order_date then 1 else 0 end) as repeat_customer_count
      from DATA_S.PUBLIC.customer_orders co
      inner join Cust c
      on co.customer_id = c.customer_id
      group by co.order_date, co.ORDER_AMOUNT
  )
  select * from CTE


