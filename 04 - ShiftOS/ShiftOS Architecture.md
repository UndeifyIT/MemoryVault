---
status: active
project: shiftos
type: reference
author: junior
created: 2026-09-26
updated: 2026-09-28
---
# ShiftOS Architecture

ShiftOS is a multi-tenant workforce platform built as a pnpm monorepo on Supabase, with a React web app on Vercel, a Node RPC backend on Render and an Expo mobile app. Checked by Junior on 2026-09-28 against the repo and the hosting dashboards.

## What it is
Shift scheduling, attendance, tasks, shift notes, announcements, swap and leave requests, reports and notifications for organizations with branches. Four roles: Manager (organization-wide), Admin, Supervisor (branch-scoped) and Staff. The screens follow the design handoff in the repo's `Local file check/design_handoff_shiftos` folder. The docs also describe "Shifty", an AI assistant (`docs/shifty`).

## Repos and folders
- **GitHub:** `UndeifyIT/ShiftOS`, default branch `main`. Work lands through pull requests.
- **Layout:** `apps/web` (React, Vite, Tailwind), `apps/mobile` (Expo React Native), `packages/` (api, auth, authorization, backend, config, constants, database, errors, geography, repositories, services, tests, types, ui, utils, validation), `supabase/migrations`, `docs/`, `audit/`, and `tools/handoff-preview` (renders the design handoff locally for comparison).

## Stack
- pnpm workspaces, TypeScript strict, ESLint, Prettier, Vitest.
- Supabase: PostgreSQL, Auth, Storage.
- Request flow: the web app POSTs to the backend's `/rpc/<operation>`; each operation runs service, then repository, then Postgres. Operations are registered in `packages/api/src/registry.ts`, and one that isn't registered fails.

## Environments
- **Web:** Vercel project `shiftos-web` in the `undeifyit` team, production at `shiftos-web.vercel.app`. Deploys automatically from `main`, but commits by authors outside the Vercel team are blocked until redeployed by hand.
- **Backend:** Render web service `shiftos-backend-api` (Frankfurt, free plan) at `shiftos-backend-api.onrender.com`. Build `pnpm run build`, start `node packages/backend/dist/server.js`, auto-deploy from `main`. The free plan sleeps when idle, so the first request after a quiet spell is slow and the scheduled notification job doesn't run while it sleeps.
- **Database:** one Supabase project (EU Central), used by both. Its reference and keys live in the repo's `.env` files; never copy values here.
- A second Render service, `shiftos-backend`, is dead (every build failing since 2026-08-30).

## Integrations
- Supabase only for data and auth. Email and WhatsApp notification delivery are not connected; notifications are in-app.
- Credentials: the database URL, service-role key and anon key live in `.env` (ignored by Git) and in the Render and Vercel environment settings. `apps/web/.env.production` is committed and holds only the public Supabase URL and anon key.

## Run and test
`pnpm install`, then `pnpm dev:web`, `pnpm dev:backend`, `pnpm start:mobile`, `pnpm build`, `pnpm typecheck`, `pnpm test:unit`, `pnpm test:integration` (needs a database). Migrations are applied to Supabase in number order.

## Security notes
- Every operation checks a permission and branch access on the server; hiding UI is convenience only.
- Audit logs and security events are append-only. Avatars are served through signed URLs.
- Scheduled notifications record each send in `notification_dispatches`, so they go out once even if the job runs twice.
- Open risks and fixes: the repo's `audit/2026-09-27-production-readiness/`.

## Open questions
- Should the backend move off Render's free plan so the scheduled job runs reliably?

## Related
- [[ShiftOS Status]]
- [[ShiftOS Log]]

Previously (2026-09-26): drafted from a downloaded zip; it named the wrong GitHub organization and had no deploy details.

