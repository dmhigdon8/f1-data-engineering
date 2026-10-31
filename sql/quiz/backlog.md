# Queued phone items

Not a card. Copy one item onto `card.md` only when that day's SQL misses do not need the slot. Do not ask these on 2026-10-31. He learned them the same night.

## push-names-the-branch

You commit on `working`, then run `git push origin main`. Where does that new commit go?

pass requires:
- The new commit does not go to GitHub `main`.
- `git push origin main` sends the laptop's `main`, and this commit is not on it.

repair:
- If he says the commit was rejected and is only on the laptop: ask `You had already run git push origin working. Where did that command send the commit?`

correction: The push names the branch it updates. The commit was on `working`, so only a push of `working` publishes it. `main` on GitHub changes when the pull request is merged.

## open-pr-follows-the-branch

A pull request from `working` into `main` is open. You make a new commit on `working` and push it. What happens to that pull request, and what happens to `main`?

pass requires:
- The same open pull request now includes the new commit.
- `main` stays unchanged until the pull request is merged.

repair:
- If he says GitHub opens a second pull request: ask `The pull request tracks the branch. Which branch did the new commit land on?`
- If he says `main` updates on the push: ask `What action puts the pull request's commits onto main?`

correction: An open pull request follows its branch. A new commit on that branch shows up in the same request. Merging the request is what updates `main`.

## checkout-does-not-fetch

You run `git checkout main` and do not pull. Which `main` do the files now match?

pass requires:
- The files match `main` on the laptop.
- That copy can be behind the `main` on GitHub.

repair:
- If he says the files match GitHub: ask `Which command downloads the commits GitHub has that the laptop does not?`

correction: Checkout switches the folder to the laptop's `main`. `git pull` is what brings in the GitHub commits that laptop does not have yet.
