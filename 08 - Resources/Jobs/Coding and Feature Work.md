---
status: active
project: meta
type: guide
author: junior
created: 2026-09-26
updated: 2026-09-27
---
# Coding and Feature Work

**The job:** Build, fix, or review code for any Undeify project. Fires whenever Isaac or Tolu asks for a feature, a bug fix, or a code review.

## Boot chain (read these, in order, and you have the skill)
1. This note, end to end.
2. The project being worked on: [[MindBridge]], [[BakeFlow]], [[ShiftOS]], or [[Lingora]]. Read its Status and Architecture notes (see [[Session Handoff and Resume]]) — where the code lives, where we stopped, what's next.
3. [[Active Priorities]] — whether this work is tied to a current priority.

## The procedure
1. Identify which project the task belongs to and read its index.
2. Read the code involved before proposing changes: search for the right files, then read those files or the relevant ranges. Never open a large file whole (see [[Project Notes Standard]], section 6).
3. State the plan in plain language, including which files change. Wait for Isaac's confirmation before any edit, commit, push, or deploy (boot config rule).
4. Prefer approaches that save time. Isaac and Tolu want to use loop engineering and graph engineering; ask Isaac how they want those applied and record the answer under Lessons.
5. Make the change, then check it works by running it or its tests. Don't claim it works without evidence.
6. Do a security pass: input handling, authentication, secrets, dependencies.
7. Run the handoff from [[Session Handoff and Resume]]: update the project's Status (where we stopped), Log, Architecture if needed, and today's daily note. Do it at every milestone, not just at the end.

## Quality bar
- Verified by running it, not assumed.
- No secrets in code or notes; point to where they're stored.
- Security considered on every change, since secure solutions are core to Undeify.
- Explained so someone new to SaaS can follow.

## Lessons (fold corrections in here over time)

### Narrate a long task while it runs, don't just report at the end
- **What happened:** 2026-09-27, ShiftOS production-readiness audit. Batch 1 said as it went which files, folders and commands it was checking, and Isaac could follow it. Batch 2 ran silently and handed over a finished report. He asked for the Batch 1 style back.
- **Root cause:** Treating the written report as the deliverable. For Isaac the search path is part of the work — it's how he sees whether the audit covered what it claims, and he's still learning SaaS, so watching where the evidence comes from teaches him the system.
- **Do this next time:** On any long, multi-step job (audit, investigation, debugging, big refactor), say in one short line what you're about to look at and why, then one line on what came back — including passes and dead ends. A running commentary, not a second report. Still write the full deliverable at the end. In the VS Code extension these lines stay visible to him; in a plain terminal they may not, so there, fold the trail into the final message.
