{{config(materialized='view')}}

select
    orderid,
    productid,
    unitprice,
    quantity,
    unitprice * quantity as totalprice,
    updated_at
from {{ source('bronze', 'orderitems') }}