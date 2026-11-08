# Quiz progress

Author practice notes. The project and stack are in [README.md](../../README.md).

updated: 2026-11-08

The phone agent reads this file to choose. The Dell session rewrites it at the end of a training block: new questions, and when and why to ask them.

## Where he is

Islands, gap to leader, season rank, fact-to-dimension join, and join of two facts are strong. The 2024 sprint-to-race query was a cold pass on 2026-11-01: 120 rows, matched on season, round, and driver. Standings versus race points passed once on 2026-10-31 and is a later-day retention check. The dbt grain test is strong. On 2026-11-08 `dim_constructor.constructor_id` got `unique` and `not_null`, and `dbt build` was PASS=3. The next Dell proof is the review bar on one model: grain, retry, late payload, and which test would catch it. Window questions are reps. They do not delay that test. Phone `dead-group-by` passed on 2026-11-01 and again on 2026-11-02. That does not move the skill log. On 2026-11-08 three worktree questions were added. Ask those before the older git items. A phone pass still does not move the skill log. When he wraps up on the Dell, he explains the push before running it.

## Ask next

Skip an id that today's log already marks `pass` or `repaired`, unless he asked for a rep.

1. `worktree-commit-stays-in-its-folder` — 2026-11-08. A second folder has its own branch. The original folder stays on `working`. Ask this first.
2. `worktree-push-names-its-branch` — a push from inside the worktree still names the branch. `origin main` does not publish `feature`.
3. `worktree-one-branch-one-checkout` — `working` cannot be checked out in two folders.
4. `push-names-the-branch` — `git push origin main` does not publish a commit that is on `working`.
5. `open-pr-follows-the-branch` — a new commit on an open pull request's branch updates that same request.
6. `checkout-does-not-fetch` — checkout switches to the laptop's `main` and does not download GitHub.
7. `leader-max-needs-over` — 2026-11-01, the gap draft had `max(sum(points))` and no window.
8. `rank-takes-no-argument` — 2026-10-31, `rank()` takes no argument. The order lives in `over`. `lag`, `lead`, and `ntile` do take one.
9. `island-filter` — the mistake that collapsed a streak to its first round.
10. `missing-column` — a right row count still failed when a requested column was absent.
11. `dead-group-by` — passed on the phone 2026-11-01 and 2026-11-02. Ask only if he wants a rep.

## Reps

If he asks for a rep, give the rep. Same id if he says again. The next id if he says another. A pass does not block a rep.
