---
status: active
project: shiftos
type: reference
author: junior
created: 2026-09-26
updated: 2026-09-27
---
# ShiftOS Architecture

ShiftOS is a multi-tenant workforce platform built as a pnpm monorepo on Supabase, with a React web app and an Expo mobile app.

> Draft, not confirmed. Written by Junior from the repo's documents on 2026-09-26.

## What it is
Shift scheduling, attendance, tasks, announcements and leave for organizations with branches. Its documentation is organized as a "product bible" of numbered domain volumes: organization, user and identity, roles and permissions, employee, shift, scheduling, attendance, task management, communication, notifications, reporting, security and more. The docs also describe "Shifty", an AI assistant (`docs/shifty`).

## Repos and folders
- **GitHub:** https://github.com/UndeifyIT/ShiftOS (verified 2026-09-27 against the local clone's remote). Isaac's local copy (machine-specific) is `C:\Users\HP\ShiftOS-main`, a real clone on `main`. Previously recorded as `github.com/ShiftOS`, which was wrong (unrelated org).
- **Layout:** `apps/web` (React, Vite, Tailwind, Vercel config), `apps/mobile` (Expo React Native), `packages/` (api, auth, authorization, backend, config, constants, database, errors, geography, repositories, services, tests, types, ui, utils, validation), `supabase/` (71 migrations and a policies folder), `docs/`.

## Stack
- pnpm workspaces (pnpm 11.20), TypeScript strict, ESLint, Prettier, Vitest for unit and integration tests.
- Supabase (PostgreSQL, Auth, Storage) as the backend.
- Layered flow per the audit: UI or RPC call, then service, then repository, then Postgres, with an `RpcRegistry` that executes operations.

## Environments
Live Supabase project (its reference is in the audit; not copied here). Other environments: Not recorded yet.

## Integrations
Supabase only, as far as the documents show. The database connection string lives in the repo's `.env` (`DATABASE_URL`); never copy values here.

## Run and test
`pnpm install`, then `pnpm dev:web`, `pnpm start:mobile`, `pnpm build:web`, `pnpm typecheck`, `pnpm lint`, `pnpm test` (Vitest). `pretest` builds all TypeScript references first.

## Security notes
Operations are permission-gated and branch-gated. Audit logs and security events are append-only. Avatars are served through signed URLs. The audit records that the database connection uses verified TLS certificates. It also notes that JWT verification for the newly built operations wasn't tested at the HTTP layer.

## Open questions
Isaac to confirm this draft. Where is it deployed, and what is current?

## Sources read for this draft
`README.md`, `package.json`, the top of `docs/README.md` and the master specification, the start and end of `docs/backend-completion-audit.md`, and directory listings.

## Related
- [[ShiftOS Status]]
- [[ShiftOS Log]]
