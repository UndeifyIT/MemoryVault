---
status: active
project: meta
type: guide
author: junior
created: 2026-09-26
updated: 2026-09-26
---
# Team Cadence

**The job:** Keep the team moving and the vault healthy through two short routines: the daily digest and the weekly review. Fires when Isaac or Tolu says "daily digest" or "weekly review", or when a schedule triggers it.

## Boot chain (read these, in order, and you have the skill)
1. This note, end to end.
2. [[Active Priorities]] — what's open and who owns it.
3. The Status note of each active project, for example [[MindBridge Status]], [[BakeFlow Status]], [[ShiftOS Status]] and [[Linhora Status]].
4. For the weekly review only: [[Memory Standard]] (section 8, Upkeep), [[Security Register]], [[Tool Register]] (on the 1st of the month) and [[Marketing Hub]].

## Daily digest
1. Pull the vault.
2. For each project with a repo on this machine, check what actually happened since yesterday (`git log --since=yesterday`, `git status`) and compare it with that project's Status note.
3. Read Active Priorities: what's open, who owns each item, how long it has sat.
4. Give a short digest in three parts: **Shipped**, **Stuck** and **Next**, with an owner and a date on every next step.
5. Push back on anything vague, late or unowned. Name it and ask for a decision.
6. Add one line per project to today's daily note, following the Memory Standard.

## Weekly review
1. Do the Upkeep steps in the Memory Standard: notes missing frontmatter, notes missing from their folder index, `idea` notes older than a month, stale facts, Inbox notes that need a home, and the note count.
2. Review the open risks in the Security Register and run the weekly checks listed there.
3. On the 1st of the month, run the Tool Register review.
4. Add this week's row to the Marketing Hub metrics log and flag what's missing from the content calendar.
5. Prune Active Priorities: items that look done, items with no owner.
6. Report the findings and the decisions needed. Don't archive or delete anything without asking.

## Scheduling
Both routines run on demand today. To have them run by themselves, the vault must be on GitHub first; then a scheduled routine (`/schedule`) can run Junior against it. Set that up once the private repo exists.

## Quality bar
- Short enough to read in a minute; every item has an owner and a date.
- Based on the repo and the notes, not on assumption.
- Tough on delays and vague plans, never personal.

## Lessons (fold corrections in here over time)
- None yet.
