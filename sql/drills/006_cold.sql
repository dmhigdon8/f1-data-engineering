with base as (select
	driver_id
	, sum(points) as points

from marts.fct_race_results

where season = 2024

group by 1)

select
	driver_id
	, points
	, rank() over(order by points desc) as driver_rank
	, max(points) over() as leader_point_total
	, max(points) over() - points as points_gap_to_leader


from base
group by 1,2
order by points desc;