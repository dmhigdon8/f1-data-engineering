# Quiz progress

Author practice notes. The project and stack are in [README.md](../../README.md).

updated: 2026-11-10

Shared file. Phone rewrites Ask next and phone-pass lines after each grade so the next quiz knows what is done. Dell rewrites Where he is for intensive work: shaky patterns, reinforcement targets, next proof, and new bank priorities. Phone passes do not move the skill log in `STATUS.md`.

## Where he is

Islands, gap to leader, season rank, fact-to-dimension join, and join of two facts are strong. The 2024 sprint-to-race query was a cold pass on 2026-11-01: 120 rows, matched on season, round, and driver. Standings versus race points was a cold pass on 2026-11-10, 24 rows, and is strong. The dbt grain test is strong. On 2026-11-08 `dim_constructor.constructor_id` got `unique` and `not_null`, and `dbt build` was PASS=3. The `dim_constructor` review passed once on 2026-11-08. The 2026-11-10 agent loop was coached and stays shaky until a later-day cold chief pass. The review of a model and its load is strong. On 2026-11-10 `fct_sprint_results` was a cold pass: one row per driver per sprint, a retry upserts on `(endpoint, season)`, the view is live, and the table waits for `dbt build`. The raw reload upserts on `(endpoint, season)`. Window questions are reps. They do not delay that proof. When he wraps up on the Dell, he explains the push and the `gh pr create` command before running them. On 2026-11-09 the folder was the unlock: he had treated a branch as its own folder. Cards ahead of the older ones: a branch is not a directory, `origin` is GitHub, `git pull origin main` merges into the current branch and leaves GitHub `main` put, a worktree is the second folder rather than a branch of a branch, uncommitted edits survive in that folder, and a feature commit reaches `main` without landing on `working` first.

Phone passes: `dead-group-by` (2026-11-01, 2026-11-02), `leader-max-needs-over` (2026-11-03), `rank-takes-no-argument` (2026-11-04), `island-filter` (2026-11-04), `missing-column` (2026-11-05), `push-names-the-branch` (2026-11-07 rep after 2026-11-06 miss), `open-pr-follows-the-branch` (2026-11-08), `branch-is-not-a-folder` (2026-11-10), `origin-is-the-github-remote` (2026-11-10 repaired), `pull-main-merges-into-working` (2026-11-10), `worktree-is-a-second-folder` (2026-11-10 repaired), `worktree-keeps-uncommitted-work` (2026-11-10), `feature-reaches-main-without-working` (2026-11-10 repaired).

## Ask next

Skip an id that today's log already marks `pass` or `repaired`, unless he asked for a rep.

1. `accept-merges-the-worktree-branch` — 2026-11-10. Merge `agent-check` into `working`. A hand copy skips the branch. Ask this first.
2. `checkout-is-the-branch-this-folder-shows` — 2026-11-08. Checked out means this folder is showing that branch, and a commit here lands on it.
3. `branch-is-a-label-on-a-commit` — two labels can share a commit. The next commit moves only the checked-out label.
4. `commit-records-what-was-staged` — a commit records the staged snapshot. `git add -A` also stages untracked paths.
5. `pull-follows-the-checked-out-branch` — `git pull` with no arguments updates the checked-out branch from its remote. A newer `main` is not what it brings.
6. `fetch-updates-the-remote-bookmark` — fetch moves `origin/*` on the laptop and does not change the files in the folder.
7. `pull-brings-commits-not-untouched-files` — a pull brings commits. It does not skip files he has edited. Same lines, and Git refuses.
8. `merge-joins-with-two-parents` — `git merge origin/main` on `working` adds a two-parent commit on `working`. GitHub `main` stays put.
9. `conflict-stops-until-you-commit` — both sides touched the same lines. The merge finishes when the resolution is committed.
10. `rebase-replays-your-commits` — rebase replays this branch's unique commits as new ones. Merge keeps the old commits and adds one join.
11. `worktree-commit-stays-in-its-folder` — 2026-11-08. A second folder has its own branch. The original folder stays on `working`.
12. `worktree-push-names-its-branch` — a push from inside the worktree still names the branch. `origin main` does not publish `feature`.
13. `worktree-one-branch-one-checkout` — `working` cannot be checked out in two folders.
14. `checkout-does-not-fetch` — checkout switches to the laptop's `main` and does not download GitHub.
15. `feature-reaches-main-without-working` — repaired on the phone 2026-11-10. Ask only if he wants a rep.
16. `worktree-keeps-uncommitted-work` — passed on the phone 2026-11-10. Ask only if he wants a rep.
17. `worktree-is-a-second-folder` — repaired on the phone 2026-11-10. Ask only if he wants a rep.
18. `pull-main-merges-into-working` — passed on the phone 2026-11-10. Ask only if he wants a rep.
19. `origin-is-the-github-remote` — repaired on the phone 2026-11-10. Ask only if he wants a rep.
20. `branch-is-not-a-folder` — passed on the phone 2026-11-10. Ask only if he wants a rep.
21. `open-pr-follows-the-branch` — passed on the phone 2026-11-08. Ask only if he wants a rep.
22. `push-names-the-branch` — passed on the phone 2026-11-07 (rep after miss). Ask only if he wants a rep.
23. `missing-column` — passed on the phone 2026-11-05. Ask only if he wants a rep.
24. `island-filter` — passed on the phone 2026-11-04. Ask only if he wants a rep.
25. `leader-max-needs-over` — passed on the phone 2026-11-03. Ask only if he wants a rep.
26. `rank-takes-no-argument` — passed on the phone 2026-11-04. Ask only if he wants a rep.
27. `dead-group-by` — passed on the phone 2026-11-01 and 2026-11-02. Ask only if he wants a rep.

## Reps

If he asks for a rep, give the rep. Same id if he says again. The next id if he says another. A pass does not block a rep.
