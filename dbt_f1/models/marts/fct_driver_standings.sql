{{ config(materialized='table') }}

with results as (select * from {{ ref('stg_standings') }})
select
    md5(season::text || '-' || driver_id) as standing_key,
    season,
    round_num,
    driver_id,
    championship_position,
    points,
    wins
from results
