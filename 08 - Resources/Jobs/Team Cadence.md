---
status: active
project: meta
type: guide
author: junior
created: 2026-09-26
updated: 2026-09-26
---
# Team Cadence

**The job:** Keep the team moving and the vault healthy through two short routines, the daily digest and the weekly review, plus the approval-gated upkeep that grows out of them. Fires when Isaac or Tolu says "daily digest" or "weekly review".

## Boot chain (read these, in order, and you have the skill)
1. This note, end to end.
2. [[Active Priorities]] — what's open and who owns it.
3. The Status note of each active project, for example [[MindBridge Status]], [[BakeFlow Status]], [[ShiftOS Status]] and [[Lingora Status]].
4. For the weekly review only: [[Memory Standard]] (section 8, Upkeep), [[Security Register]], [[Tool Register]] (on the 1st of the month), [[Marketing Hub]] and [[Junior Checks]].

## The mechanical part (no model, run first)
The facts come from scripts in `08 - Resources/Onboarding/kit/`, so nothing here depends on Junior reading many notes:
- `vault-check.sh --startup` runs at every `load junior` and prints only what is due or tripped. `vault-check.sh --report` gives all the numbers for the weekly review.
- `vault-maintain.sh propose` builds the rotation of long Logs and old completed priorities on a separate local branch. Nothing is pushed until a founder says "lock it", and then `vault-maintain.sh apply <patch-id>` merges it (never a force push, and it refuses if anyone changed the same files). Splitting a Status or Architecture note is advice only.
- `vault-backup.sh` writes a verified second copy of the vault outside GitHub.
Thresholds live at the top of `vault-check.sh` and `vault-maintain.sh`. Check lines repeat only when they get worse or after three days, so they never nag.

## Daily digest
1. Pull the vault with `git pull --rebase`.
2. For each project with a repo on this machine, check what actually happened since yesterday (`git log --since=yesterday`, `git status`) and compare it with that project's Status note.
3. Read Active Priorities: what's open, who owns each item, how long it has sat.
4. Give a short digest in three parts: **Shipped**, **Stuck** and **Next**, with an owner and a date on every next step.
5. Add a fourth part, **Waiting for approval**: every draft the vault check lists (notes with a `> Draft, not confirmed` line), oldest first, with its age. Anything older than seven days goes at the top.
6. Push back on anything vague, late or unowned. Name it and ask for a decision.
7. Add one line per project to today's daily note, following the Memory Standard.

## Weekly review
1. Run `vault-check.sh --report` and act on what it lists: stale Status notes, notes over their size limit, duplicate names, links that don't resolve, machine-specific paths, missing front matter, a backup that is more than two weeks old, and the count of `kill junior` entries this month.
2. If a Log or the completed priorities are over their limit, run `vault-maintain.sh propose`, show the proposal, and apply it only after "lock it".
3. Do the remaining Upkeep steps in the Memory Standard, such as `idea` notes older than a month and Inbox notes that need a home.
4. Review the open risks in the Security Register and run the weekly checks listed there.
5. On the 1st of the month, run the Tool Register review, run `vault-check.sh --doctor`, write a fresh backup with `vault-backup.sh`, and do the restore drill from the Security Register.
6. Add this week's row to the Marketing Hub metrics log and flag what's missing from the content calendar.
7. Prune Active Priorities: items that look done, items with no owner.
8. Report the findings and the decisions needed, at most two proposals per message. Don't archive or delete anything without asking.

## After a Claude model change or a kit version bump
Run [[Junior Checks]] by hand. It's a short list, and it is how a change in behaviour gets caught.

## Scheduling
There is no unattended job. The checks run when someone loads Junior, and the weekly items are "due" once seven days have passed, so they run at the next `load junior` after that. A scheduled cloud routine would need write access to the vault repo and a stored token, which is the exposure we are avoiding; add one only if the on-demand version proves too easy to forget.

## Quality bar
- Short enough to read in a minute; every item has an owner and a date.
- Based on the repo and the notes, not on assumption.
- Tough on delays and vague plans, never personal.

## Lessons (fold corrections in here over time)
- None yet.
