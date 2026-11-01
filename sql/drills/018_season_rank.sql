select
	driver_id
	, sum(points) as points
	, rank() over (order by sum(points) desc) as driver_rank
	, max(sum(points)) over () - sum(points) as points_gap_to_leader

from marts.fct_race_results
where season = 2023
group by driver_id
order by points desc;

