# Question bank

Author practice notes. The project and stack are in [README.md](../../README.md).

The phone agent sends only the question text for the id it picked.

## island-filter

A driver has one 4-race streak. You keep `where streak_start = 1` in the same step as the running sum, then take min and max round. What happens to `first_round` and `last_round`?

## dead-group-by

The rows are already one per driver per round. The select list is `driver_id`, `round_num`, and `points`. You add `group by driver_id, round_num`. What does that grouping change about the result?

## missing-column

The question asks for `qualifying_position`. The join returns the right number of rows, and that column is not in the select list. Does the right row count pass the question?

## push-names-the-branch

You commit on `working`, then run `git push origin main`. Where does that new commit go?

## open-pr-follows-the-branch

A pull request from `working` into `main` is open. You make a new commit on `working` and push it. What happens to that pull request, and what happens to `main`?

## checkout-does-not-fetch

You run `git checkout main` and do not pull. Which `main` do the files now match?

## checkout-is-the-branch-this-folder-shows

This folder is on `working`. You edit `STATUS.md` and commit. You do not push. Which branch has the new commit, and what does "checked out" mean?

## pull-follows-the-checked-out-branch

`working` is checked out. GitHub `main` has a newer merge that this `working` does not. You run `git pull` with no extra arguments. Which remote branch does that command look at, and does this folder switch to `main`?

## pull-brings-commits-not-untouched-files

`working` is checked out. Three files have uncommitted edits. You describe `git pull` as downloading the origin files you have not changed and leaving your edits in place. What does a pull bring, and what happens if an incoming commit edits the same lines you edited?

## branch-is-a-label-on-a-commit

`working` and `feature` both point at the same commit. You commit in the folder that has `working` checked out. Where does `working` point after that, and where does `feature` point?

## commit-records-what-was-staged

You edit `STATUS.md`. An untracked folder, `f1-feature/`, is also in the repo. You run `git commit` without `git add`. What does that commit record? What does `git add -A` stage that `git add STATUS.md` leaves out?

## fetch-updates-the-remote-bookmark

You run `git fetch`. You do not merge and you do not pull. What happens to the files in this folder, and what does `origin/working` mean after the fetch?

## merge-joins-with-two-parents

You are on `working` and run `git merge origin/main`. What is the new merge commit, and does GitHub `main` move?

## conflict-stops-until-you-commit

You merge `origin/main` into `working` and Git stops on `sql/quiz/progress.md`. What is Git telling you, and what has to happen before the merge is a finished commit?

## rebase-replays-your-commits

You have seen `rebase` and you are not sure what it does. `working` has commits that `main` does not. What does rebasing `working` onto `main` do to those commits, and how is that different from the merge you made with `git merge origin/main`?

## leader-max-needs-over

After `group by driver_id`, the gap is written `max(sum(points)) - sum(points)` with no `over`. What total is that `max` able to see, and what does the gap need instead?

## rank-takes-no-argument

The driver with the most points should be rank 1. The call is written `rank(sum(points))`. What is wrong with that call, and where does the ordering go?

## worktree-commit-stays-in-its-folder

The original folder has `working` checked out. You create a second folder with `git worktree add ../f1-feature -b feature` and commit there. What does `git status` show in the original folder, and which branch has the new commit?

## worktree-push-names-its-branch

You are inside that feature worktree and run `git push origin main`. Where does the new commit go, and which push publishes it?

## worktree-one-branch-one-checkout

The original folder has `working` checked out. You run `git worktree add ../f1-working working`. What happens?
