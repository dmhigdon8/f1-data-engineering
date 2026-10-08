with base as (select
	driver_id
	, round_num
	, is_podium
	, lag(is_podium) over (partition by driver_id order by round_num) as prev_podium_flag

from marts.fct_race_results

where
	season = 2024)

, streaks as (select
	*
	, sum(case when is_podium and coalesce(prev_podium_flag, false) = false then 1 else 0 end) over (partition by driver_id order by round_num) as driver_podium_streak_ind

from base

where is_podium)

, penultimate as (select distinct
	driver_id
	, count(*) over (partition by driver_id, driver_podium_streak_ind) as streak_length
	, min(round_num) over (partition by driver_id, driver_podium_streak_ind) as streak_round_start
	, max(round_num) over (partition by driver_id, driver_podium_streak_ind) as streak_round_end

from streaks)

select * from penultimate where streak_length >= 2

order by streak_length desc, driver_id;