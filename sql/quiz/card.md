# Quiz card

valid_on: 2026-10-31
timezone: America/Chicago

The agent sends only the question text for the slot. It does not send this header.

## morning

question_id: island-filter

A driver has one 4-race streak. You keep `where streak_start = 1` in the same step as the running sum, then take min and max round. What happens to `first_round` and `last_round`?

## noon

question_id: dead-group-by

The rows are already one per driver per round. The select list is `driver_id`, `round_num`, and `points`. You add `group by driver_id, round_num`. What does that grouping change about the result?

## evening

question_id: missing-column

The question asks for `qualifying_position`. The join returns the right number of rows, and that column is not in the select list. Does the right row count pass the question?
