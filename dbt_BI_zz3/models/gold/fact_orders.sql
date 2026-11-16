{# Nombre de commandes et montant total par consommateur, employé, magasin et statut #}
select
    o.customerid,
    o.employeeid,
    o.storeid,
    o.status,
    o.status_description,
    count(distinct o.orderid)   as nb_commandes,
    sum(oi.totalprice)          as total_commandes
from {{ ref('orders') }} o
join {{ ref('orders_items') }} oi
    on o.orderid = oi.orderid
group by
    o.customerid,
    o.employeeid,
    o.storeid,
    o.status,
    o.status_description
