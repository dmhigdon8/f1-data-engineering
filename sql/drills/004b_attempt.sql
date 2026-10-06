with base as (select
	driver_id
	, round_num
	, is_points_finish
	, lag(is_points_finish) over (partition by driver_id order by round_num) as prev_points_finish

from staging_marts.fct_race_results

where 
	season = 2024)

, streaks as (select
	base.*
	, sum(case when is_points_finish and coalesce(prev_points_finish, false) = false then 1 else 0 end) over (partition by driver_id order by round_num) as streak_ind

from base)

, penultimate as (select
	driver_id
	, streak_ind
	, min(round_num) over (partition by driver_id, streak_ind, is_points_finish) as streak_round_start
	, max(round_num) over (partition by driver_id, streak_ind, is_points_finish) as streak_round_end
	, sum(case when is_points_finish then 1 else 0 end) over (partition by driver_id, streak_ind order by streak_ind) as streak_length

from streaks

where is_points_finish)

select distinct
	driver_id
	, streak_round_start
	, streak_round_end
	, streak_length

from penultimate

where 
	streak_length >= 2

order by streak_length desc, streak_round_start;