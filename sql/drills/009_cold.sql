with base as (select
	driver_id
	, round_num
	, is_winner
	, lag(is_winner) over (partition by driver_id order by round_num) as prev_winner_ind

from marts.fct_race_results

where
	season = 2024)

, streaks as (select
	*
	, sum(case when is_winner and coalesce(prev_winner_ind, false) = false then 1 else 0 end) over (partition by driver_id order by round_num) as winner_streak_ind

from base

where is_winner)

, penultimate as (select
	driver_id
	, count(*) over (partition by driver_id, winner_streak_ind) as streak_length
	, min(round_num) over (partition by driver_id, winner_streak_ind) as streak_start_round
	, max(round_num) over (partition by driver_id, winner_streak_ind) as streak_end_round

from streaks)

select distinct
	*

from penultimate

where streak_length >= 2

order by streak_length desc, driver_id