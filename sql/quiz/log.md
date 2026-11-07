# Phone quiz log

Author practice notes. The project and stack are in [README.md](../../README.md).

The bot appends one block per answer. A `pass` here does not change the skill log in `STATUS.md`. The Dell session decides that.

## 2026-11-01 dead-group-by
- question_id: dead-group-by
- rep: no
- verdict: pass
- answer: "Nothing"
- reason: "Group by collapses the rows for aggregation, but the rows are already at a collapsed grain"
- gap: "none"
- correction: "none"
## 2026-11-02 dead-group-by
- question_id: dead-group-by
- rep: no
- verdict: pass
- answer: "Nothing"
- reason: "it's already at the grain you're grouping by"
- gap: "none"
- correction: "none"
## 2026-11-03 leader-max-needs-over
- question_id: leader-max-needs-over
- rep: no
- verdict: pass
- answer: "It just sees that driver_id sum points"
- reason: "the max is for only one number, the sum of points but grouped by that driver. You need the over () so that the window it's calculating the max from is all the drivers"
- gap: "none"
- correction: "none"
## 2026-11-04 rank-takes-no-argument
- question_id: rank-takes-no-argument
- rep: no
- verdict: pass
- answer: "The call should be rank() over (order by sum(points) desc)"
- reason: "rank() with the ordering inside over"
- gap: "none"
- correction: "none"
## 2026-11-04 island-filter
- question_id: island-filter
- rep: no
- verdict: pass
- answer: "The first and last round will both show the round the streak started"
- reason: "in the where you've filtered for only that row"
- gap: "none"
- correction: "none"
## 2026-11-05 missing-column
- question_id: missing-column
- rep: no
- verdict: pass
- answer: "No"
- reason: "you're not providing what was asked for in the results (qualifying_position)"
- gap: "none"
- correction: "none"
## 2026-11-06 push-names-the-branch
- question_id: push-names-the-branch
- rep: no
- verdict: miss
- answer: "Nowhere, it's on the working branch"
- reason: "git push origin main moves this to origin/main (production)"
- gap: "thought the push sent the current branch's commit; it sends laptop main"
- correction: "The push names the branch it updates. The commit was on working, so only a push of working publishes it."
