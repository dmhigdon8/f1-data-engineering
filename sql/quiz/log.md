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
