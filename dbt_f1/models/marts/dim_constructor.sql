{{ config(materialized='table') }}

with src as (select * from {{ ref('stg_constructors') }})
select
    constructor_id,
    constructor_name,
    nationality,
    wiki_url
from src
