# Quiz progress

Author practice notes. The project and stack are in [README.md](../../README.md).

updated: 2026-11-18

Shared file. Phone rewrites Ask next and phone-pass lines after each grade so the next quiz knows what is done. Dell rewrites Where he is for intensive work: shaky patterns, reinforcement targets, next proof, and new bank priorities. Phone passes do not move the skill log in `STATUS.md`.

Spacing ladder (2026-11-16): same-day pass after a miss does not clear → `needs-cold` (~2–3 days) → later-day cold pass → week return (~7 days) → second later-day cold → Cleared (voluntary rep). Interleave families. Prefer 2–3 cards per sit. Teach after a final miss only if he asks.

## Where he is

Islands, gap to leader, season rank, fact-to-dimension join, and join of two facts are strong. The 2024 sprint-to-race query was a cold pass on 2026-11-01: 120 rows, matched on season, round, and driver. Standings versus race points was a cold pass on 2026-11-10, 24 rows, and is strong. The dbt grain test is strong. On 2026-11-08 `dim_constructor.constructor_id` got `unique` and `not_null`, and `dbt build` was PASS=3. The `dim_constructor` review passed once on 2026-11-08. The 2026-11-11 agent loop is strong. On 2026-11-15 the relationship test is strong. `fct_qualifying_results.constructor_id` must exist in `dim_constructor`. A missing key fails `relationships`. A null fails `not_null`. `dbt build` was PASS=51. On 2026-11-16 the singular test is strong. `assert_sprint_points_not_negative` returns `fct_sprint_results` rows where `points < 0`. The select list is season, round, driver, and points. It passed inside PASS=53. On 2026-11-17 source freshness was coached and stays shaky. `raw.jolpica_payloads` warned because the newest `fetched_at` is 2026-09-19 and the window is 1 day. The review of a model and its load is strong. On 2026-11-10 `fct_sprint_results` was a cold pass: one row per driver per sprint, a retry upserts on `(endpoint, season)`, the view is live, and the table waits for `dbt build`. The raw reload upserts on `(endpoint, season)`. Window questions are reps. They do not delay that proof. When he wraps up on the Dell, he explains the push and the `gh pr create` command before running them. On 2026-11-09 the folder was the unlock: he had treated a branch as its own folder. Cards ahead of the older ones: a branch is not a directory, `origin` is GitHub, `git pull origin main` merges into the current branch and leaves GitHub `main` put, a worktree is the second folder rather than a branch of a branch, uncommitted edits survive in that folder, and a feature commit reaches `main` without landing on `working` first. Phone miss then same-day pass 2026-11-16: `fetch-updates-the-remote-bookmark` — needs later-day cold (`due: 2026-11-18`); `origin/*` is a laptop snapshot, not a live GitHub connection. Phone miss then same-day pass 2026-11-16: `pull-brings-commits-not-untouched-files` — needs later-day cold (`due: 2026-11-18`); pull brings commits, uncommitted edits sit on top, same lines and Git stops. Phone repaired 2026-11-16, later-day cold repaired 2026-11-18: `fetch-vs-pull` — week return `due: 2026-11-25`; fetch leaves files alone and moves bookmarks, pull merges into the checked-out branch. Phone pass 2026-11-16: `checkout-vs-pull` — week return `due: 2026-11-23`; checkout uses laptop `main`, pull on `working` stays on `working`. On 2026-11-16 the phone bank gained contrast cards `fetch-vs-pull` and `checkout-vs-pull`, and Ask next moved to spaced returns plus interleaving. On 2026-11-17 the Dell bank gained `singular-test-select-is-the-failure-report`, `yaml-indent-is-the-tree`, and `singular-test-returns-bad-rows`. Phone repaired 2026-11-17: `singular-test-select-is-the-failure-report` — needs later-day cold (`due: 2026-11-19`); a row coming back decides fail, the select list is the report, `result_key` is an md5. Phone repaired 2026-11-17: `yaml-indent-is-the-tree` — needs later-day cold (`due: 2026-11-19`); indent is the tree, same indent as `loaded_at_field` is a table property. Phone pass 2026-11-17: `push-names-the-branch` — week return `due: 2026-11-24`; catch-up cold, push names the branch it updates. Phone pass 2026-11-17: `singular-test-returns-bad-rows` — week return `due: 2026-11-24`; he overrode a miss — concept held (`points < 0`, not a count test). Phone pass 2026-11-18: `origin-is-the-github-remote` — week return `due: 2026-11-25`; catch-up cold, origin is GitHub, pull updates the laptop. Phone miss then same-day pass 2026-11-18: `merge-joins-with-two-parents` — needs later-day cold (`due: 2026-11-20`); two-parent commit on `working`, GitHub `main` stays put. Phone pass 2026-11-18: `dead-group-by` — week return `due: 2026-11-25`; catch-up cold, group by is dead when the grain is already one row per key. Phone pass 2026-11-18: `checkout-does-not-fetch` — week return `due: 2026-11-25`; checkout shows laptop `main`, does not download GitHub.

