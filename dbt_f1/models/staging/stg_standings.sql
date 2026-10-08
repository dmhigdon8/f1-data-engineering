{{ config(materialized='view') }}

with pages as (
    select payload
    from {{ source('raw', 'jolpica_payloads') }}
    where endpoint = 'standings'
),
flattened as (
    select
        (standing_list->>'season')::int        as season,
        (standing_list->>'round')::int         as round_num,
        standing->'Driver'->>'driverId'        as driver_id,
        nullif(standing->>'position', '')::int as championship_position,
        (standing->>'points')::numeric         as points,
        (standing->>'wins')::int               as wins
    from pages,
         jsonb_array_elements(payload->'pages')                                   as page,
         jsonb_array_elements(page->'MRData'->'StandingsTable'->'StandingsLists') as standing_list,
         jsonb_array_elements(standing_list->'DriverStandings')                   as standing
)
select *
from flattened
