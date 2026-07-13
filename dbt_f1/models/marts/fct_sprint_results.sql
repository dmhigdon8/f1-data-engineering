{{ config(materialized='table') }}

with results as (select * from {{ ref('stg_sprint_results') }})
select
    md5('sprint-' || season::text || '-' || round_num::text || '-' || driver_id) as result_key,
    md5(season::text || '-' || round_num::text)                                  as race_key,
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
    -- Sprints award points to top 8 (since 2022); 2021 awarded top 3.
    -- Using top 8 here as the modern convention; downstream can filter by season.
    (finish_position <= 8)                                           as is_points_finish,
    finish_time,
    fastest_lap_rank,
    fastest_lap_time
from results
