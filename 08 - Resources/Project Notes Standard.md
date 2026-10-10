---
status: active
project: meta
type: reference
author: junior
created: 2026-09-26
updated: 2026-09-26
---
# Project Notes Standard

How each project's knowledge is stored so Junior can remember what we're building, what we've done, and exactly where we stopped, without the vault turning into a mess. It extends [[Memory Standard]]; where the two overlap, this note governs project work.

## 1. The layout

Every project folder has the same shape:

```
02 - MindBridge/
  MindBridge.md               index, "start here" links
  MindBridge Status.md        living snapshot and handoff (overwritten)
  MindBridge Architecture.md  how it is built (updated in place)
  MindBridge Log.md           append-only record of what changed
  Decisions/                  one note per decision (created with the first decision)
  ...other notes, flat, only when a note has nowhere else to go
```

The same three core notes exist for BakeFlow, ShiftOS and Linhora. A new project gets the same set, named `<Project> Status`, `<Project> Architecture`, `<Project> Log`.

## 2. What each note holds

**Status: the handoff.** Small, current and always trustworthy. Overwrite it; never let it grow into history. Keep it under about 80 lines.
- *Snapshot:* stage, what works, known issues.
- *Where we stopped:* one sub-section per person (Isaac, Tolu). Each says what is half-done, the branch, the files touched, the next command to run, and how to test it. Only edit your own sub-section.
- *Next steps:* an ordered list, most important first.

**Architecture: how it's built.** Repos (URLs and default branch), stack, structure, environments, integrations (what each does and where its credentials live, never values), data, how to run, test and deploy, security notes, open questions. Update in place when reality changes.

**Log: what changed.** One line per change, oldest first, append only:
`2026-09-26 | isaac | Added password reset flow | abc1234`
Date, author, what changed and why in one line, commit or PR reference. When a Log passes about 300 lines, the oldest entries move to `07 - Archive/<Project> Log archive <date>.md`, the newest 100 stay, and the Log gets an "Older entries" link. This rotation, and moving older completed items out of Active Priorities, is done by `vault-maintain.sh` as a proposal on a separate branch that is applied only after a founder says "lock it" (see [[Team Cadence]]). Splitting a Status or Architecture note is advice only, never automatic.

**Decisions.** One note per decision, in the Decision shape from the Memory Standard, named specifically ("MindBridge Auth Decision"). Once a project has five, the folder gets its own index note.

**Everything else** (a bug that needs its own write-up, a spike, a research note) is a flat note in the project folder named `Issue - <short title>`, `Spike - <short title>`, and so on, and is listed in the project index. If it fits in a few lines, it lives in Status (known issues) instead of becoming a note.

**When a repo has its own control files** (BakeFlow keeps `CURRENT_TASK.md`, `BLOCKERS.md`, `ARCHITECTURE_DECISIONS.md`, `IMPLEMENTATION_LOG.md` and more at its root), those files are the source of truth for task-level detail. The vault's Status and Architecture summarize and point to them, and never copy them. Record in Status which repo files hold the detail.

## 3. Keeping the vault tidy

