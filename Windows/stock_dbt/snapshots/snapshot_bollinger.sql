{% snapshot snapshot_bollinger %}

{{
  config(
    target_schema='snapshot',
    unique_key='date',
    strategy='timestamp',
    updated_at='date',
    invalidate_hard_deletes=True
  )
}}

SELECT * FROM {{ ref('bollinger') }}

{% endsnapshot %}