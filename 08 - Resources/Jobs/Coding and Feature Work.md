---
status: active
project: meta
type: guide
---
# Coding and Feature Work

**The job:** Build, fix, or review code for any Undeify project. Fires whenever Isaac or Tolu asks for a feature, a bug fix, or a code review.

## Boot chain (read these, in order, and you have the skill)
1. This note, end to end.
2. The index of the project being worked on: [[MindBridge]], [[BakeFlow]], [[ShiftOS]], or [[Linhora]] — where the code lives and what's recorded about it.
3. [[Active Priorities]] — whether this work is tied to a current priority.

## The procedure
1. Identify which project the task belongs to and read its index.
2. Read the code involved in full before proposing changes.
3. State the plan in plain language, including which files change. Wait for Isaac's confirmation before any edit, commit, push, or deploy (boot config rule).
4. Prefer approaches that save time. Isaac and Tolu want to use loop engineering and graph engineering; ask Isaac how they want those applied and record the answer under Lessons.
5. Make the change, then check it works by running it or its tests. Don't claim it works without evidence.
6. Do a security pass: input handling, authentication, secrets, dependencies.
7. Record what changed in today's daily note and in the project's notes.

## Quality bar
- Verified by running it, not assumed.
- No secrets in code or notes; point to where they're stored.
- Security considered on every change, since secure solutions are core to Undeify.
- Explained so someone new to SaaS can follow.

## Lessons (fold corrections in here over time)
- None yet.
