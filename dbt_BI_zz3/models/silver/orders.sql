{{config(materialized='view')}}

select 
    orderid,
    customerid,
    orderdate,
    employeeid,
    storeid,
    status,
    case status
        when 1 then 'En cours'
        when 2 then 'Terminée'
        when 3 then 'Annulée'
    end as status_description,
    updated_at
from {{ source('bronze', 'orders') }}