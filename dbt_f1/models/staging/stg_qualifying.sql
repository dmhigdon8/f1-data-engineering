{{ config(materialized='view') }}

with pages as (
    select payload
    from {{ source('raw', 'jolpica_payloads') }}
    where endpoint = 'qualifying'
),
flattened as (
    select
        (race->>'season')::int                              as season,
        (race->>'round')::int                               as round_num,
        race->>'raceName'                                   as race_name,
        (race->>'date')::date                               as race_date,
        res->'Driver'->>'driverId'                          as driver_id,
        res->'Constructor'->>'constructorId'                as constructor_id,
        nullif(res->>'position', '')::int                   as qualifying_position,
        res->>'Q1'                                          as q1_time,
        res->>'Q2'                                          as q2_time,
        res->>'Q3'                                          as q3_time
    from pages,
         jsonb_array_elements(payload->'pages')                            as page,
         jsonb_array_elements(page->'MRData'->'RaceTable'->'Races')        as race,
         jsonb_array_elements(race->'QualifyingResults')                   as res
)
select *
from flattened
