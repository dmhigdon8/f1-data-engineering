{{ config(materialized='view') }}

with pages as (
    select payload
    from {{ source('raw', 'jolpica_payloads') }}
    where endpoint = 'results'
),
constructors as (
    select
        res->'Constructor'->>'constructorId' as constructor_id,
        res->'Constructor'->>'name'          as constructor_name,
        res->'Constructor'->>'nationality'   as nationality,
        res->'Constructor'->>'url'           as wiki_url
    from pages,
         jsonb_array_elements(payload->'pages')                     as page,
         jsonb_array_elements(page->'MRData'->'RaceTable'->'Races') as race,
         jsonb_array_elements(race->'Results')                      as res
)
select distinct *
from constructors
