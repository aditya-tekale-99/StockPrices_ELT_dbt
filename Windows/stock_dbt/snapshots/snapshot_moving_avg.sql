{% snapshot snapshot_moving_avg %}

{{
  config(
    target_schema='snapshot',
    unique_key='date',
    strategy='timestamp',
    updated_at='date',
    invalidate_hard_deletes=True
  )
}}

SELECT * FROM {{ ref('moving_average') }}

{% endsnapshot %}