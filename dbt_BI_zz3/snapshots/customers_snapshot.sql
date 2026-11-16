{% snapshot customers_snapshot %}

{{
    config(
        target_schema='snapshots',
        unique_key='customerid',
        strategy='timestamp',
        updated_at='updated_at',
        invalidate_hard_deletes=True
    )
}}

select * from {{ source('bronze', 'customers') }}

{% endsnapshot %}
