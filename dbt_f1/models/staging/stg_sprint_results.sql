{{ config(materialized='view') }}

with pages as (
    select payload
    from {{ source('raw', 'jolpica_payloads') }}
    where endpoint = 'sprint'
),
flattened as (
    select
        (race->>'season')::int                              as season,
        (race->>'round')::int                               as round_num,
        race->>'raceName'                                   as race_name,
        (race->>'date')::date                               as race_date,
        res->'Driver'->>'driverId'                          as driver_id,
        res->'Constructor'->>'constructorId'                as constructor_id,
        (res->>'grid')::int                                 as grid_position,
        nullif(res->>'position', '')::int                   as finish_position,
        res->>'positionText'                                as position_text,
        (res->>'points')::numeric                           as points,
        (res->>'laps')::int                                 as laps_completed,
        res->>'status'                                      as status,
        res->'Time'->>'time'                                as finish_time,
        (res->'FastestLap'->>'rank')::int                   as fastest_lap_rank,
        res->'FastestLap'->'Time'->>'time'                  as fastest_lap_time
    from pages,
         jsonb_array_elements(payload->'pages')                            as page,
         jsonb_array_elements(page->'MRData'->'RaceTable'->'Races')        as race,
         jsonb_array_elements(race->'SprintResults')                       as res
)
select *
from flattened
