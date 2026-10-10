---
status: active
project: meta
type: reference
author: junior
created: 2026-09-26
updated: 2026-09-28
---
# Vault Rules

Moved out of VAULT-INDEX.md on 2026-09-26 so Junior doesn't read them at every startup. Read this note, with [[Memory Standard]], before writing to the vault. Reading the vault needs neither.

These rules apply to any AI that reads or writes to this vault.

## Frontmatter and Wikilinks

Every note MUST have YAML frontmatter. When you create a note, include it. When you edit an existing note that's missing or has incomplete frontmatter, fix it as part of that write. Don't stop to add frontmatter to files you're only reading. Code files are the exception — no frontmatter or wikilinks in code.

Never ask Isaac what the frontmatter values should be. Infer them.

## Note format

Simple, legible, readable. No random emojis. Checkboxes are real Markdown checkboxes (`- [ ]` / `- [x]`), never emoji stand-ins. **Append before you create:** default to adding to an existing note rather than spinning up a new one — fewer, fuller notes beat many thin ones. Create a new note only when nothing existing is a logical home.

```yaml
---
status: active
project: [project-slug]
type: plan
author: isaac | tolu | junior
created: YYYY-MM-DD
updated: YYYY-MM-DD
---
```

`author` is who wrote the note; `created` is the date first written; `updated` changes on every edit. What is allowed into the vault, where each kind of memory lives, and how to write it are set out in [[Memory Standard]]. Follow it on every write. Every project keeps a Status, Architecture and Log note (plus a Decisions folder), and Junior saves "where we stopped" and picks work back up as set out in [[Project Notes Standard]]. When a question is about our work, search the vault before answering.

When creating or editing a note, add `wikilinks`:

**Always link:** anyone in Key People · named businesses, products, and platforms · any note this one directly references, extends, or depends on.
**Never link:** generic words just because a note shares the name · the same target twice in one note · the note's own title.

## How to Determine Each Field

**status** — Default `active`. For existing notes infer from content: in progress / has unchecked items → `active`; all done → `completed`; a future "maybe" → `idea`; was active but gone quiet → `parked`; in the Archive folder → `archived`.

