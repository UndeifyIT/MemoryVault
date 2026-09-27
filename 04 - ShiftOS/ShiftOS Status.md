---
status: active
project: shiftos
type: reference
author: junior
created: 2026-09-26
updated: 2026-09-26
---
# ShiftOS Status

ShiftOS is a workforce scheduling and operations platform whose backend is marked complete in the repo's own audit; the state of its web and mobile apps is not confirmed.

> Draft, not confirmed. Written by Junior from the repo's documents on 2026-09-26. Isaac to confirm or correct.

This note is a living snapshot. Overwrite it as things change; history goes in [[ShiftOS Log]].

## Snapshot
- **Stage:** The repo's `README.md` says it is an empty scaffold with no business logic. That is out of date: `docs/backend-completion-audit.md` (dated 2026-08-19/20) lists organizations, branches, employees, roles and permissions, memberships, invitations, schedules, shifts, assignments, tasks, announcements, shift notes, attendance and leave requests as complete, each live-tested against the real Supabase project. The repo also has 71 migrations (latest numbered 073), a web app in `apps/web` and a mobile app in `apps/mobile`, both with source folders.
- **Not implemented (per the audit):** shift swaps, departments, reporting and analytics. Audit logs, security events, notification preferences and delivery attempts exist in the database only.
- **Not tested (per the audit):** the HTTP transport layer, real Supabase Auth JWT checks for the newly built operations, and any frontend integration for them.
- **Known issues:** the README is stale.
- **Fixed 2026-09-27:** the local copy at `C:\Users\HP\ShiftOS-main` had no Git history (it was a downloaded zip). It's now a real clone of `https://github.com/UndeifyIT/ShiftOS.git`, on `main`, clean, up to date with origin. Correction: the org `github.com/ShiftOS` named earlier in this note is wrong — that's an unrelated 2015 Linux-distro project. The real repo is under `UndeifyIT`.

## Where we stopped
Not recorded. The latest dated documents are the plans in `docs/superpowers/plans/`, the newest being `2026-09-06-schedule-grid-rebuild.md`, and the backend audit dated 2026-08-19/20. Each person keeps their own section current from here.

### Isaac
Not recorded yet.

### Tolu
Not recorded yet.

## Next steps
1. Isaac to confirm this draft and say what ShiftOS work is current.
2. Refresh the stale `README.md` so it matches the audit.

## Sources read for this draft
`README.md`, `package.json`, the top of `docs/README.md` and `docs/SHIFTOS-MASTER-SPECIFICATION.md`, the start and end of `docs/backend-completion-audit.md`, and directory listings. The master specification and the audit were not read start to finish.

## Related
- [[ShiftOS Architecture]]
- [[ShiftOS Log]]
