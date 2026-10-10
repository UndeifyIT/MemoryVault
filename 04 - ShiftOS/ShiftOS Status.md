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
- **Repo:** https://github.com/UndeifyIT/ShiftOS, default branch `main`. Head is `1a11443` (PR 28, the Admin console, merged 2026-09-28). 40 commits landed on `main` since 2026-09-20.
- **Live:** web on Vercel (project `shiftos-web`) and backend on Render (service `shiftos-backend-api`), both running `1a11443` as of 2026-09-28. Details in [[ShiftOS Architecture]].
- **Database:** Supabase migrations applied through 074, matching `main` since PR 28 merged.
- **Built to the design handoff and merged:**
  - Manager: Overview, Schedules, Employees, Supervisors, Admins, Tasks, Recent Activity, Announcements, Requests, Reports, Settings.
  - Supervisor: Today's Shift, Schedules, Team, Attendance, Tasks, Recent Activity, Requests, Shift Notes, Announcements, Settings.
  - Staff (PR 27): My Shift, My Schedule, My Requests, Announcements, My profile.
- **Checked pixel by pixel against the handoff:** Manager Recent Activity, Announcements, Requests, Reports, Settings, and every Supervisor page. Staff, Admin and the older Manager pages have not been checked since they merged.
- **Notifications:** the handoff's full Settings list sends real in-app notifications, including a scheduled job in the backend (every 10 minutes) for unpublished schedules, invitation outcomes and a Monday acknowledgement digest. Email and WhatsApp delivery are not connected.
- **Tests:** on `main`, `tsc -b` is clean and 181 unit tests pass (checked 2026-09-28). Integration tests need a database and were not run.

## Known issues
- **Launch blocker: sign-up emails only reach our own team.** Auth mail goes through Supabase's built-in sender (`noreply@mail.app.supabase.io`). Per Supabase's docs (checked 2026-09-28) it refuses to deliver to anyone who isn't a member of the Supabase project team, has a small hourly cap and no delivery guarantee. So a real customer who signs up with email never gets the verification link. Fix: connect a custom SMTP provider in Supabase Auth settings.
- **Google sign-in shows the raw Supabase address.** Google's screen says "continue to etodmfsmvhewihboxcrp.supabase.co", which looks like phishing to a customer. Fix: brand the Google consent screen, and optionally a Supabase custom domain (paid add-on).
- **Sign-in and sign-up checked live on 2026-09-28:** Google sign-in and sign-up both reach Google and return to the site (a real Google sign-up completed on 2026-09-27); email sign-up validates and reaches Supabase and the anti-abuse hook. Nobody has yet completed the profile step after Google sign-up, so that last step is untested.
- **Vercel blocks commits by authors outside the Vercel team.** `08f5ba9` was blocked and had to be redeployed by hand on 2026-09-28. The next such commit will block again until its author joins the team or commits with the email on their Vercel account.
- **Render auto-deploy stalled** from 2026-09-18 to 2026-09-28 (Render had lost GitHub access). Fixed: PR 28 auto-deployed on 2026-09-28.
- **Unused Render service `shiftos-backend`** has failed every build since 2026-08-30 and serves nothing. Candidate for deletion (Isaac's call).
- **Lint:** `pnpm lint` crashes on the whole repo (an ESLint 9 and old-config mismatch that predates this work); linting individual files works.
- **Audit findings:** open items are in the repo at `audit/2026-09-27-production-readiness/findings.md` and `fixes.md`. Not read in full for this note.

## Where we stopped

### Isaac
In progress with Junior (2026-09-28): audit fixes C1 and H1 on branch `fix/c1-h1-users-lockdown`, commit `481c171`, PR 29 open. Migration `075_lock_users_identity_columns.sql` plus integration tests `usersSelfWriteLockdown.integration.test.ts`; the existing invitation test now creates real login rows. Proven offline in an in-memory Postgres (18 checks: the attack works before, is refused after, normal sign-up and invitations still work). Typecheck clean, 189 unit tests pass. **Done and live (2026-09-28):** PR 29 merged (`9dafc5d`), deployed on Vercel and Render, migration 075 applied to Supabase and verified on production (clients can no longer change email, active or deleted status, delete rows, or read users while signed out; invitations match the confirmed login email). Next audit items: H8 (staff reading colleagues' leave reasons), then H3 (separate test database). Production shows no past abuse (every profile email matches its login email).

Production-readiness audit: findings and proposed fixes committed on `main` (`1f2c19c`, `08f5ba9`). Next: decide which fixes from `fixes.md` to build first.

### Tolu
Not recorded by Tolu. From the repo: the Admin console (`feat/staff-and-admin-handoff`, with migration 074) merged as PR 28 on 2026-09-28.

## Next steps
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


