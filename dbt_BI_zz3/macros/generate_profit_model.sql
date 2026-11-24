{#
    Génère un modèle de profit agrégé par date de vente, converti en euros.

    Paramètres :
      - table_name : nom de la table dans la source 'training' (ex. 'sales_us')
      - eur_rate   : taux de conversion de la devise locale vers l'euro
                     (ex. var('eur_rate_us'))

    Exemple : {{ generate_profit_model('sales_us', var('eur_rate_us')) }}
#}
{% macro generate_profit_model(table_name, eur_rate) -%}
select
    sales_date,
    sum(quantity_sold)                                                              as total_quantity,
    round(sum(quantity_sold * unit_sell_price))               as total_revenue,
    round(sum(quantity_sold * unit_purchase_cost))              as total_cost,
    round(sum(quantity_sold * (unit_sell_price - unit_purchase_cost))) as total_profit,
    round(sum(quantity_sold * (unit_sell_price - unit_purchase_cost)) * {{ eur_rate }}, 2) as total_profit_eur
from {{ source('training', table_name) }}
group by sales_date
order by sales_date
{%- endmacro %}
