{#
    Journal d'exécution des modèles dans training.dbt_execution_logs.

    - create_execution_log_table() : appelée en on-run-start, crée la table si besoin.
    - log_model_execution(action)  : appelée en pre-hook ('start') et post-hook ('end')
                                     sur chaque modèle.
#}

{% macro create_execution_log_table() %}
    create table if not exists training.dbt_execution_logs (
        id          int          not null auto_increment primary key,
        model_name  varchar(255) not null,
        action      varchar(5)   not null,
        inserted_at timestamp    not null default current_timestamp
    )
{% endmacro %}

{% macro log_model_execution(action) %}
    insert into training.dbt_execution_logs (model_name, action, inserted_at)
    values ('{{ this.name }}', '{{ action }}', current_timestamp)
{% endmacro %}
