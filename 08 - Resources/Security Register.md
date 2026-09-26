---
status: active
project: meta
type: reference
author: junior
created: 2026-09-26
updated: 2026-09-26
---
# Security Register

Undeify's running record of security risks, findings and incidents, plus the incident-response runbook and the recurring checks. Junior owns it as CISO. Never write a secret value here; name where it lives.

## 1. Open risks

Severity is Junior's judgment (low, medium, high). "From repo docs" means it comes from a project's own documents and Junior has not verified it.

| ID | Project | Risk | Severity | Owner | Next step |
|---|---|---|---|---|---|
| SR-001 | Vault | The vault has no remote yet, so there is no backup and no sharing. | Medium | Isaac | Create the private GitHub repo and push. |
| SR-002 | Kit | The Playwright MCP server runs `npx @playwright/mcp@latest`, so each start fetches the newest version. Accepted for now. | Low | Isaac | Pin a version if it ever matters. |
| SR-003 | BakeFlow | `has_permission()` gates 0 of 109 RLS policies; role checks are authoritative and the permission keys are effectively client-side (repo TD-001). | Medium | Isaac | Decide whether to accept it or migrate. From repo docs. |
| SR-004 | BakeFlow | Committed migrations don't match the versions recorded on the live database, so the repo can't rebuild production. | Medium | Isaac | Reconcile per the repo's `docs/PROJECT-OVERVIEW.md`. From repo docs. |
| SR-005 | ShiftOS | Real Supabase JWT verification for the newly built operations was not tested at the HTTP layer. | Medium | Isaac, Tolu | Test with a real session. From repo audit. |
| SR-006 | Team | Composio (planned) would hold OAuth access to every connected account, which makes it one high-value target. | Medium | Isaac | Follow the least-privilege steps in [[Onboarding]] before connecting apps. |
| SR-007 | Repos | The vault's secret scan covers only the vault. Project repos have no scan unless a hook is installed. | Medium | Junior | Install the local guard hook per repo (see [[Onboarding]]). Done for the BakeFlow repo on Isaac's machine, 2026-09-26. The ShiftOS copy has no `.git` folder, so it can't be guarded until it is a real clone. |

## 2. Findings and incidents
Append-only, newest last. One line each: `date | project | what was found or happened | severity | status | link to the fix`.

2026-09-26 | Vault | Register created with the seven open risks above | n/a | open | none

## 3. Incident-response runbook
Use it for a leaked secret, a suspected breach, a compromised account or a data exposure.
1. **Contain first.** Revoke or rotate the exposed key or token, sign out sessions, disable the account or feature. Don't wait to understand it fully.
2. **Preserve evidence.** Note the time, what was exposed, where, and who saw it. Don't delete logs.
3. **Assess.** What data or access was reachable, for how long, and was it used? Check the provider's logs (Supabase, GitHub, Google).
4. **Fix the cause.** Close the hole, then rotate anything that shared the same secret or trust.
5. **Notify.** Tell the other founder immediately. If customer or user personal data may be involved, get advice on notifying users and the regulator. Nigeria's data-protection law is understood to set a 72-hour window for notifying the regulator after a breach. Unverified: confirm with a lawyer before relying on it.
6. **Record.** Add the line in section 2, update the risk table, and save the lesson as a note per the Memory Standard.

## 4. Recurring checks
- **Weekly:** review open risks; run the dependency audit for each project (`npm audit` or `pnpm audit`); confirm the vault is pushed.
- **Monthly:** run the Tool Register review (access, owners, keys due for rotation); test that a vault backup restores.
- **Before each release:** run the security review (security-guidance, and claude-security or semgrep if installed) and re-check the open risks for that project.

## Change log
- 2026-09-26, Junior for Isaac: first version.
