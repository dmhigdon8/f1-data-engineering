---
name: session-feedback-loop
description: >-
  At the end of a training session, review what Daniel struggled with, find
  underlying concepts missing from the learning plan and phone quiz, and add
  only those. Use when he says he is wrapping up, closing the session, done
  for the night, struggling and needs more, or asks what concepts he is missing.
---

# Session feedback loop

Run this when a training session is ending or he names a gap. The grade in the chat is not the record. A concept he cannot say is not "more practice of the same card" when the card never taught the idea underneath.

## Read first

- `STATUS.md` skill log and grade trail
- `LEARNING_PLAN.md` decisions and the parked list
- `sql/quiz/progress.md`, the headings in `sql/quiz/card.md`, and the latest entries in `sql/quiz/log.md`

## Classify each miss

Use his words from this session. For each struggle, pick one class:

- **Attention.** A typo, a missing `ORDER BY`, or another slip he can rebuild. Name it. Do not add a concept. Do not move a cold-correct pattern back to shaky.
- **Already covered.** The plan or the bank already asks it. Point at that id. Do not add a second card.
- **Missing concept.** He could not say the idea that would have made the miss impossible. One level under the task, not a new field.

## What may be added

A missing concept becomes a phone card: a question in `sql/quiz/card.md`, a key in `sql/quiz/key.md` with `pass requires`, `repair`, and `correction`, and an Ask-next line in `sql/quiz/progress.md` under Needs cold, `due:` 2–3 days out. Do not put it in Due now the night it was learned. No card the same night he states the idea correctly. Note the addition in one sentence in `LEARNING_PLAN.md`. Do not lengthen the `STATUS.md` path for it.

At the start of a Dell session, read the latest misses in `sql/quiz/log.md`. A phone pass does not change the proof. A phone miss changes it only when the missed card is the shaky pattern, or when nothing is shaky and the miss is a pattern marked strong. Then he states that pattern cold before any new concept. A miss in another family stays on the phone.

If the miss is confusing two ideas the bank already covers separately (fetch vs pull, checkout vs pull), add one contrast card only when no existing contrast id already asks that discrimination. Do not add a second card for the same gap. Do not widen the bank for comfort or syllabus coverage.

Add a new proof or lane only when he cannot do the current one without it. Python, stats, DSA, a semantic layer, the sports product, pit stops, a new sport, reset, stash, and cherry-pick stay parked unless he asks for that lane. herdr is out of the plan. Do not bring it back. Worktrees stay in the agent loop: one folder, one branch, he accepts or rejects the diff.

Do not mark a skill strong. A phone pass does not move the skill log. A same-day phone pass after a miss does not clear the spacing ladder in `progress.md`. Do not invent a quiz question outside `card.md` during a phone quiz. This skill is the Dell step that writes cards.

Check the repo before looking outside it. Search the web only when the missing concept is not already defined in the plan, the quiz key, or the code he uses. Do not survey a course.

## Close the session

Tell him, in this order:

1. What was weak, in his words.
2. The concept underneath, and whether it was already on the plan or just added. Name the file.
3. What you left off, and why.

If he is also committing or pushing, stop before the command. He says the branch, the exact push command, what GitHub updates, and the `gh pr create` command. Ask a worktree question only when the night's miss was git. `git push origin working` is the push while the commit is on `working`. `git push origin main` from that branch does not get run until he corrects it. Leave a nested worktree folder out of `git add`.

## Example

He could not say what "checked out" means, and he described pull as downloading the files he had not edited.

- Attention: none.
- Already covered: `checkout-does-not-fetch` only says checkout skips the download. It does not define the word.
- Missing concept: the folder is showing one branch; a pull updates that branch from its remote and brings commits.

Add those cards. Do not add a Git course, rebase recipes, or reset.
