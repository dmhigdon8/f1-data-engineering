select
	b.constructor_name
	, sum(a.points) as season_points_total_2024

from marts.fct_race_results a
	left join marts.dim_constructor b on a.constructor_id=b.constructor_id

where
	a.season = 2024

group by 1
order by 2 desc;