select
	frr.round_num
	, frr.race_name
	, frr.driver_id
	, dd.full_name

from marts.fct_race_results frr
	join marts.dim_driver as dd on frr.driver_id=dd.driver_id

where
	frr.season = 2023
	and frr.is_winner

order by frr.round_num;
