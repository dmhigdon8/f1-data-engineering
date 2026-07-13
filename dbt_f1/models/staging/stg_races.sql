-- Flatten the races payload: one row per race.
-- Jolpica shape: MRData.RaceTable.Races[ ]
{{ config(materialized='view') }}

with pages as (
    select payload
    from {{ source('raw', 'jolpica_payloads') }}
    where endpoint = 'races'
),
races as (
    select
        (race->>'season')::int                        as season,
        (race->>'round')::int                         as round_num,
        race->>'raceName'                             as race_name,
        race->'Circuit'->>'circuitId'                 as circuit_id,
        race->'Circuit'->>'circuitName'               as circuit_name,
        race->'Circuit'->'Location'->>'country'       as country,
        race->'Circuit'->'Location'->>'locality'      as locality,
        (race->>'date')::date                         as race_date,
        race->>'url'                                  as wiki_url
    from pages,
         jsonb_array_elements(payload->'pages')                 as page,
         jsonb_array_elements(page->'MRData'->'RaceTable'->'Races') as race
)
select distinct *
from races
