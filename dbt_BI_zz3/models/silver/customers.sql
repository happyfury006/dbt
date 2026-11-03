{{ config(materialized='view') }}

select
    customerid,
    upper(firstname)                            as firstname,
    lastname,
    concat(upper(firstname), ' ', lastname)     as fullname,
    email,
    phone,
    address,
    city,
    state,
    zipcode,
    updated_at
from {{ source('bronze', 'customers') }}
