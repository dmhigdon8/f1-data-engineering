{{ config(materialized='table') }}

with src as (select * from {{ ref('stg_drivers') }})
select
    driver_id,
    given_name || ' ' || family_name                       as full_name,
    given_name,
    family_name,
    code,
    permanent_number,
    date_of_birth,
    nationality,
    wiki_url
from src
