---
status: active
project: meta
type: reference
author: junior
created: 2026-09-26
updated: 2026-09-28
---
# Memory Standard

The rules for what goes into this vault and how. Isaac, Tolu, and every AI that touches the vault follow it. The point: a shared memory that stays small, true, and easy to find things in. If a note doesn't meet this standard, fix it or don't save it.

This vault is shared by Isaac and Tolu through a private Git repo. Write everything so the other person can pick it up cold.

## 1. What belongs in the vault

Save it if a future session, or the other founder, would be worse off without it. Every kind of memory has one home:

| Kind of memory | Home | `type` | Starting `status` |
|---|---|---|---|
| A decision and the reason for it | The project folder (company-wide: `08 - Resources`) | `reference` | `active` |
| Project facts: architecture, stack, repos, environments, where things live | The project's folder | `reference` | `active` |
| A tool or service we chose or rejected: what it does, cost, why | Project folder, or `08 - Resources` if used by several | `reference` | `active` |
| A security finding, risk, or incident, and the fix | The project's folder | `reference` | `active` |
| A lesson learned: something that failed or worked, and what to do next time | The relevant Job note under Lessons, or the project folder | `guide` | `active` |
| A repeatable procedure or runbook | `08 - Resources/Jobs` or the project folder | `guide` | `active` |
| A marketing result or learning: what we posted, what worked, the numbers | `08 - Resources` (marketing notes) | `reference` | `active` |
| A raw idea | Project folder, or `00 - Inbox` if it has no project yet | `plan` | `idea` |
| An open task | `Active Priorities.md`, never its own note | n/a | n/a |
| What happened today | The daily note | `log` | `active` |
| People we work with (partners, advisers, contacts) | Key People in `VAULT-INDEX.md` if important, else the relevant project note | n/a | n/a |

Anything that fits no row goes in `00 - Inbox`, and gets sorted at the next review.

For project work (Status, Architecture, Log, Decisions, handoffs and how to resume), the exact layout and routines are in [[Project Notes Standard]]. That note governs where a project's notes live.

## 2. What never goes in

- **Secrets.** Passwords, API keys, tokens, private keys, connection strings, `.env` contents. Write where it's stored ("in the team password manager, item X"), never the value.
- **Customer or user personal data.** Emails, phone numbers, names tied to accounts, payment details. Describe the shape ("users table has email and phone"), never real records.
- **Private personal material.** The vault is shared. Nothing goes in that Isaac or Tolu wouldn't want the other to read. `06 - Personal` is for non-work notes both are fine sharing.
- **Anything derivable from the code or Git history.** Don't copy code, file lists, or commit logs into notes. Link to the repo or file instead.
- **Raw transcripts and chat dumps.** Save the conclusion, not the conversation.
- **Guesses presented as facts.** If it's unverified, say so in the note (see "Sources and confidence").
- **Duplicates.** If a note on the topic exists, update it.
- **Scratch work.** Temporary files, intermediate outputs, one-off fixes with no lesson in them.

## 3. Standards every note meets

**Frontmatter, on every note:**

```yaml
---
status: active
project: mindbridge
type: reference
author: isaac
created: 2026-09-26
updated: 2026-09-26
---
```

- `status`, `project`, `type` use the values in [[Vault Rules]].
- `author` is who wrote it: `isaac`, `tolu`, or `junior`. If an AI drafted it for someone, use `junior`. If several people edit it, keep the original author and add the editor to the change log line at the bottom.
- `created` is the date first written. `updated` changes on every edit. Check the real system date first.

**Name:** a specific title, unique across the vault (wikilinks find notes by name). "MindBridge Auth Decision", not "Decision". No dates in names except daily notes.

**One topic per note.** If it needs a second heading about something unrelated, it's two notes.

**First line is the summary.** One sentence under the title saying what this note is and what state it's in. A reader should know whether they need it without reading the rest.

**Sources and confidence.** State where a fact came from (repo file, vendor pricing page, a person, an experiment) and when it was checked. Anything not checked yet carries the words "Unverified". Prices, limits, and vendor claims go stale, so date them.

**Links.** Link people, projects, products, and related notes as the vault rules say. Every new note is listed in its folder's index in the same pass.

**Supersede, don't accumulate.** When something changes, edit the note to the new truth. If the old answer matters as history, add a short "Previously" line with the date. Don't leave two versions.

## 4. Note shapes

Use these shapes so notes read the same regardless of who wrote them.

**Decision**
```markdown
# [Specific Title]
One sentence: what we decided.

- **Decided by:** Isaac / Tolu / both, on [date]
- **Context:** the problem, in two or three lines
- **Options considered:** each with one line on why it lost or won
- **Why:** the deciding reason
- **Cost and risk:** money, time, security, lock-in
- **Revisit when:** the condition that would reopen this
```

