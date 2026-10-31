with tifosi as (
	select distinct
		round_num
	from marts.fct_race_results

	where
		season = 2024
		and constructor_id = 'ferrari'
		and is_podium)

select
	r.round_num
	, r.race_name

from marts.dim_race r
	left join tifosi t on r.round_num=t.round_num

where
	r.season = 2024
	and t.round_num is null

order by r.round_num