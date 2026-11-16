{# Chiffre d'affaires par magasin comparé à son objectif de ventes (seed salestarget) #}
with ventes as (
    select
        storeid,
        sum(total_commandes) as total_commandes
    from {{ ref('fact_orders') }}
    group by storeid
)

select
    v.storeid,
    v.total_commandes,
    s.salestarget                          as store_target,
    v.total_commandes - s.salestarget      as ecart_target,
    v.total_commandes / s.salestarget      as taux_atteinte
from ventes v
join {{ ref('salestarget') }} s
    on v.storeid = s.storeid
