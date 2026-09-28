---
status: active
project: shiftos
type: reference
author: junior
created: 2026-09-26
updated: 2026-09-28
---
# ShiftOS Status

ShiftOS is live in production: the Manager, Supervisor and Staff screens are built to the design handoff, merged to `main` and deployed; the open work is the production-readiness audit and checking the remaining screens against the handoff. Checked by Junior on 2026-09-28 against the repo, Render, Vercel and Supabase.

This note is a living snapshot. Overwrite it as things change; history goes in [[ShiftOS Log]].

## Snapshot
- **Repo:** `UndeifyIT/ShiftOS` on GitHub, default branch `main`. Head is `08f5ba9` (production-readiness audit, 2026-09-27). 40 commits landed on `main` since 2026-09-20.
- **Live:** web on Vercel (project `shiftos-web`) and backend on Render (service `shiftos-backend-api`), both running `08f5ba9` as of 2026-09-28. Details in [[ShiftOS Architecture]].
- **Database:** Supabase migrations applied through 074. `main` only holds up to 073: `074_extend_admin_role` sits on the unmerged branch `feat/staff-and-admin-handoff`, so the live database is one migration ahead of `main`.
- **Built to the design handoff and merged:**
  - Manager: Overview, Schedules, Employees, Supervisors, Admins, Tasks, Recent Activity, Announcements, Requests, Reports, Settings.
  - Supervisor: Today's Shift, Schedules, Team, Attendance, Tasks, Recent Activity, Requests, Shift Notes, Announcements, Settings.
  - Staff (PR 27): My Shift, My Schedule, My Requests, Announcements, My profile.
- **Checked pixel by pixel against the handoff:** Manager Recent Activity, Announcements, Requests, Reports, Settings, and every Supervisor page. Staff, Admin and the older Manager pages have not been checked since they merged.
- **Notifications:** the handoff's full Settings list sends real in-app notifications, including a scheduled job in the backend (every 10 minutes) for unpublished schedules, invitation outcomes and a Monday acknowledgement digest. Email and WhatsApp delivery are not connected.
- **Tests:** on `main`, `tsc -b` is clean and 181 unit tests pass (checked 2026-09-28). Integration tests need a database and were not run.

## Known issues
- **Vercel blocks commits by authors outside the Vercel team.** `08f5ba9` was blocked and had to be redeployed by hand on 2026-09-28. The next such commit will block again until its author joins the team or commits with the email on their Vercel account.
- **Render auto-deploy stalled** from 2026-09-18 to 2026-09-28 because Render lost access to the GitHub repo. It deployed on 2026-09-28; whether auto-deploy now works on its own is Unverified until the next merge.
- **Unused Render service `shiftos-backend`** has failed every build since 2026-08-30 and serves nothing. Candidate for deletion (Isaac's call).
- **Lint:** `pnpm lint` crashes on the whole repo (an ESLint 9 and old-config mismatch that predates this work); linting individual files works.
- **Audit findings:** open items are in the repo at `audit/2026-09-27-production-readiness/findings.md` and `fixes.md`. Not read in full for this note.

## Where we stopped

### Isaac
Production-readiness audit: findings and proposed fixes committed on `main` (`1f2c19c`, `08f5ba9`). Next: decide which fixes from `fixes.md` to build first.

### Tolu
Not recorded by Tolu. From the repo: branch `feat/staff-and-admin-handoff` (last commit 2026-09-26) carries the Admin console and migration 074, which is already applied to the live database but not merged.

## Next steps
1. Merge or close `feat/staff-and-admin-handoff`, so `main` matches the live database (074).
2. Fix the Vercel team membership so commits stop getting blocked.
3. Work through the audit's `fixes.md`, highest risk first.
4. Check Staff, Admin and the older Manager pages against the handoff.
5. Delete the dead Render service `shiftos-backend` if nothing needs it.

## Sources
Checked 2026-09-28: `git log` and branches on `UndeifyIT/ShiftOS`, Render deploy history and logs, Vercel deployments, Supabase migration list, and a typecheck and unit-test run on `main`. Not read: the audit's `findings.md` and `fixes.md` in full.

## Related
- [[ShiftOS Architecture]]
- [[ShiftOS Log]]

Previously (2026-09-26): drafted from a downloaded zip with no Git history; it wrongly said shift swaps, departments and reporting were unbuilt.
