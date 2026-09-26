---
status: active
project: bakeflow
type: reference
author: junior
created: 2026-09-26
updated: 2026-09-26
---
# BakeFlow Architecture

BakeFlow is a mobile-first operations platform for independent Nigerian bakeries, built as an Expo mobile app on a Supabase backend. Draft, not confirmed: written by Junior from the repo's own documents on 2026-09-26.

## What it is
Connects orders, inventory, production, deliveries and finance so a bakery owner gets accurate financial visibility without bookkeeping knowledge. It is multi-tenant: the tenant is the Organization (one bakery business), which owns Branches (locations). All operational data is scoped to a Branch and its Organization.

## Repos and folders
- **Main repo:** https://github.com/isaaCecurity/-Davila-B-B (default branch `main`, private-development stage). CI runs `ci.yml`, CodeQL and dependency review.
- **Marketing website:** a separate single-file static site (`index.html` plus an embedded copy of the real prototype in `app/`, no build step). Isaac's copy is at `C:\Users\HP\Downloads\bakeflow-website` (machine-specific). It embeds the prototype in a device frame and runs a scripted order walkthrough.
- **Layout of the main repo:** `docs/` (product overview and the "Engineering Bible" specs), `bakeflow-frontend/` (npm workspaces: `apps/mobile` plus 8 shared packages: api, auth, config, hooks, types, ui, utils, validation), `supabase/` (migrations, seed, 2 edge functions), `tests/` (pytest spec-coverage and SQL suites), `audit-findings/`.
- The repo has its own control files at its root. Read them before working: `CLAUDE.md` (rules), `BACKEND_ROADMAP.md`, `CURRENT_TASK.md`, `BLOCKERS.md`, `NOTIFICATIONS.md`, `ARCHITECTURE_DECISIONS.md`, `TECHNICAL_DEBT.md`, `IMPLEMENTATION_LOG.md`.

## Stack
- **Mobile:** React Native with Expo (SDK 57, RN 0.86, React 19), Expo Router, TypeScript, NativeWind.
- **State:** Zustand (client) and TanStack Query (server).
- **Backend:** Supabase: PostgreSQL 17, Auth, Storage, row-level security, 2 edge functions (`send-invite-email`, `dispatch-push`).
- **Web app:** reserved for management and analytics; not built.

## Rules the repo treats as non-negotiable (summary; the repo's `CLAUDE.md` is authoritative)
- Tenant column is `tenant_id`, set explicitly on every insert; row-level security on every table.
- Money is `NUMERIC(19,4)`, never float; rounding only at display or settlement.
- UUID primary keys; stock changes only through an immutable `stock_movements` ledger.
- No silent deletes of business-critical data; every significant event is auditable.
- "Ticket" is the canonical customer-order entity. Seven roles: Owner, Admin, Branch Manager, Cashier, Baker, Driver, Supervisor.
- The runnable prototype ("BakeFlow frontend design") is the visual source of truth for every screen port.

## Environments
- **Database:** live Supabase project (its reference is in the repo's `CLAUDE.md`). The live database outranks every `.sql` file and document in the repo: the committed migrations share no version with the ones recorded live, so reconcile before assuming they match.
- Other environments: Not recorded yet.

## Integrations
- **Supabase:** database, auth, storage. Credentials are in `.env` files (see `.env.example`); never copy values here.
- **Resend:** invite email, through the `send-invite-email` edge function; falls back to a mock provider when the key is absent.
- **Expo push (FCM and APNs):** wired through the `dispatch-push` edge function, credentials not yet set up.

## Run and test
From the repo root: `python -m pytest -q` (spec-coverage tests). From `bakeflow-frontend/`: `corepack npm install` (npm pinned to 10.8.2, Node 22.13 or later), `npm run dev:mobile`, and `npm run typecheck`, `npm run lint`, `npm run deps:check` with `--workspace apps/mobile`, plus `npm test` for Jest. SQL suites run through `tests/run_sql_suites.py`.

## Security notes
Tenant isolation rests on row-level security. The repo records 0 of 109 RLS policies use `has_permission()` (64 use `has_role()`), so role-based RLS is authoritative and the permission keys are effectively client-side (TD-001). Evidence buckets are branch-scoped, and clients can't delete or overwrite evidence files (AD-028, AD-030).

## Open questions
Isaac to confirm this draft. Which environments exist beyond the live project? How does deployment to the app stores work?

## Sources read for this draft
`README.md` and `CLAUDE.md` in full, the marketing site's `README.md`, the top of the control files listed in [[BakeFlow Status]], `git log`, and directory listings.

## Related
- [[BakeFlow Status]]
- [[BakeFlow Log]]
