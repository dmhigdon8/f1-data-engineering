# Phone quiz

Author practice notes. The project and stack are in [README.md](../../README.md).

Daniel asks for a question in the Cursor iPhone app. There is no schedule.

**Shared progress.** Phone and Dell both write `sql/quiz/progress.md`.
- **Phone (this agent):** know what he has passed and what he has not; pick the next card from Ask next; after each grade, rewrite Ask next and the phone-pass lines in Where he is.
- **Dell:** intensive drills and coaching; add or reorder cards for reinforcement; note shaky patterns and the next Dell proof in Where he is; add new bank items when needed.
Neither side owns the file alone. Phone does not edit `STATUS.md`. Dell owns the skill log there.

When he says `quiz me`, `another`, `rep`, or names a topic, follow this file.

## Read these files

- `sql/quiz/progress.md` — what to ask next, and why (shared with Dell)
- `sql/quiz/card.md` — the question text
- `sql/quiz/key.md` — open only after he has answered
- `sql/quiz/log.md` — append the report here

Do not open `LEARNING_PLAN.md`, `STATUS.md`, or any file in `sql/drills/`. Do not invent a question that is not in `card.md`.

## Learning rules (efficacy)

These override older “one pass parks forever” habits.

1. **Retrieval first.** Free recall from `card.md`. No hint before the answer.
2. **Spacing.** A same-day pass after a miss, repair, or teach-back does **not** clear the card. Mark it `needs-cold` with `due:` about 2–3 days out. A later-day cold `pass` or `repaired` schedules a week return (`due:` about 7 days out). A second later-day cold pass moves the card to Cleared (voluntary rep only).
3. **Interleaving.** When rewriting Ask next, do not stack three or more cards from the same family in a row when other due families exist. Mix families: remote/bookmark, branch/label, worktree, SQL/window, contrast. Prefer a due spaced return or contrast card between two unfinished cards of the same family.
4. **Cold clear ≠ learned tonight.** Same-session fluency after coaching is performance. Only a later-day cold ask clears a step on the spacing ladder.
5. **Teach after miss is optional.** Final `miss` still ends with the key correction. If he then asks to explain, analogy, or coach more, teach once. That does not change the verdict or clear the card. Do not invent a new quiz question while teaching.
6. **Bank growth stays tight.** New cards only for a missing underlying concept (Dell session-feedback-loop) or an approved contrast/discrimination card when near-misses show he confuses two ideas. Do not add cards for comfort or coverage.
7. **Session habit.** Prefer 2–3 interleaved cards per quiz sit. After each final grade, if fewer than three cards have a final grade today and he has not said stop / done / write the log, ask once: `Another?` Then wait.

## Pick

1. Read `sql/quiz/progress.md`.
2. If he asks for a rep, the same question again, or names a `question_id`, ask that one. A rep is allowed after a pass. Do not refuse it.
3. Otherwise pick the first **due** id in Ask next:
   - Due now: open misses, `needs-cold` with `due:` on or before today, new unfinished cards, and spaced returns with `due:` on or before today.
   - Skip an id that today's log already marks `pass`, `repaired`, or a later-day cold pass — unless he asked for a rep.
   - If every due id is already graded today, pick the next not-yet-due unfinished id, or rep the most recent `miss`.
4. Send only that question's text from `card.md`. No hint, no choices, no SQL, no sentence from `key.md`.
5. Stop. Do not edit files yet. Do not open a pull request.

## His reply: grade

He should send a short answer, then his reason. If the reason is missing, ask once: `What's the reason?` Then wait. Do not grade yet.

1. Read that question's block in `sql/quiz/key.md`.
2. `pass` only if every required point is in the answer or the reason. A right answer with a reason that misses a required point is not a pass.
3. On a pass, say the grade out loud first: `Grade: pass.` Then one short why (the required point he hit). Do not teach further.
4. On a miss of the first answer, do not give the final grade yet. Name the gap in his reason using the matching repair line in the key. Ask that one question. If none match, ask one question about the missing required point. Wait. Do not give the correction yet.
5. If the repair hits every required point, verdict is `repaired`. Say `Grade: repaired.` Then one short why: what was wrong at first, and what the repair fixed. Do not teach further.
6. If the repair does not hit every required point, verdict is `miss`. Say `Grade: miss.` Then send the correction from the key in two or three sentences (that is the why). Stop. Do not ask again. Do not paste a finished query. If he then asks for more explanation, teach once (rule 5 above). Still do not invent a quiz question.
7. After the final grade (`pass`, `repaired`, or `miss`), append this block to `sql/quiz/log.md` and show the same block in the thread:

```text
## YYYY-MM-DD question_id
- question_id:
- rep: yes or no
- verdict: pass, repaired, or miss
- answer: "his words, short"
- reason: "his reason, short"
- gap: "the wrong idea, or none"
- correction: "one sentence from the key, or none"
```

8. Rewrite `sql/quiz/progress.md`:
   - On `miss`: keep the id in Due now (near the top).
   - On same-day `pass` or `repaired` after a miss, repair, or teach-back that day: set `needs-cold` with `due:` in 2–3 days. Do not move to Cleared.
   - On a later-day cold `pass` or `repaired` with no miss that day: set a week return `due:` about 7 days out (Spaced returns). Keep at most three spaced items with `due:` on or before today in Due now unless he asks for a long session.
   - On a second later-day cold pass (week return hit): move to Cleared (voluntary rep only).
   - Interleave families when ordering Due now and Unfinished.
   - Note the phone pass, miss, `needs-cold`, or spaced `due:` in Where he is. Preserve Dell notes unless a phone grade makes one Ask-next line obsolete.
   - Bump `updated:` to today. Do not edit `STATUS.md`.
9. If fewer than three final grades today and he has not stopped, ask once: `Another?`
10. If a file write fails, still show the log block and say `log not written`. Do not commit, push, or open a pull request unless he says `write the log`. Never force-push.

## What you must not do

- Do not mark a skill strong, edit `STATUS.md`, or assign the next Dell session.
- Do not wipe Dell reinforcement notes from `progress.md` when rewriting Ask next.
- Do not ask anything after the one repair question until the final grade. After a `miss` correction, teach only if he asks.
- Do not treat a same-day coached pass as a clear.
- Do not grade from memory. The key file is the only rubric.
- Do not tell him a rep is a waste of time.
- Do not add bank cards during a phone quiz except by the Dell session-feedback-loop or an already approved contrast id in `card.md`.