Phone passes (not yet Cleared under the spacing ladder): `dead-group-by` (2026-11-01, 2026-11-02; 2026-11-18 cold — week return), `leader-max-needs-over` (2026-11-03), `rank-takes-no-argument` (2026-11-04), `island-filter` (2026-11-04), `missing-column` (2026-11-05), `push-names-the-branch` (2026-11-07 rep after miss; 2026-11-17 cold — week return), `open-pr-follows-the-branch` (2026-11-08), `branch-is-not-a-folder` (2026-11-10), `origin-is-the-github-remote` (2026-11-10 repaired; 2026-11-18 cold — week return), `pull-main-merges-into-working` (2026-11-10), `worktree-is-a-second-folder` (2026-11-10 repaired), `worktree-keeps-uncommitted-work` (2026-11-10), `feature-reaches-main-without-working` (2026-11-10 repaired), `accept-merges-the-worktree-branch` (2026-11-11 repaired), `checkout-is-the-branch-this-folder-shows` (2026-11-12 rep after 2026-11-11 miss), `branch-is-a-label-on-a-commit` (2026-11-12), `commit-records-what-was-staged` (2026-11-13), `pull-follows-the-checked-out-branch` (2026-11-14), `fetch-updates-the-remote-bookmark` (2026-11-16 rep after miss — needs-cold), `pull-brings-commits-not-untouched-files` (2026-11-16 rep after miss — needs-cold), `fetch-vs-pull` (2026-11-16 repaired; 2026-11-18 cold repaired — week return), `checkout-vs-pull` (2026-11-16 — week return), `singular-test-select-is-the-failure-report` (2026-11-17 repaired — needs-cold), `yaml-indent-is-the-tree` (2026-11-17 repaired — needs-cold), `singular-test-returns-bad-rows` (2026-11-17 pass — week return), `checkout-does-not-fetch` (2026-11-18 — week return), `merge-joins-with-two-parents` (2026-11-18 same-day after miss — needs-cold).

## Ask next

Skip an id that today's log already marks `pass` or `repaired`, unless he asked for a rep. Prefer 2–3 interleaved cards per sit. After a final grade, ask `Another?` once if under three today.

### Due now

1. `leader-max-needs-over` — spaced return `due: 2026-11-18`. Interleave SQL between remote cards.
2. `pull-brings-commits-not-untouched-files` — `needs-cold` `due: 2026-11-18`. Same-day pass after miss does not clear.
3. `fetch-updates-the-remote-bookmark` — `needs-cold` `due: 2026-11-18`. Same-day pass after miss does not clear.

### Needs cold / spaced returns

4. `merge-joins-with-two-parents` — `needs-cold` `due: 2026-11-20`. Same-day pass after miss does not clear.
5. `singular-test-select-is-the-failure-report` — `needs-cold` `due: 2026-11-19`. Repaired after a gap on pass/fail vs select list.
6. `yaml-indent-is-the-tree` — `needs-cold` `due: 2026-11-19`. Repaired after a gap on same-indent sibling.
7. `checkout-vs-pull` — week return `due: 2026-11-23`. First cold pass.
8. `conflict-stops-until-you-commit` — unfinished. Interleave after a remote/SQL card, not right after merge.
9. `rank-takes-no-argument` — spaced return `due: 2026-11-19`.
10. `island-filter` — spaced return `due: 2026-11-19`.
11. `checkout-is-the-branch-this-folder-shows` — spaced return `due: 2026-11-19` (rep after miss).
12. `rebase-replays-your-commits` — unfinished.
13. `missing-column` — spaced return `due: 2026-11-20`.
14. `branch-is-a-label-on-a-commit` — spaced return `due: 2026-11-20`.
15. `commit-records-what-was-staged` — spaced return `due: 2026-11-20`.
16. `worktree-commit-stays-in-its-folder` — unfinished.
17. `pull-follows-the-checked-out-branch` — spaced return `due: 2026-11-21`.
18. `open-pr-follows-the-branch` — spaced return `due: 2026-11-21`.
19. `worktree-push-names-its-branch` — unfinished.
20. `branch-is-not-a-folder` — spaced return `due: 2026-11-22`.
21. `pull-main-merges-into-working` — spaced return `due: 2026-11-22`.
22. `worktree-one-branch-one-checkout` — unfinished.
23. `worktree-is-a-second-folder` — spaced return `due: 2026-11-23` (repaired).
24. `worktree-keeps-uncommitted-work` — spaced return `due: 2026-11-23`.
25. `feature-reaches-main-without-working` — spaced return `due: 2026-11-24` (repaired).
26. `push-names-the-branch` — week return `due: 2026-11-24`. Catch-up cold pass.
27. `singular-test-returns-bad-rows` — week return `due: 2026-11-24`. Override pass; return `points < 0`.
28. `accept-merges-the-worktree-branch` — spaced return `due: 2026-11-24` (repaired).
29. `origin-is-the-github-remote` — week return `due: 2026-11-25`. Catch-up cold pass.
30. `dead-group-by` — week return `due: 2026-11-25`. Catch-up cold pass.
31. `checkout-does-not-fetch` — week return `due: 2026-11-25`. First cold pass.
32. `fetch-vs-pull` — week return `due: 2026-11-25`. Later-day cold repaired.

### Cleared (voluntary rep only)

None yet under the 2026-11-16 spacing ladder. A second later-day cold pass is required before a card lands here.

## Reps

If he asks for a rep, give the rep. Same id if he says again. The next id if he says another. A pass does not block a rep.
