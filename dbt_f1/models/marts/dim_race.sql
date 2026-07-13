{{ config(materialized='table') }}

select
    season,
    round_num,
    race_name,
    circuit_id,
    circuit_name,
    country,
    locality,
    race_date,
    wiki_url,
    md5(season::text || '-' || round_num::text) as race_key
from {{ ref('stg_races') }}
