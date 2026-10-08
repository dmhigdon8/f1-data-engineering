with race as (
	select distinct
		season
		, round_num

	from marts.fct_race_results

	where season = 2024)

, sprints as (
	select distinct
		season
		, round_num

	from marts.fct_sprint_results

	where season = 2024)

select 
	r.* 

from race r
	left join sprints s on r.season=s.season and r.round_num=s.round_num

where
	s.round_num is null

order  by r.round_num;


