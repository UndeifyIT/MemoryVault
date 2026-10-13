---
status: active
project: shiftos
type: reference
author: junior
created: 2026-09-26
updated: 2026-10-13
---
# ShiftOS Status

ShiftOS is a workforce scheduling and operations platform whose backend is marked complete in the repo's own audit; the state of its web and mobile apps is not confirmed.

> Draft, not confirmed. Written by Junior from the repo's documents on 2026-09-26. Isaac to confirm or correct.

This note is a living snapshot. Overwrite it as things change; history goes in [[ShiftOS Log]].

## Snapshot
Checked 2026-10-13 against GitHub `main` and the live backend.
- **Stage:** live in production. Web and mobile apps are in `apps/web` and `apps/mobile`. The backend modules are listed as complete in `docs/backend-completion-audit.md` (2026-08-19/20).
- **Migrations:** 81 in the repo (latest `081_create_backend_role`).
- **Audit fixes merged** on 2026-09-28/29 (PRs #29–#37):
  - Critical: C1+H1 (users identity lock, invitations matched on the verified email)
  - High: H2, H3, H5, H6, H7, H8, H9, H10, H11, H12, H13
  - Medium: M1, M2, M10, M11, M14, M18, M19, M21, M23, M26
  - Low: L9, L16, L19
- **Production backend:** runs `59801cf` (2026-09-29), the latest `main`. Read from its `/health` endpoint, 2026-10-13.
- **Unverified:**
  - Whether migrations 075–081 are applied to ShiftOS's Supabase database. ShiftOS's Supabase project isn't reachable from Junior's Supabase connector, which sees only one other project.
  - Whether `main` is branch-protected (H4).
- **Known issues:**
  - The repo's `audit/.../fixes.md` still says "drafts only, nothing applied". It is stale.
  - `audit/` is still tracked in Git (the repo is private).
  - The README is stale.
  - There is no local clone on Isaac's machine (checked 2026-10-13); clone again before working.
  - The `github.com/ShiftOS` org is an unrelated 2015 project. The real repo is UndeifyIT/ShiftOS.

## Where we stopped
Last repo activity: the audit fixes merged on 2026-09-29. Each person keeps their own section current from here.

### Isaac
Not recorded yet.

### Tolu
Not recorded yet.

## Next steps
1. Isaac to confirm this draft and say what ShiftOS work is current.
2. Confirm migrations 075–081 are applied in ShiftOS's Supabase project (Isaac or Tolu, from the Supabase dashboard).
3. Mark the merged fixes in the repo's `audit/.../fixes.md` so it stops saying nothing was applied.
4. Refresh the stale `README.md`.

## Sources read for this draft
`README.md`, `package.json`, the top of `docs/README.md` and `docs/SHIFTOS-MASTER-SPECIFICATION.md`, the start and end of `docs/backend-completion-audit.md`, and directory listings. The master specification and the audit were not read start to finish.

## Related
- [[ShiftOS Architecture]]
- [[ShiftOS Log]]
