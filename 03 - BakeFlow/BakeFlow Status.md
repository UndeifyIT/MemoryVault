---
status: active
project: bakeflow
type: reference
author: junior
created: 2026-09-26
updated: 2026-09-26
---
# BakeFlow Status

BakeFlow's backend is live and its mobile app is mostly built; offline sync and the web app are not. Draft, not confirmed: written by Junior from the repo's own documents on 2026-09-26. Isaac to confirm or correct.

This note is a living snapshot. Overwrite it as things change; history goes in [[BakeFlow Log]]. The repo keeps its own detailed control files (`CURRENT_TASK.md`, `BLOCKERS.md`, `NOTIFICATIONS.md`, `ARCHITECTURE_DECISIONS.md`, `TECHNICAL_DEBT.md`, `IMPLEMENTATION_LOG.md`). They are the source of truth for task-level detail; this note summarizes and points to them and never copies them.

## Snapshot
- **Stage:** Active development. The repo says the backend is live on Supabase (44 tables in `public`, all with row-level security) and the Expo mobile app has 48 route files, 44 of 46 routes implemented on live data, and 47 of 57 prototype screens ported (repo status as of 2026-09-20).
- **What works:** sign-in and organization selection, catalog, inventory, production, delivery, sales reports, search, invites (create, resend, revoke), profile editing, in-app notifications, and branch-scoped evidence storage for receipts and delivery proofs (AD-030).
- **Not built:** the offline sync client (the server-side `sync_pull` and `apply_sync_operation` exist) and the web app (`apps/web` is only a `package.json`).
- **Known issues and open items (from the repo docs):**
  - Expo push credentials (FCM and APNs) are an owner action; until then pushes are recorded but not delivered to phones.
  - Phone SMS sign-in and phone invitations are parked beyond MVP.
  - The committed migrations in the repo don't match the versions recorded live, so the live database outranks the repo's `.sql` files (see [[BakeFlow Architecture]]).
  - `deps:check` was reported failing on 2026-09-20 (16 Expo packages behind) and later reported clean when re-run offline; recheck before relying on either.
  - Device revocation for a future sync client is decided (AD-031) but not built.

## Where we stopped
As the repo records it, not from a person's own session:
- **Last completed task:** branch-scoped evidence storage, done and applied live on 2026-09-24 (TD-024 closed, AD-030). The live SQL suite passed 35/35 and a live Storage API test passed 48 of 49 checks, the one miss explained as a short delete-propagation delay.
- **Latest commit seen:** `0812b099`, 2026-09-25, on `main`: covering indexes for 22 foreign keys flagged by the Supabase advisor. Working tree was clean when checked.
- **Active task:** none selected. `CURRENT_TASK.md` says the owner picks the next one.

Each person keeps their own section current from here.

### Isaac
Not recorded yet.

### Tolu
Not recorded yet.

## Next steps
1. Isaac to confirm this draft and choose the next task (nothing is selected in the repo).
2. Decide who sets up the Expo push credentials so phones receive notifications.
3. Decide the order for the remaining pieces: offline sync client, web app, remaining 10 prototype screens.

## Sources read for this draft
`README.md`, `CLAUDE.md` in full; the top of `CURRENT_TASK.md`, `BLOCKERS.md`, `NOTIFICATIONS.md` and `TECHNICAL_DEBT.md`; the end of `IMPLEMENTATION_LOG.md`; `git log`. The long control files were not read start to finish.

## Related
- [[BakeFlow Architecture]]
- [[BakeFlow Log]]
