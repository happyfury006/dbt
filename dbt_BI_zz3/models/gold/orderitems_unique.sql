{{ dbt_utils.deduplicate(
    relation=source('bronze', 'orderitems'),
    partition_by='orderid, productid',
    order_by='updated_at desc, orderitemid desc'
) }}
