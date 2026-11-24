{#
    Contrôle de volumétrie des tables du schéma bronze.
    Pour chaque table : nombre de lignes, seuil minimum attendu, et statut.

    ➜ Renseigne les seuils (min_rows) dans le dictionnaire ci-dessous.
      Le test associé (models/bronze/bronze.yml) échoue si row_count < min_rows.
#}
{%- set thresholds = {
    'customers':  50,
    'employees':  20,
    'products':   100,
    'stores':     10,
    'orders':     200,
    'orderitems': 1000,
    'suppliers':   5

} -%}

{% for table, expected_count in thresholds.items() %}
select
    '{{ table }}'                                         as table_name,
    (select count(*) from {{ source('bronze', table) }})  as record_count,
    {{ expected_count }}                                  as expected_count
from dual
    where (select count(*) from {{ source('bronze', table) }}) < {{ expected_count }}
{% if not loop.last %}union all{% endif %}
{% endfor %}
