with base as (
    select
        driver_id,
        round_num,
        case when finish_position <= 5 then 1 else 0 end as fifth_or_better
    from marts.fct_race_results
    where season = 2024
  
),
streak_start as (
    select
        base.*,
        case
            when fifth_or_better = 1
             and (lag(fifth_or_better) over (partition by driver_id order by round_num) is null
                  or lag(fifth_or_better) over (partition by driver_id order by round_num) = 0)
            then 1 else 0
        end as streak_start
    from base
),
streak_island as (
    select
        streak_start.*,
        sum(streak_start) over (partition by driver_id order by round_num) as streak_island
    from streak_start
),
streak_params as (
    select
        driver_id,
        streak_island,
        min(round_num) as first_round,
        max(round_num) as last_round,
        count(*) as streak_length
    from streak_island
    where fifth_or_better = 1
    group by driver_id, streak_island
)
select driver_id, first_round, last_round, streak_length
from streak_params
where streak_length >= 2
order by streak_length desc, driver_id;