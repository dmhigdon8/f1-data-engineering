# Question bank

Author practice notes. The project and stack are in [README.md](../../README.md).

The phone agent sends only the question text for the id it picked.

## island-filter

A driver has one 4-race streak. You keep `where streak_start = 1` in the same step as the running sum, then take min and max round. What happens to `first_round` and `last_round`?

## dead-group-by

The rows are already one per driver per round. The select list is `driver_id`, `round_num`, and `points`. You add `group by driver_id, round_num`. What does that grouping change about the result?

## missing-column

The question asks for `qualifying_position`. The join returns the right number of rows, and that column is not in the select list. Does the right row count pass the question?

## push-names-the-branch

You commit on `working`, then run `git push origin main`. Where does that new commit go?

## open-pr-follows-the-branch

A pull request from `working` into `main` is open. You make a new commit on `working` and push it. What happens to that pull request, and what happens to `main`?

## checkout-does-not-fetch

You run `git checkout main` and do not pull. Which `main` do the files now match?

## leader-max-needs-over

After `group by driver_id`, the gap is written `max(sum(points)) - sum(points)` with no `over`. What total is that `max` able to see, and what does the gap need instead?

## rank-takes-no-argument

The driver with the most points should be rank 1. The call is written `rank(sum(points))`. What is wrong with that call, and where does the ordering go?
