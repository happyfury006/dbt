{# Analyse : montant total des ventes par identifiant de magasin #}
select
    o.storeid,
    count(distinct o.orderid)  as nb_commandes,
    sum(oi.quantity)           as quantite_totale,
    sum(oi.totalprice)         as montant_total
from {{ ref('orders') }} o
join {{ ref('orders_items') }} oi
    on o.orderid = oi.orderid
group by o.storeid
order by montant_total desc
