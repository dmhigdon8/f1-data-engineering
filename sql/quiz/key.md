# Grade key

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
