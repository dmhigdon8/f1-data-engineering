# Quiz progress

Author practice notes. The project and stack are in [README.md](../../README.md).

updated: 2026-11-08

Shared file. Phone rewrites Ask next and phone-pass lines after each grade so the next quiz knows what is done. Dell rewrites Where he is for intensive work: shaky patterns, reinforcement targets, next proof, and new bank priorities. Phone passes do not move the skill log in `STATUS.md`.

## Where he is

Islands, gap to leader, season rank, fact-to-dimension join, and join of two facts are strong. The 2024 sprint-to-race query was a cold pass on 2026-11-01: 120 rows, matched on season, round, and driver. Standings versus race points passed once on 2026-10-31 and is a later-day retention check. The dbt grain test is strong. On 2026-11-08 `dim_constructor.constructor_id` got `unique` and `not_null`, and `dbt build` was PASS=3. The next Dell proof is the review bar on one model: grain, retry, late payload, and which test would catch it. Window questions are reps. They do not delay that proof. When he wraps up on the Dell, he explains the push and the `gh pr create` command before running them.

Phone passes: `dead-group-by` (2026-11-01, 2026-11-02), `leader-max-needs-over` (2026-11-03), `rank-takes-no-argument` (2026-11-04), `island-filter` (2026-11-04), `missing-column` (2026-11-05), `push-names-the-branch` (2026-11-07 rep after 2026-11-06 miss), `open-pr-follows-the-branch` (2026-11-08).

## Ask next

Skip an id that today's log already marks `pass` or `repaired`, unless he asked for a rep.

1. `worktree-commit-stays-in-its-folder` — 2026-11-08. A second folder has its own branch. The original folder stays on `working`. Ask this first.
2. `worktree-push-names-its-branch` — a push from inside the worktree still names the branch. `origin main` does not publish `feature`.
3. `worktree-one-branch-one-checkout` — `working` cannot be checked out in two folders.
4. `checkout-does-not-fetch` — checkout switches to the laptop's `main` and does not download GitHub.
5. `open-pr-follows-the-branch` — passed on the phone 2026-11-08. Ask only if he wants a rep.
6. `push-names-the-branch` — passed on the phone 2026-11-07 (rep after miss). Ask only if he wants a rep.
7. `missing-column` — passed on the phone 2026-11-05. Ask only if he wants a rep.
8. `island-filter` — passed on the phone 2026-11-04. Ask only if he wants a rep.
9. `leader-max-needs-over` — passed on the phone 2026-11-03. Ask only if he wants a rep.
10. `rank-takes-no-argument` — passed on the phone 2026-11-04. Ask only if he wants a rep.
11. `dead-group-by` — passed on the phone 2026-11-01 and 2026-11-02. Ask only if he wants a rep.

## Reps

If he asks for a rep, give the rep. Same id if he says again. The next id if he says another. A pass does not block a rep.
