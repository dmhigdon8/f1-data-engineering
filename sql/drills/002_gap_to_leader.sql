/*
  Drill 002 — Gap to leader (single race)

  Question:
    For one race, rank finishers and compute each driver's gap to the race leader
    in finish position and in points. (Time gaps are optional — finish_time is a
    display string from Jolpica, not a reliable interval.)

  Assumed grain:
    Input: one row per driver per race in staging_marts.fct_race_results.
    Output: one row per driver for the chosen race, with window columns.

  Tables used:
    staging_marts.fct_race_results

  Tip:
    Change the season/round filters below. Example uses 2024 round 1 (Bahrain).
*/

with race as (
    select *
    from staging_marts.fct_race_results
    where season = 2024
      and round_num = 1
)
select
    season,
    round_num,
    race_name,
    race_date,
    driver_id,
    constructor_id,
    finish_position,
    position_text,
    points,
    status,
    finish_time,
    -- positions behind the winner (null finish_position = DNF / unclassified).
    -- MIN skips nulls in Postgres and Snowflake, so a null cannot become the leader.
    -- Snowflake has no aggregate FILTER; use MIN/MAX, or CASE / COUNT_IF for conditional counts.
    finish_position - min(finish_position) over () as positions_behind_leader,
    -- points behind the highest scorer in this race
    max(points) over () - points as points_behind_leader,
    -- dense rank among classified finishers
    dense_rank() over (
        order by finish_position nulls last
    ) as finish_rank
from race
order by finish_position nulls last, driver_id;

-- alternate: same idea partitioned so you can run across a whole season
-- select
--     season,
--     round_num,
--     driver_id,
--     finish_position,
--     finish_position
--         - min(finish_position) over (partition by season, round_num) as positions_behind_leader,
--     max(points) over (partition by season, round_num) - points as points_behind_leader
-- from staging_marts.fct_race_results
-- where season = 2024
-- order by round_num, finish_position nulls last;
