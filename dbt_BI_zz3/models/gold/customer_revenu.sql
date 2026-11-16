{# Nombre de commandes et revenu généré par consommateur #}
select
    c.customerid,
    c.fullname,
    count(distinct o.orderid)       as nb_commandes,
    coalesce(sum(oi.totalprice), 0) as revenu
from {{ ref('customers') }} c
left join {{ ref('orders') }} o
    on c.customerid = o.customerid
left join {{ ref('orders_items') }} oi
    on o.orderid = oi.orderid
group by
    c.customerid,
    c.fullname
