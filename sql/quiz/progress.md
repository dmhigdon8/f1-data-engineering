# Quiz progress

Author practice notes. The project and stack are in [README.md](../../README.md).

updated: 2026-11-16

Shared file. Phone rewrites Ask next and phone-pass lines after each grade so the next quiz knows what is done. Dell rewrites Where he is for intensive work: shaky patterns, reinforcement targets, next proof, and new bank priorities. Phone passes do not move the skill log in `STATUS.md`.

Spacing ladder (2026-11-16): same-day pass after a miss does not clear → `needs-cold` (~2–3 days) → later-day cold pass → week return (~7 days) → second later-day cold → Cleared (voluntary rep). Interleave families. Prefer 2–3 cards per sit. Teach after a final miss only if he asks.

## Where he is

Islands, gap to leader, season rank, fact-to-dimension join, and join of two facts are strong. The 2024 sprint-to-race query was a cold pass on 2026-11-01: 120 rows, matched on season, round, and driver. Standings versus race points was a cold pass on 2026-11-10, 24 rows, and is strong. The dbt grain test is strong. On 2026-11-08 `dim_constructor.constructor_id` got `unique` and `not_null`, and `dbt build` was PASS=3. The `dim_constructor` review passed once on 2026-11-08. The 2026-11-11 agent loop is strong. On 2026-11-15 the relationship test is strong. `fct_qualifying_results.constructor_id` must exist in `dim_constructor`. A missing key fails `relationships`. A null fails `not_null`. `dbt build` was PASS=51. On 2026-11-15 `assert_race_points_not_negative` passed after coaching and stays shaky. A negative `points` row is what the query returns. Next proof is a later-day cold singular test on a fact other than `fct_race_results`. The review of a model and its load is strong. On 2026-11-10 `fct_sprint_results` was a cold pass: one row per driver per sprint, a retry upserts on `(endpoint, season)`, the view is live, and the table waits for `dbt build`. The raw reload upserts on `(endpoint, season)`. Window questions are reps. They do not delay that proof. When he wraps up on the Dell, he explains the push and the `gh pr create` command before running them. On 2026-11-09 the folder was the unlock: he had treated a branch as its own folder. Cards ahead of the older ones: a branch is not a directory, `origin` is GitHub, `git pull origin main` merges into the current branch and leaves GitHub `main` put, a worktree is the second folder rather than a branch of a branch, uncommitted edits survive in that folder, and a feature commit reaches `main` without landing on `working` first. Phone miss then same-day pass 2026-11-16: `fetch-updates-the-remote-bookmark` — needs later-day cold (`due: 2026-11-18`); `origin/*` is a laptop snapshot, not a live GitHub connection. Phone miss 2026-11-16: `pull-brings-commits-not-untouched-files` — framed pull as copying unedited origin files instead of bringing commits. On 2026-11-16 the phone bank gained contrast cards `fetch-vs-pull` and `checkout-vs-pull`, and Ask next moved to spaced returns plus interleaving.

Phone passes (not yet Cleared under the spacing ladder): `dead-group-by` (2026-11-01, 2026-11-02), `leader-max-needs-over` (2026-11-03), `rank-takes-no-argument` (2026-11-04), `island-filter` (2026-11-04), `missing-column` (2026-11-05), `push-names-the-branch` (2026-11-07 rep after 2026-11-06 miss), `open-pr-follows-the-branch` (2026-11-08), `branch-is-not-a-folder` (2026-11-10), `origin-is-the-github-remote` (2026-11-10 repaired), `pull-main-merges-into-working` (2026-11-10), `worktree-is-a-second-folder` (2026-11-10 repaired), `worktree-keeps-uncommitted-work` (2026-11-10), `feature-reaches-main-without-working` (2026-11-10 repaired), `accept-merges-the-worktree-branch` (2026-11-11 repaired), `checkout-is-the-branch-this-folder-shows` (2026-11-12 rep after 2026-11-11 miss), `branch-is-a-label-on-a-commit` (2026-11-12), `commit-records-what-was-staged` (2026-11-13), `pull-follows-the-checked-out-branch` (2026-11-14), `fetch-updates-the-remote-bookmark` (2026-11-16 rep after miss — needs-cold).

## Ask next

Skip an id that today's log already marks `pass` or `repaired`, unless he asked for a rep. Prefer 2–3 interleaved cards per sit. After a final grade, ask `Another?` once if under three today.

### Due now

1. `pull-brings-commits-not-untouched-files` — miss 2026-11-16. A pull brings commits, not a file-by-file copy. Same lines, and Git refuses. Keep near the top.
2. `fetch-vs-pull` — new contrast. Fetch refreshes bookmarks only; pull merges into the checked-out branch.
3. `push-names-the-branch` — spaced return `due: 2026-11-17`. Miss then pass early November; catch-up cold.
4. `checkout-vs-pull` — new contrast. Checkout switches local branch; pull updates the one already checked out.
5. `origin-is-the-github-remote` — spaced return `due: 2026-11-17`. Repaired 2026-11-10; catch-up cold.
6. `merge-joins-with-two-parents` — unfinished. Two-parent commit on `working`; GitHub `main` stays put.
7. `dead-group-by` — spaced return `due: 2026-11-18`. Early SQL catch-up.
8. `checkout-does-not-fetch` — unfinished. Checkout uses laptop `main`; does not download GitHub.

### Needs cold / spaced returns

9. `fetch-updates-the-remote-bookmark` — `needs-cold` `due: 2026-11-18`. Same-day pass after miss does not clear.
10. `leader-max-needs-over` — spaced return `due: 2026-11-18`.
11. `conflict-stops-until-you-commit` — unfinished. Interleave after a remote/SQL card, not right after merge.
12. `rank-takes-no-argument` — spaced return `due: 2026-11-19`.
13. `island-filter` — spaced return `due: 2026-11-19`.
14. `checkout-is-the-branch-this-folder-shows` — spaced return `due: 2026-11-19` (rep after miss).
15. `rebase-replays-your-commits` — unfinished.
16. `missing-column` — spaced return `due: 2026-11-20`.
17. `branch-is-a-label-on-a-commit` — spaced return `due: 2026-11-20`.
18. `commit-records-what-was-staged` — spaced return `due: 2026-11-20`.
19. `worktree-commit-stays-in-its-folder` — unfinished.
20. `pull-follows-the-checked-out-branch` — spaced return `due: 2026-11-21`.
21. `open-pr-follows-the-branch` — spaced return `due: 2026-11-21`.
22. `worktree-push-names-its-branch` — unfinished.
23. `branch-is-not-a-folder` — spaced return `due: 2026-11-22`.
24. `pull-main-merges-into-working` — spaced return `due: 2026-11-22`.
25. `worktree-one-branch-one-checkout` — unfinished.
26. `worktree-is-a-second-folder` — spaced return `due: 2026-11-23` (repaired).
27. `worktree-keeps-uncommitted-work` — spaced return `due: 2026-11-23`.
28. `feature-reaches-main-without-working` — spaced return `due: 2026-11-24` (repaired).
29. `accept-merges-the-worktree-branch` — spaced return `due: 2026-11-24` (repaired).

### Cleared (voluntary rep only)

None yet under the 2026-11-16 spacing ladder. A second later-day cold pass is required before a card lands here.

## Reps

If he asks for a rep, give the rep. Same id if he says again. The next id if he says another. A pass does not block a rep.