**Lesson**
```markdown
# [Specific Title]
One sentence: the lesson.

- **What happened:**
- **Root cause:**
- **Do this next time:**
```

**Tool or service**
```markdown
# [Tool Name]
One sentence: what we use it for and whether it's chosen, trialled, or rejected.

- **What it does:**
- **Cost:** [amount, checked on date, source]
- **Why us:** and what we passed over
- **Security and data notes:**
- **Where the account/credentials live:** [location only, never values]
```

**Idea** (`status: idea`)
```markdown
# [Specific Title]
One sentence: the idea.

- **Problem it solves and for whom:**
- **How it could earn money:**
- **Cheapest way to test it:**
- **Open questions:**
```

**Runbook**: numbered steps, then "If it goes wrong". Test the steps before saving.

## 5. Who writes what

- **Junior writes directly, then reports what it saved:** daily notes, project facts, tool notes, lessons, ideas, and updates to existing notes.
- **Junior drafts and waits for "lock it":** decisions, security findings, and anything that changes a Job's procedure. Until locked, the note carries `status: idea` and, near the top, a line that starts exactly `> Draft, not confirmed` (the vault check finds pending approvals by that line, and removing it is the approval).
- **Active Priorities:** Junior may add items. It removes one only when the work is verified done, and moves it to Completed Tasks.
- **Status changes:** Junior moves notes between `active`, `parked` and `completed` on its own, from evidence, and reports each change in one line. It never promotes a draft (`idea` → `active`) or archives without a founder. The rule and thresholds are in [[Vault Rules]] under Status tracking.
- **Only Isaac, in a direct session, changes:** [[Vault Rules]], this standard, and the boot file `CLAUDE.md`.
- **Content Isaac or Tolu wrote:** don't rewrite it silently. Edit to fix errors or update facts, and note the change and the editor at the bottom ("Updated 2026-10-02 by Tolu: corrected pricing").
- **Disagreement between notes or people:** don't pick a winner in the file. Record both positions, mark the note `Needs decision`, and put a line in Active Priorities.

### When Junior should save something

Without being asked, Junior saves when it sees any of these: a decision made, a tool chosen or rejected, a security issue found, a lesson learned, a fact about a project that a stranger would need, a marketing result, an idea that's more than a passing remark, or a recurring task explained twice. It then says in one line what it saved and where.

## 6. The write routine

Every write follows the same steps:

1. **Pull first, with rebase.** Run `git pull --rebase` so your copy has the other person's changes before you write, and again just before you push.
2. **Search before creating.** Look for an existing note on the topic. Update it if there is one.
3. **Check it against section 2.** Nothing secret, nothing personal, nothing derivable.
4. **Write it** in the right home, with full frontmatter and the right shape.
5. **Update the folder index** and, if a folder was added, the Vault Structure map. Add a line to today's daily note.
6. **Read it back** to confirm it saved and reads right.
7. **Commit and push** with a message in the form `Add: MindBridge auth decision (Junior for Isaac)` or `Update: ...` / `Archive: ...`. One logical change per commit.

## 7. Sync rules

- The vault is a Git repo synced through a private GitHub repo. Each founder keeps their own local copy.
- Pull before writing, push after. If a push is rejected, pull, resolve, then push. Never force-push.
- If two people edited the same note and Git reports a conflict, keep both versions' content, merge by hand, and tell the other person.
- Never commit `.obsidian/workspace.json` or other personal Obsidian state; the `.gitignore` covers it.

### Secret scan
The vault has a `pre-commit` hook (`.githooks/pre-commit`, switched on by the onboarding script) that blocks a commit adding a secret-bearing file (`.env`, keys, certificates, service-account JSON) or secret-looking content (cloud keys, GitHub and Slack tokens, Stripe, Paystack and Flutterwave keys, JWTs, database URLs with passwords, `password = ...` style values). It is a safety net, not permission to be careless. To clear a false positive, add `allowlist secret` to the line. If a real secret was ever committed or pushed, treat it as leaked and rotate it.

## 8. Upkeep

Once a week, in about 15 minutes, Junior lists: notes missing frontmatter, notes not in their folder index, `idea` notes older than a month, facts with old check dates, and items in Active Priorities that look done. The review also counts the notes. Junior finds things by searching the vault and following indexes, which is fast at this size. Once the vault passes about 150 notes, or recall starts missing things, add a topic index note and add it to this review. Isaac and Tolu decide what to archive, fix, or delete. Archiving follows the vault rules: Junior asks first.

## Change log
- 2026-09-26, Junior for Isaac: first version.
- 2026-09-28, Junior for Isaac (locked by Isaac): Junior tracks note status from evidence and asks about one quiet item per session.
