---
status: active
project: meta
type: guide
author: junior
created: 2026-09-26
updated: 2026-09-26
---
# Session Handoff and Resume

**The job:** Save exactly where a coding session stands so it can be picked up cold by Isaac, Tolu or Junior (handoff), and pick a project back up from that record (resume). Fires at every milestone or commit, when someone says they're wrapping up, before a long conversation compacts, and whenever a project is opened.

## Boot chain (read these, in order, and you have the skill)
1. This note, end to end.
2. [[Project Notes Standard]] — the layout, the handoff routine, the resume routine and the tidiness rules.
3. The project's Status and Architecture notes, for example [[MindBridge Status]] and [[MindBridge Architecture]].
4. [[Memory Standard]] — the write routine (pull, check, write, index, read back, commit, push).

## The procedure
**Handoff**
1. Pull the vault.
2. Update the current person's *Where we stopped* in the project's Status note, and refresh Snapshot and Next steps.
3. Append one line per completed change to the project's Log.
4. Update Architecture if the stack, integrations or run steps changed.
5. Draft a Decision note for any decision made, and wait for "lock it".
6. Update Active Priorities and today's daily note, then read it back, commit and push.
7. Tell the user in one line what was saved.

**Resume**
1. Read Status, Architecture and the last lines of Log.
2. Check the repo's real state (`git status`, recent commits). If it disagrees with the notes, trust the repo and fix the notes.
3. Report where things stand in a few lines, propose the next step, and wait.
4. If Status and Architecture are still "Not recorded yet", survey the repo the cheap way (README, manifests, directory listing, the top of its control files, then searches for the rest), draft both marked "Draft, not confirmed" listing what you read, and ask for confirmation.

## Quality bar
- A stranger could continue the work from Status alone: branch, files, next action, how to test.
- Status stays short and current. History goes to Log, reasons go to Decisions.
- No code pasted, no secrets, no machine-specific paths.
- Nothing saved that the repo already says better.

## Lessons (fold corrections in here over time)
- None yet.
