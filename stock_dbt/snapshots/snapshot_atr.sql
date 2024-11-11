{% snapshot snapshot_atr %}

{{
  config(
    target_schema='snapshot',
    unique_key='date',
    strategy='timestamp',
    updated_at='date',
    invalidate_hard_deletes=True
  )
}}

SELECT * FROM {{ ref('avg_true_range') }}

{% endsnapshot %}