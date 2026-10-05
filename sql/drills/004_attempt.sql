with ordered as (
    select
        driver_id
        , season
        , round_num
        , is_podium
        , lag(is_podium) over (partition by driver_id order by season, round_num) as prev_podium
        , lead(is_podium) over (partition by driver_id order by season, round_num) as next_podium
    from staging_marts.fct_race_results
)

, streaks as (select
    driver_id
    , season
    , round_num
    , is_podium
    , case when is_podium and coalesce(prev_podium, false) = false then true else false end as streak_start
    , case when is_podium and coalesce(next_podium, false) = false then true else false end as streak_end
    , sum(case when is_podium and coalesce(prev_podium, false) = false then 1 else 0 end) over (partition by driver_id order by season, round_num) as driver_streak_id


from ordered)


, be as (select
    *
    , sum(case when is_podium then 1 else 0 end) over (partition by driver_id, driver_streak_id) as streak_length
    , first_value(season) over (partition by driver_id, driver_streak_id order by season, round_num) as streak_start_season
    , first_value(round_num) over (partition by driver_id, driver_streak_id order by season, round_num) as streak_start_round
    , first_value(season) over (partition by driver_id, driver_streak_id order by season desc, round_num desc) as streak_end_season
    , first_value(round_num) over (partition by driver_id, driver_streak_id order by season desc, round_num desc) as streak_end_round

from streaks

where 
    is_podium)

select distinct
    driver_id
    , streak_length
    , streak_start_season
    , streak_start_round
    , streak_end_season
    , streak_end_round

from be

where
    streak_length >= 2
    and streak_start_season is not null

order by streak_length desc, streak_start_season, streak_start_round, driver_id;