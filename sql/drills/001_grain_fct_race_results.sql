/*
  Drill 001 — Grain check: fct_race_results

  Question:
    Is staging_marts.fct_race_results one row per driver per race?
    Prove it with COUNT(*) vs COUNT(DISTINCT …), and surface any duplicates.

  Assumed grain:
    One row per (season, round_num, driver_id).
    Surrogate: result_key = md5(season || '-' || round_num || '-' || driver_id).

  Tables used:
    staging_marts.fct_race_results
    (dbt model: fct_race_results — schema lands as staging_marts, see STATUS.md)
*/

-- A) Surrogate key uniqueness: row_count should equal distinct_result_keys
select
    count(*)                       as row_count,
    count(distinct result_key)     as distinct_result_keys,
    count(*) - count(distinct result_key) as duplicate_surplus
from staging_marts.fct_race_results;

-- B) Natural key uniqueness: same check on (season, round_num, driver_id)
select
    count(*) as row_count,
    count(distinct (season, round_num, driver_id)) as distinct_driver_races,
    count(*) - count(distinct (season, round_num, driver_id)) as duplicate_surplus
from staging_marts.fct_race_results;

-- C) List any violating groups (expect 0 rows)
select
    season,
    round_num,
    driver_id,
    count(*) as n
from staging_marts.fct_race_results
group by season, round_num, driver_id
having count(*) > 1
order by n desc, season, round_num, driver_id;

-- D) Sanity: every race_key should map to exactly one (season, round_num)
select
    race_key,
    count(distinct (season, round_num)) as distinct_race_identities
from staging_marts.fct_race_results
group by race_key
having count(distinct (season, round_num)) > 1;
