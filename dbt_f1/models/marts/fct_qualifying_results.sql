{{ config(materialized='table') }}

with results as (select * from {{ ref('stg_qualifying') }})
select
    md5(season::text || '-' || round_num::text || '-' || driver_id) as result_key,
    md5(season::text || '-' || round_num::text)                     as race_key,
    season,
    round_num,
    race_name,
    race_date,
    driver_id,
    constructor_id,
    qualifying_position,
    q1_time,
    q2_time,
    q3_time
from results
