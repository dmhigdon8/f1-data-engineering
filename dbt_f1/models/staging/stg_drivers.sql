{{ config(materialized='view') }}

with pages as (
    select payload
    from {{ source('raw', 'jolpica_payloads') }}
    where endpoint = 'drivers'
),
drivers as (
    select
        drv->>'driverId'              as driver_id,
        drv->>'permanentNumber'       as permanent_number,
        drv->>'code'                  as code,
        drv->>'givenName'             as given_name,
        drv->>'familyName'            as family_name,
        (drv->>'dateOfBirth')::date   as date_of_birth,
        drv->>'nationality'           as nationality,
        drv->>'url'                   as wiki_url
    from pages,
         jsonb_array_elements(payload->'pages')                         as page,
         jsonb_array_elements(page->'MRData'->'DriverTable'->'Drivers') as drv
)
select distinct *
from drivers
