# Quiz progress

Author practice notes. The project and stack are in [README.md](../../README.md).

updated: 2026-11-01

The phone agent reads this file to choose. The Dell session rewrites it at the end of a training block: new questions, and when and why to ask them.

## Where he is

Islands, gap to leader, season rank, fact-to-dimension join, and join of two facts are strong. The 2024 sprint-to-race query was a cold pass on 2026-11-01: 120 rows, matched on season, round, and driver. Standings versus race points passed once on 2026-10-31 and is a later-day retention check. The next Dell proof is one dbt grain test on `dim_constructor` or `fct_qualifying_results`. Window questions are reps. They do not delay that test.

## Ask next

Skip an id that today's log already marks `pass` or `repaired`, unless he asked for a rep.

1. `dead-group-by` — the grouping nit on the next Dell join. Ask this first.
2. `leader-max-needs-over` — 2026-11-01, the gap draft had `max(sum(points))` and no window.
3. `rank-takes-no-argument` — 2026-10-31, `rank()` takes no argument. The order lives in `over`. `lag`, `lead`, and `ntile` do take one.
4. `island-filter` — the mistake that collapsed a streak to its first round.
5. `missing-column` — a right row count still failed when a requested column was absent.
6. `push-names-the-branch` — `git push origin main` does not publish a commit that is on `working`.
7. `open-pr-follows-the-branch` — a new commit on an open pull request's branch updates that same request.
8. `checkout-does-not-fetch` — checkout switches to the laptop's `main` and does not download GitHub.

## Reps

If he asks for a rep, give the rep. Same id if he says again. The next id if he says another. A pass does not block a rep.