- **Folders:** don't create one unless it will hold five or more notes, or a distinct kind of note like Decisions. Never go deeper than one level below a project folder.
- **Names:** unique across the vault, specific, no dates in the name (dates live in Log and in frontmatter). Avoid `:` `/` `\` `?` `*` `"` `<` `>` `|` in names; Windows can't store them.
- **One home per fact.** Status holds where we are, Architecture holds how it works, Log holds when it changed, Decisions hold why. Link between them instead of repeating.
- **No code, no file dumps, no logs.** Point to the repo, file and commit. The vault stores what the code can't say: why, where we stopped, what to do next.
- **No machine-specific paths** in project notes, because the vault is shared. Record repo URLs. Anything that only holds on one person's machine is labelled with whose machine it is.
- **Inbox** is a waiting room. At the weekly review, every Inbox note gets a home, gets merged into an existing note, or gets deleted.
- **Finished work:** when a project or note is done, archive it (with Isaac's OK), never delete history.
- **Merge safety:** `Log.md` files and daily notes merge automatically in Git (`.gitattributes`), so both founders can append on the same day. Status and Architecture are edited by one person at a time: `git pull --rebase` first, keep edits short, push straight after. Each Status note has one "Where we stopped" section per person, and you edit only your own; a correction to someone else's section goes in the Log instead. When Active Priorities passes ten open items, the vault check says so, and Junior proposes per-project sections (a `### <Project>` heading inside Open Tasks) rather than splitting the file, which would add startup reads.

## 4. The handoff routine (how "where we stopped" gets saved)

Junior does this without being asked, at every one of these moments: after each meaningful milestone or commit, when Isaac or Tolu says they're wrapping up, and before a long conversation gets compacted. Sessions can end suddenly, so a handoff at the end alone isn't enough.

1. Pull the vault.
2. Update your person's *Where we stopped* section in `<Project> Status`: exact state, branch, files, next action, how to test.
3. Refresh *Snapshot* and *Next steps* if they changed.
4. Append one line to `<Project> Log` for each change that was completed.
5. If architecture, integrations or the run steps changed, update `<Project> Architecture` in place.
6. If a decision was made, draft its Decision note and wait for "lock it".
7. Update Active Priorities and add a line to today's daily note.
8. Read the changes back, commit and push, and tell the user in one line what was saved.

## 5. The resume routine (how Junior picks a project back up)

1. Read `<Project> Status`, all of it: snapshot, everyone's *Where we stopped*, next steps.
2. Read `<Project> Architecture`.
3. Read the last ten or so lines of `<Project> Log`, and check the repo's actual state (`git status`, recent commits). If the repo and the notes disagree, believe the repo, say so, and fix the notes.
4. Say in a few lines where things stand and propose the next step. Then wait.

If Status and Architecture still say "Not recorded yet", bootstrap them: survey the repo the cheap way (README, manifests, directory listing, the top of its control files, then searches for the rest), draft both notes from what you find, mark them with a line starting `> Draft, not confirmed` that lists what you read and what you did not, and ask the user to confirm or correct.

## 6. Recall before answering

When a question is about our work (what we decided, how something works, what we did last, why we chose a tool), search the vault first with Glob and Grep and read the matching notes, before answering from memory or from the code alone. Say where the answer came from. If the vault has nothing, say so plainly and offer to save the answer once it's found. Never present a guess as recalled fact.

## 6. Reading rules (don't burn tokens on big files)

Reading is the main cost of a session. The vault's own notes are small, so the risk is big files in the repos and the odd note that grows too long.

- **Check size first.** A file of a few hundred lines can be read whole. Anything larger gets searched (Grep) and read by range (offset and limit), or by its start or end only.
- **Never read whole:** logs and changelogs (BakeFlow's `IMPLEMENTATION_LOG.md` is over 500 KB), lockfiles, generated or build output, `node_modules`, `dist`, data dumps, long specs. While Junior is active, a Read guard hook refuses whole-file reads over about 60 KB and tells Junior to use ranges; set `JUNIOR_READ_LIMIT_BYTES` to change the limit.
- **How to read a project's control files:** `CURRENT_TASK` and `BLOCKERS` by their top section only; the Log by its last ten lines (`tail`); `ARCHITECTURE_DECISIONS` by searching for the topic. Read each project's vault Status and Architecture whole; they are kept short on purpose.
- **Delegate broad searches.** For "where is X used" or "survey this repo", give the search to a subagent so only its conclusion enters the conversation.
- **Keep vault notes small:** Status under about 80 lines, Architecture under about 120, any other note under about 200. The weekly review lists notes over 200 lines so they can be split. When a note grows, move detail into a linked note and keep the parent as the summary.
- **Say what you read.** When a summary or audit is based on a partial read, state what was read and what wasn't. Never claim a whole-file read that was a search.
## Change log
- 2026-09-26, Junior for Isaac: first version.
