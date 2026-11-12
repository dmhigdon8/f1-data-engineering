/*
  Drill 024 — Sprint winners, 2024

  Question:
    Who won each sprint in 2024?

  Assumed grain:
    One row per sprint race for season 2024.

  Tables used:
    marts.fct_sprint_results
*/

select
	round_num
	, race_name
	, driver_id
	, finish_position

from marts.fct_sprint_results

where
	season = 2024
	and finish_position = 1

order by round_num;
