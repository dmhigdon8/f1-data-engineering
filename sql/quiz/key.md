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
