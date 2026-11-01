# Grade key

Author practice notes. The project and stack are in [README.md](../../README.md).

Open this file only after Daniel answers. Do not quote it in the question.

## island-filter

pass requires:
- `first_round` and `last_round` become the same round.
- That round is the start of the streak. The other three races are gone before the min and max.

repair:
- If he says the 4 races are still in the streak: ask `The running sum is in that same step as the filter. Which of the 4 rows does the filter still leave for min and max?`
- If he says the filter only changes sort order: ask `Does that WHERE remove rows, or only change their order?`

correction: The filter runs before the running sum can see the later races, so each streak collapses to its first round.

## dead-group-by

pass requires:
- The grouping does not change which rows come back.
- Those two columns already identify one row, so the `group by` is dead.

repair:
- If he says it sums points: ask `Points is in the select list with no aggregate. What is there to sum?`
- If he says it removes duplicates: ask `Before the GROUP BY, is there more than one row for the same driver and round?`

correction: `group by` changes the grain only when it collapses rows. Here each driver-round is already one row, so the clause does no work.

## missing-column

pass requires:
- No. The row count being right does not pass the question.
- A column the question asked for has to be in the result.

repair:
- If he says the count is enough: ask `Can the grader see qualifying position in the result without that column?`
- If he says the join implies the column: ask `A join can use a column without selecting it. Is qualifying position in the output?`

correction: A missing requested column fails the question even when the grain and the row count are right.

## push-names-the-branch

pass requires:
- The new commit does not go to GitHub `main`.
- `git push origin main` sends the laptop's `main`, and this commit is not on it.

repair:
- If he says the commit was rejected and is only on the laptop: ask `You had already run git push origin working. Where did that command send the commit?`

correction: The push names the branch it updates. The commit was on `working`, so only a push of `working` publishes it. `main` on GitHub changes when the pull request is merged.

## open-pr-follows-the-branch

pass requires:
- The same open pull request now includes the new commit.
- `main` stays unchanged until the pull request is merged.

repair:
- If he says GitHub opens a second pull request: ask `The pull request tracks the branch. Which branch did the new commit land on?`
- If he says `main` updates on the push: ask `What action puts the pull request's commits onto main?`

correction: An open pull request follows its branch. A new commit on that branch shows up in the same request. Merging the request is what updates `main`.

## checkout-does-not-fetch

pass requires:
- The files match `main` on the laptop.
- That copy can be behind the `main` on GitHub.

repair:
- If he says the files match GitHub: ask `Which command downloads the commits GitHub has that the laptop does not?`

correction: Checkout switches the folder to the laptop's `main`. `git pull` is what brings in the GitHub commits that laptop does not have yet.

## leader-max-needs-over

pass requires:
- After `group by driver_id`, a plain `max(sum(points))` is not the leader's total. It does not see the other drivers.
- The gap needs `max(sum(points)) over ()`, an empty window over every grouped row.

repair:
- If he says the max already looks across every driver: ask `After GROUP BY driver_id, which rows can an aggregate with no OVER see?`
- If he says it just errors: ask `The nested max needs a window to be legal. What goes in the empty OVER so the max can see every driver's total?`

correction: `over ()` is the whole grouped result. That is how the max becomes the leader's points. Without it, the nested max is not a window, and Postgres rejects the nested aggregate.

## rank-takes-no-argument

pass requires:
- `rank()` takes no argument.
- The ordering goes inside the window: `rank() over (order by sum(points) desc)`.

repair:
- If he says `rank(sum(points))` is legal when the sum is already grouped: ask `Does rank accept a value argument at all, or does the sort live somewhere else?`
- If he says the final `order by` sets the rank: ask `Does that final ORDER BY change the rank number, or only the order the rows are displayed?`

correction: `rank`, `dense_rank`, and `row_number` take no argument. The order lives in `over`. `lag`, `lead`, and `ntile` do take an argument.