**Status tracking (Junior keeps it current).** Activity means evidence: a commit in the project's repo, an edit to its vault notes, a daily-note mention, or work in the current session.
- **Automatic, then reported in one line:** `active` → `parked` after 14 days with no activity (Junior checks the project repo's commits first, because the vault check can't see them); `parked` → `active` when activity resumes; `active` → `completed` when every checkbox is done and verified against the real state.
- **Never automatic:** `idea` → `active` (only a founder's "lock it" does that) and anything → `archived` (Junior asks first).
- **Asking:** at `load junior` the vault check names at most one quiet item, quietest first, each at most once every 3 days. Junior asks one question ("still on, parked, or done?") and the answer sets the status.

**project** — What the note *serves* (folder is the default, but content wins). Mapping:
- `02 - MindBridge/*` → `mindbridge`
- `03 - BakeFlow/*` → `bakeflow`
- `04 - ShiftOS/*` → `shiftos`
- `05 - Linhora/*` → `linhora`
- `06 - Personal/*` → `personal`
- `01 - Daily Notes/*` → `personal`
- `07 - Archive/*` → infer from content / original project
- `08 - Resources/*` → `meta`
- `00 - Inbox/*` → infer from content, else `personal`
- Root-level files → `meta`

**type** — What KIND of document it is (not its topic):
- `index` — a folder index / map-of-content note (or this root index)
- `reference` — a static document meant to be looked up later (specs, knowledge bases, templates, voice guides)
- `guide` — step-by-step how-to, runbook, or build instructions
- `plan` — a strategy, phased build, or multi-step project plan (Active Priorities is a plan)
- `log` — a dated session capture or working note (daily notes are logs)

## Valid Field Values

**status:** `active` | `completed` | `parked` | `idea` | `archived`
**project:** `mindbridge` | `bakeflow` | `shiftos` | `linhora` | `personal` | `meta`
**type:** `index` | `reference` | `guide` | `plan` | `log`

## Folder Indexes (keep them in sync)

Every folder that holds substantial content (5+ notes, or a distinct area) gets an index note named after the folder: `<Folder Name>.md`, frontmatter `type: index`, listing each note in the folder with a one-line description. The index is a contract: when you create, rename, move, or materially change a note, update its folder's index in the same pass. A stale index makes a future session decide from a wrong map.

**When a new folder is created:** create its `<Folder Name>.md` index at the same time, add an entry to the parent folder's index if it has one, and update the **Vault Structure** map in `VAULT-INDEX.md` in the same pass. A folder the map doesn't show is a folder no future session will look in.

## Renaming and moving notes

- **Moving** a note to another folder is safe — wikilinks resolve by note name, so a folder change doesn't break `[[links]]`. Update both folders' indexes in the same pass.
- **Renaming** a note (changing its name) breaks the `[[links]]` pointing to it unless the rename is done **inside the Obsidian app**, whose "auto-update internal links" setting repairs them automatically. A shell `mv`, or any rename outside the app, does not. So do renames in the app; if the AI must rename a file directly, it then has to find and fix every `[[old name]]` reference by hand.

## Checkpoint Persistence

Whenever something changes that a future session would need to know, persist it without being asked: update the relevant note, today's daily note, and (only for a new always-on rule) CLAUDE.md. Then scan the touched folder's index and any cross-referenced notes for drift and fix it in the same pass. The vault is the memory — keeping it current is not busywork, it's maintaining the system itself.

## Archiving

When Isaac says something is done or asks to archive a note: (1) set its frontmatter `status: archived` and save; (2) move it to the Archive folder, same filename; (3) confirm what was archived and where. Always confirm before archiving. Never archive on your own initiative.

## Daily Notes

Daily notes capture what happened across all of Isaac's work sessions for a day. They live in `01 - Daily Notes/`, in month subfolders named `NN - Month YYYY` (`01 - Daily Notes/09 - September 2026/`) from the very first note, never once the folder fills up -- a convention that starts later means two sessions reading two files disagree about where today's note goes. Filename `YYYY-MM-DD.md`. Frontmatter `status: active`, `project: personal`, `type: log`.

Start the body with a human-readable date heading (`# Monday, June 8, 2026`). Then, right after it, an **`## Index`** block: one bold-topic line per session/entry with a one-sentence outcome. The index makes a day with many entries scannable instead of a wall of prose. Then the entry body follows `01 - Daily Notes/Daily Note Template.md` — create every daily note FROM that template (What Got Done · What's Still In Progress · Decisions Made · Notes Touched · Profile Updates); never hand-roll one.

If today's note already exists from an earlier session, append a new session section (`## Session 2`, `## Evening Session`) and add a line to the Index block — don't overwrite. Timestamp each entry with the person's local time.

#### Trigger 1: Wrap-Up Signal
Never ask Isaac if he's done working. When he signals it ("I'm done," "calling it," "goodnight"), offer to create or update today's daily note. Always check the actual current date and time first — conversations can stay open overnight.

#### Trigger 2: Review Yesterday's Note at Start of Conversation
At the start of every conversation, after reading `VAULT-INDEX.md`, check yesterday's daily note (or the most recent weekday if today is Monday).
- **If it doesn't exist:** create it from whatever context you have (chat history, session context), and say it's reconstructed and may be incomplete. Zero context for that day → assume a day off and skip it. Don't create empty daily notes.
- **If it exists:** read it; if you have context it's missing, append a session section; otherwise leave it alone.

This is universal — every AI that reads this vault does it. Isaac uses multiple AIs across multiple sessions, no single one sees everything, so each contributes what it knows and the daily note fills in over time. Don't make a production of it. Briefly say what you did and move on.

## Living Profile

`VAULT-INDEX.md` is a living document. Update its profile sections as you learn new things about Isaac through conversation. Updates happen silently and are logged in the daily note under "Profile Updates."

**You can update:** Key People · How I Think · Health · Personal Interests · Beliefs · Daily Routine.
**You must NOT update:** Who I Am (basic bio — only Isaac changes it) · the project sections · What's Active Right Now (lives in Active Priorities) · My Preferences for Working with AI · Vault Rules for AI.
**Vault Structure is a special case:** never rewrite it on your own initiative, but when a folder is actually created, renamed, or removed, updating the map is part of that change — do it in the same pass.

Judgment: a passing mention is not a personality trait. Check for duplicates/contradictions; if new info contradicts an entry, update that entry rather than adding a second. Match existing tone. Never remove an entry unless explicitly contradicted. Fewer, higher-quality updates.

Log every profile update in the daily note's "Profile Updates" section (e.g. "**Personal Interests:** added woodworking").

## Who approves what

- **Isaac only:** `VAULT-INDEX.md`, these Vault Rules, the Memory Standard, the Project Notes Standard, everything in `08 - Resources/Onboarding/` and its `kit/` folder (the boot template, skills, hooks, scripts, plugin list), the Junior Checks note, and any change to a risk's severity or an acceptance of risk in the Security Register.
- **Either founder can "lock it":** a project decision, a finding, a Status or Architecture change, a Log rotation, a priorities change, and everything else in the vault. Tolu approves in the projects he leads. An approval is an explicit "lock it" or "approved" from a founder in the conversation; Junior never approves for itself.
- **Waiting drafts:** anything with a line starting `> Draft, not confirmed` is a pending approval. The daily digest lists pending items with their age, oldest first, and anything older than seven days goes at the top.

## Names, links and paths

- **Unique names.** A note's file name must be unique across the vault, because links find notes by name. Project notes start with the project name ("BakeFlow Status", "MindBridge Auth Decision"). Company-wide notes get a specific name. Never name a note "Notes", "Decisions" or "Todo".
- **No machine-specific paths** in shared notes. Record repo URLs. A path that only works on one person's machine goes in that person's section and says whose machine it is.
- **Automated check.** The vault check flags duplicate names, links that don't resolve, and Windows user-folder paths in shared notes. It only warns.
