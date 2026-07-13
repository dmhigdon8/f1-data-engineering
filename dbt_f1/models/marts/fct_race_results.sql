{{ config(materialized='table') }}

with results as (select * from {{ ref('stg_results') }})
select
    md5(season::text || '-' || round_num::text || '-' || driver_id) as result_key,
    md5(season::text || '-' || round_num::text)                     as race_key,
    season,
    round_num,
    race_name,
    race_date,
    driver_id,
    constructor_id,
    grid_position,
    finish_position,
    position_text,
    points,
    laps_completed,
    status,
    (status = 'Finished')                                            as is_finisher,
    (finish_position = 1)                                            as is_winner,
    (finish_position <= 3)                                           as is_podium,
    (finish_position <= 10)                                          as is_points_finish,
    finish_time,
    fastest_lap_rank,
    fastest_lap_time
from results
