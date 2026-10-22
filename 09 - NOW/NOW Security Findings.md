---
status: active
project: now
type: reference
author: junior
created: 2026-10-22
updated: 2026-10-22
---
# NOW Security Findings

Every security gap found in a NOW security review, with the fix and why that fix was chosen, so anyone can see later why a piece of code is the way it is. Started on Isaac's request, 2026-10-22. Cross-project risks stay in [[Security Register]]; this note holds NOW's findings in detail.

**How to read it.** IDs (`NOW-SF-NNN`) are permanent and never reused. Severity is Junior's judgment: Critical, High, Medium, Low. Status is one of: **Open** (no fix yet), **Fixed (uncommitted)**, **Fixed** (with the commit), **Handed to** a task, or **Accepted** (a founder chose to live with it; Isaac only, per [[Vault Rules]]). A finding stays a **draft** until Isaac or Tolu says "lock it".

## Index

| ID | Date | Task | Finding | Severity | Status | Locked |
|---|---|---|---|---|---|---|
| NOW-SF-001 | 2026-10-22 | APP-04 | Session key and ciphertext written in two steps; a read in between signs the member out | Medium | Fixed (#47, c6d71cd) | 2026-10-22 (Isaac) |
| NOW-SF-002 | 2026-10-22 | APP-04 | The image library keeps friends-only photos on disk until sign-out | Medium | Handed to APP-27, MAP-11 | 2026-10-22 (Isaac) |
| NOW-SF-003 | 2026-10-22 | APP-04 | No foreground/background handling for token refresh | Low | Handed to APP-10 | 2026-10-22 (Isaac) |
| NOW-SF-004 | 2026-10-22 | APP-04 | On reopen, the stored public cache shows before the server confirms the session | Low | Handed to APP-10 | 2026-10-22 (Isaac) |
| NOW-SF-005 | 2026-10-22 | APP-04 | Only PT401 counts as signed out; PostgREST token errors don't trigger the wipe | Low | Fixed (#47, c6d71cd) | 2026-10-22 (Isaac) |
| NOW-SF-006 | 2026-10-22 | DB-20 | Prototype `block_pairs` key loses a second, mutual block; one unblock lifts both | High | Fixed (bbf3939, merged in #49, 16a7442) | 2026-10-22 (Isaac) |
| NOW-SF-007 | 2026-10-22 | DB-51 | Prototype `verify_receipt` never marks a receipt used, so one photo receipt works many times | Medium | Fixed (bbf3939, merged in #49, 16a7442) | 2026-10-22 (Isaac) |
| NOW-SF-008 | 2026-10-22 | DB-51 | Two ticket requests at once can both pass the 10-waiting-photos cap | Low | Accepted (Isaac, 2026-10-22) | 2026-10-22 (Isaac) |
| NOW-SF-009 | 2026-10-22 | DB-51 | Uploaded but never-posted photos stay in S3 until the daily clean-up and the BE-26 drain | Low | Handed to BE-20, BE-26 | 2026-10-22 (Isaac) |
| NOW-SF-010 | 2026-10-22 | FND-10 | Guardrail SCP doesn't deny creating IAM users or access keys | Medium | Fixed (af78cfe, merged in #49, 16a7442) | 2026-10-22 (Isaac) |
| NOW-SF-011 | 2026-10-22 | FND-10 | GitHub deploy role is admin in effect; GitHub environment protections undocumented | Medium | Open | 2026-10-22 (Isaac) |
| NOW-SF-012 | 2026-10-22 | FND-09 | IAM-change alert misses MFA deactivation, tag changes and all Identity Center events | Medium | Fixed (af78cfe, merged in #49, 16a7442) | 2026-10-22 (Isaac) |
| NOW-SF-013 | 2026-10-22 | DB-51 | `verify_receipt` puts no ceiling on a receipt's expiry | Low | Fixed (af78cfe, merged in #49, 16a7442) | 2026-10-22 (Isaac) |
| NOW-SF-014 | 2026-10-22 | DB-51 | Key rotation comment gives the wrong order for ticket keys | Low | Fixed (af78cfe, merged in #49, 16a7442) | 2026-10-22 (Isaac) |
| NOW-SF-015 | 2026-10-22 | DB-51 | Signing keys copied by hand from Vault to Parameter Store | Low | Handed to FND-11 | 2026-10-22 (Isaac) |
| NOW-SF-016 | 2026-10-22 | DB-51 | Members whose posting is paused can still get upload tickets | Low | Fixed (af78cfe, merged in #49, 16a7442) | 2026-10-22 (Isaac) |
| NOW-SF-017 | 2026-10-22 | FND-09 | `cdk.json` alertEmails would commit founders' email addresses | Low | Open | 2026-10-22 (Isaac) |
| NOW-SF-018 | 2026-10-22 | FND-09 | Audit trail bucket and alert rules can be deleted without a trace | Low | Open | 2026-10-22 (Isaac) |
| NOW-SF-019 | 2026-10-22 | DB-21 | A pending place stays visible to a blocked "friend" if the block's follow clean-up is missed | Low | Fixed (94f8cb8, `feature/db-21-visibility`, not merged) | Draft |
| NOW-SF-020 | 2026-10-22 | DB-21 | No test for merged places or a guest on a rejected place | Low | Fixed (94f8cb8) | Draft |
| NOW-SF-021 | 2026-10-22 | DB-21 | `followers_of` tested only against a banned follower | Low | Fixed (94f8cb8) | Draft |
| NOW-SF-022 | 2026-10-22 | DB-21 | Comment says "false" is always safe; for `is_blocked` and `is_muted` it means allow | Low | Fixed (94f8cb8); part 2 test owed | Draft |
| NOW-SF-023 | 2026-10-22 | DB-21 | Forcing row level security would make `is_blocked` quietly answer "not blocked" | Low | Partly fixed (94f8cb8) | Draft |
| NOW-SF-024 | 2026-10-22 | DB-21 | Comment and contracts row drifted from §7.1 and left out two helpers | Low | Fixed (94f8cb8) | Draft |
| NOW-SF-025 | 2026-10-22 | DB-12 | Changing a username frees the old one at once; anyone can take it and inherit its trust | Medium | Handed to E18 (Tolu) | Draft |
| NOW-SF-026 | 2026-10-22 | DB-12 | No test that refused profile edits count toward the rate limit | Medium | Fixed (#52, 98b0a38) | Draft |
| NOW-SF-027 | 2026-10-22 | DB-12 | The 30-day username rule compared exact times, so the date shown could still refuse | Low | Fixed (#52, 98b0a38) | Draft |
| NOW-SF-028 | 2026-10-22 | DB-12 | Rate-limit comment said every attempt counts; malformed calls roll back | Low | Fixed (#52, 98b0a38) | Draft |
| NOW-SF-029 | 2026-10-22 | DB-12 | A reserved word added later blocks resending an unchanged display name | Low | Fixed (#52, 98b0a38) | Draft |
| NOW-SF-030 | 2026-10-22 | DB-12 | `get_settings` marked STABLE while `require_member` is VOLATILE | Low | Fixed (#52, 98b0a38) | Draft |
| NOW-SF-031 | 2026-10-22 | DB-47 | Migration numbered before migrations already on main; `db push` refuses it | Medium | Fixed (07c77f9, #48 not merged) | Draft |
| NOW-SF-032 | 2026-10-22 | DB-47 | Import's FOR UPDATE locks make members' posts, saves and ratings wait | Medium | Fixed (cc044da, #48 not merged) | Draft |
| NOW-SF-033 | 2026-10-22 | DB-47 | Import trusts the CSV's coordinates: places could be created outside Lagos | Medium | Fixed (cc044da, #48 not merged) | Draft |
| NOW-SF-034 | 2026-10-22 | DB-47 | No licence check on source datasets; OpenStreetMap data could enter the core database | Medium | Fixed (cc044da, #48 not merged) | Draft |
| NOW-SF-035 | 2026-10-22 | DB-47 | `same_place` reads the candidate without a lock; a concurrent merge can leave a dead link | Medium | Fixed (cc044da, #48 not merged) | Draft |
| NOW-SF-036 | 2026-10-22 | DB-47 | Script SSL check trusted PGHOST/PGSSLMODE and could echo a malformed connection string | Low | Fixed (cc044da, #48 not merged) | Draft |
| NOW-SF-037 | 2026-10-22 | DB-47 | Script builds the sources array by hand; None or a comma breaks it | Low | Fixed (cc044da, #48 not merged) | Draft |
| NOW-SF-038 | 2026-10-22 | DB-47 | `extract` downloads DuckDB's httpfs extension at run time, undocumented | Low | Fixed, documented (cc044da) | Draft |
| NOW-SF-039 | 2026-10-22 | DB-47 | `near_pending_place` reviews keep a member's pending place ID | Low | Handed to DB-60, DB-61 (contracts §2 note) | Draft |
| NOW-SF-040 | 2026-10-22 | DB-47 | An import running while the team answers reviews can hit a unique-key error and roll back | Low | Fixed, documented: one at a time (cc044da) | Draft |
| NOW-SF-041 | 2026-10-22 | DB-47 | Contract said `resolve_place_import_review` sets corrected_fields; it doesn't | Low | Fixed (cc044da, #48 not merged) | Draft |
| NOW-SF-042 | 2026-10-22 | DB-02 | Profile-member clean-up could skip deleting the login after a failed delete | Medium | Fixed (#54, 619c8df) | Draft |
| NOW-SF-043 | 2026-10-22 | DB-02 | A place delete in clean-up failed when a post survived an earlier failure | Medium | Fixed (#54, 619c8df) | Draft |
| NOW-SF-044 | 2026-10-22 | DB-31 | A list post whose list is deleted keeps no list; safe only if can_view treats it as author-only | Low | Handed to DB-21 part 2, DB-27 | Draft |
| NOW-SF-045 | 2026-10-22 | DB-31 | A removed or deleted post's other columns could still change | Low | Fixed (#54, 619c8df) | Draft |
| NOW-SF-046 | 2026-10-22 | DB-31 | Inbox rows weren't tied to the post's date and rank | Low | Fixed (#54, 619c8df) | Draft |
| NOW-SF-047 | 2026-10-22 | DB-31 | likes.created_at kept an exact time nothing needs | Low | Fixed (#54, 619c8df) | Draft |
| NOW-SF-048 | 2026-10-22 | DB-31 | photos.owner_id can change after a photo is attached | Low | Handed to DB-51 (Isaac) | Draft |
| NOW-SF-049 | 2026-10-22 | DB-31 | A deleted comment could come back | Low | Fixed (#54, 619c8df) | Draft |
| NOW-SF-050 | 2026-10-22 | DB-33 | A reused rating could stay pending, or stop counting while the member had a live post | Medium | Fixed (#55, c296437) | Draft |
| NOW-SF-051 | 2026-10-22 | DB-33 | Held ratings were never superseded, so a later release could make two current ratings | Medium | Fixed (#55, c296437) | Draft |
| NOW-SF-052 | 2026-10-22 | DB-33 | Merging places can collide two current ratings (unique index) | Medium | Handed to DB-48 | Draft |
| NOW-SF-053 | 2026-10-22 | DB-32 | A retry returned the raw status, revealing hidden or removed | Low | Fixed (#55, c296437) | Draft |
| NOW-SF-054 | 2026-10-22 | DB-33 | A staff-removed rating let the member re-rate at once | Low | Fixed (#55, c296437) | Draft |
| NOW-SF-055 | 2026-10-22 | DB-32 | Photo-list checks could raise a raw error on a non-list | Low | Fixed (#55, c296437) | Draft |
| NOW-SF-056 | 2026-10-22 | DB-32 | Malformed and not-found calls roll back their rate-limit count | Low | Open (same as create_profile; noted) | Draft |
| NOW-SF-057 | 2026-10-22 | DB-33 | ratings.created_at keeps an exact time for good | Low | Handed to DB-35 | Draft |

## Findings

### NOW-SF-001: Session key and ciphertext written in two steps
- **Found:** 2026-10-22, APP-04 security review by Junior (inline, Isaac's call), on `main` at 0dc3998.
- **Where:** `app/src/data/secure-session.ts`, `setItem`.
- **What was wrong:** every session write made a new AES key, then saved the key to secure storage and the ciphertext to AsyncStorage as two separate writes. auth-js 2.117 reads and refreshes the session without a lock, so a read could land between the two writes, or two writes could cross. The read then paired the new key with the old ciphertext, decryption failed, and the "tampered" path deleted the whole session.
- **Impact:** availability, not confidentiality. A member gets signed out at random, the full shared-phone wipe runs (cache and photos gone), and the screen can still show them signed in while calls go out as a guest. Nothing leaks.
- **Fix:** one key per session, made at the first write and deleted at sign-out. Later writes change only the ciphertext with a fresh random nonce, which is one atomic write. The key is read from secure storage each time (no in-memory copy that could go stale after a reinstall or keychain wipe); only a key being made is shared, so two first writes can't make two keys. Before a new key is made, ciphertext left by a cut-off sign-out is dropped. The "tampered" path deletes only if the ciphertext it read is still the stored one.
- **Why this fix:** the auth-js `lock` option is deprecated (it warns and goes away in v3), so the fix belongs in our storage, not in a lock. Reusing one AES-GCM key with random 96-bit nonces is safe up to about 2^32 writes, and a session is written roughly once an hour. Sign-out still deletes the key, so a left-behind copy stays unreadable.
- **Evidence:** a new test (overlapping reads and writes) failed on the old code with a `null` read and passes now. Further tests: a new session after sign-out gets a new key; leftover ciphertext from a cut-off sign-out doesn't cost the next session its key. `app/src/data` tests 14/14, ESLint, Prettier and `tsc` clean.
- **Status:** Fixed in Now df12767 on `feature/app-04-data-layer` (merged to `main` in #47, c6d71cd, 2026-10-22).

### NOW-SF-002: Friends-only photos kept on disk
- **Found:** 2026-10-22, APP-04 security review.
- **Where:** `expo-image` default caching (`cachePolicy` defaults to disk); affects every screen that shows photos.
- **What was wrong:** EC-100 says non-public posts and photos are held in memory only. `expo-image` writes every photo it shows to disk. The APP-04 wipe clears that cache at sign-out, but a lost phone that stays offline keeps every friends-only photo it has shown.
- **Fix:** photos from non-public posts use `cachePolicy="memory"`. Written into the APP-27 row of `docs/implementation/workstreams/app.md` (Now df12767). MAP-11 must follow it for "People I follow" pins with photos.
- **Why this fix:** no APP-04 code shows images yet, so the rule belongs where photos are built (APP-27). Memory-only keeps EC-100 true at the cost of re-downloading friends' photos, which is the cost the founders already accepted for non-public posts.
- **Status:** Handed to APP-27 and MAP-11. Junior checks it at their security review.

### NOW-SF-003: No foreground/background handling for token refresh
- **Found:** 2026-10-22, APP-04 security review.
- **Where:** `app/src/data/api.ts`, member client (`autoRefreshToken: true`).
- **What was wrong:** Supabase's React Native guide says to call `startAutoRefresh` when the app comes to the foreground and `stopAutoRefresh` when it leaves. Without that, refresh timers misbehave in the background.
- **Fix:** an `AppState` listener in APP-10 (sign-in).
- **Status:** Handed to APP-10.

### NOW-SF-004: Stored cache shown before the session is confirmed
- **Found:** 2026-10-22, APP-04 security review.
- **Where:** `app/src/data/query.tsx`, restore on start.
- **What was wrong:** architecture §7.2 says that when the server has ended the session, the app wipes before showing anything. On reopen, the member's stored cache is restored before any call has checked the session. The stored cache is public-only (EC-100), so the exposure is small.
- **Fix:** APP-10 confirms the session with the server before mounting the member's store.
- **Status:** Handed to APP-10.

### NOW-SF-005: Only PT401 counts as signed out
- **Found:** 2026-10-22, APP-04 security review.
- **Where:** `app/src/data/api.ts`, `isSignedOut`.
- **What was wrong:** PostgREST answers a rejected token with `PGRST301`/`PGRST303`, not PT401, so the wipe doesn't run from that path. The sign-in library's SIGNED_OUT event covers most of these cases.
- **Fix:** `isSignedOut` now treats PT401, PGRST301 (token can't be decoded) and PGRST303 (expired or invalid claims) as signed out, so any of them runs the sign-out and wipe. The query retry rule also stops retrying them, since a rejected token never gets better on retry.
- **Why this fix:** these three codes all mean "this token is no good", whichever layer said it. Other PGRST3xx codes are server misconfiguration (for example a missing JWT secret), not a member's ended session, so signing the member out on them would be wrong; they were left out on purpose.
- **Evidence:** the shared-phone wipe test now runs for each of the three codes; the two PostgREST cases failed on the old code and pass now. Data and session tests 23/23, ESLint and `tsc` clean.
- **Status:** Fixed in Now df12767 on `feature/app-04-data-layer` (merged to `main` in #47, c6d71cd, 2026-10-22).

### NOW-SF-006: A mutual block is lost, and one unblock lifts both
- **Found:** 2026-10-22, Junior's ambition pass and audit of the prototype schema (`prototypes/architecture-check/schema.sql`) before porting it to DB-20.
- **Where:** prototype `app.block_pairs`, key `(a_id, b_id)`, and its block function (`ON CONFLICT DO NOTHING`).
- **What was wrong:** if A blocks B and B then blocks A, B's block hits the existing rows and is silently dropped. When A later unblocks, both rows go, and B is unblocked without doing anything.
- **Impact:** safety. An abuser who blocks first, then unblocks after the victim blocks back, gets through the victim's block.
- **Fix:** the blocker is part of the key `(a_id, b_id, blocker_id)`, so each person's block is its own pair of rows; a self-referencing "mirror" key keeps every row paired (half a pair can't be committed, and deleting one row deletes its mirror). In `supabase/migrations/20261022110000_db_20_social_tables.sql`.
- **Why this fix:** it keeps the one-lookup check ("either blocked by the other") that the visibility rule needs for speed, and puts the invariant in the schema, so DB-23's functions can't get it wrong.
- **Evidence:** `supabase/tests/db_20_social_tables.sql` 17/17 on a local PGlite run; with the old key put back, tests 11 and 13 fail (the second block can't be stored; one unblock lifts both). Real CI not run yet.
- **Status:** Fixed in bbf3939 on `feature/db-51-photos` (merged to `main` in #49, 16a7442).

### NOW-SF-007: A photo receipt works more than once
- **Found:** 2026-10-22, same audit, prototype `private.verify_receipt`.
- **What was wrong:** the prototype checks the receipt's signature, owner and expiry but records nothing, so one receipt can be used in many posts until it expires. The contract (contracts.md §2) says a receipt is valid once.
- **Fix:** DB-51's `verify_receipt` claims the photo in the same step (`UPDATE ... WHERE status = 'ticketed' RETURNING`). The claim is part of `create_post`'s transaction, so a failed post leaves the receipt usable, and of two posts racing with one receipt the second waits on the row and then finds it taken. Every failure is the same "bad request".
- **Why this fix:** no extra table and no extra state. The `img` function can't write to the database, so the old `upload_tickets.used` flag could never have been set; that table was dropped (Isaac, 2026-10-22).
- **Evidence:** `supabase/tests/db_51_photos.sql` 39/39 on PGlite (pgcrypto shimmed with SQL HMAC; ticket and receipt test vectors computed in Node match); with the single-use condition removed, "a receipt works only once" fails. The two-connection race is reasoned from Postgres row locking, not tested: pgTAP runs on one connection.
- **Status:** Fixed in bbf3939 on `feature/db-51-photos` (merged to `main` in #49, 16a7442).

### NOW-SF-008: The waiting-photos cap can be overshot
- **Found:** 2026-10-22, DB-51 build (Junior's inline review).
- **What:** `request_photo_uploads` counts waiting photos and then issues tickets without a lock, so two calls at the same moment can both pass and leave up to 15 waiting instead of 10.
- **Why it is Low:** the hourly limit (20 tickets) still bounds it, and the files are small re-encoded WebP. A lock would cost a row lock on every request.
- **Status:** Accepted by Isaac, 2026-10-22 (locked with SF-007 to SF-017): the hourly limit bounds it.

### NOW-SF-009: Never-posted photos wait in S3
- **Found:** 2026-10-22, DB-51 build.
- **What:** a photo that is uploaded but never posted stays in S3 until the daily clean-up marks it `deleting` (after 24 hours) and BE-26 deletes the files. It is never served (signing needs a post the viewer can see), but it is still stored, which matters for illegal images.
- **Fix:** BE-20 adds an S3 lifecycle rule on `incoming/` as a backstop; BE-26 drains `deleting` rows.
- **Status:** Handed to BE-20, BE-26.

### NOW-SF-010 to NOW-SF-018: review of commit bbf3939
- **Found:** 2026-10-22, `now-security-reviewer` agent on `git diff b3cb719 bbf3939` (DB-51, DB-20, AWS CDK infra). No Critical or High. Tables, function grants, token signing and single-use receipts checked clean.
- **SF-010** `aws/infra/src/policies.ts:6-34`: a stolen admin session in a member account can mint a long-lived key (`iam:CreateUser`, `CreateAccessKey`), breaking T-30. Fix: deny `iam:CreateUser`, `iam:CreateAccessKey`, `iam:CreateLoginProfile` in `guardrailsPolicy`, with a test.
- **SF-011** `aws/infra/src/stacks.ts:181-187`: the deploy role can assume the CDK bootstrap roles, and a default bootstrap gives `cfn-exec-role` AdministratorAccess. Fix: bootstrap with a scoped `--cloudformation-execution-policies`; README must require `main`-only deployment branches, required reviewers and no self-review on `staging` and `production`.
- **SF-012** `aws/infra/src/stacks.ts:129-149`: alert matches name prefixes only, so `DeactivateMFADevice` is silent and `aws.sso*` events aren't watched. Fix: match `readOnly: false`; add a rule for `aws.sso` and `aws.sso-directory`.
- **SF-013** migration line 200: a buggy `img` function could sign a far-future receipt. Fix: refuse expiry beyond now + 1 hour + 60 s.
- **SF-014** migration lines 40-41, 120: tickets are signed with the newest key immediately. Ticket key: give it to the function first, then Vault. Receipt key: Vault first, then function. Fix the comment and the FND-11 runbook.
- **SF-015** migration lines 252-254: put a no-echo procedure (`aws ssm put-parameter --type SecureString` from stdin) in the FND-11 runbook.
- **SF-016** migration line 98: `request_photo_uploads` ignores `posting_paused_until`. Bounded by the hourly limit and the 24-hour expiry. Fix: reject paused members, or accept in writing.
- **SF-017** `aws/infra/cdk.json`: use a role mailbox or pass `-c alertEmails=...` from a GitHub environment variable.
- **SF-018** `aws/infra/src/stacks.ts:48-54, 106-151`: trail bucket has no versioning or deny-delete; alert rules and topic can be removed. Fix: versioning plus deny-delete bucket policy; SCP deny on `events:DeleteRule`, `events:RemoveTargets`, `sns:Unsubscribe` for alert resources, except the CloudFormation role.
- **Also raised, not findings yet:** a blocked person who deletes their account loses the block (cascade, DB-20 migration lines 36-37), so re-signing up with the same number clears it; now open question E17 in the Now repo (`docs/open-questions.md`, owner Isaac, blocks DB-23 and DB-65), added 2026-10-22. Missing DB-51 tests: deleted key, unknown key tag, banned or no-profile caller, racing receipts. BE-20 must refuse at the `p/` write before issuing a receipt, since the receipt carries no SHA-256.
- **Fixes (2026-10-22, af78cfe on `feature/db-51-photos`, merged to `main` in #49, 16a7442):** SF-010 `DenyLongLivedCredentials` statement plus test; SF-012 IAM rule matches `readOnly: false`, new `IdentityCenterChange` rule in both regions plus tests (infra tests 5/5, `tsc` clean); SF-013 receipts with expiry beyond now + 3,660 s refused; SF-014 rotation comment split by key type; SF-016 paused members get `{"status": "posting_paused"}` (contracts.md updated). New DB-51 tests: paused, banned, far-future receipt, unknown key tag, deleted key. `db_51_photos.sql` 44/44 on PGlite; with SF-013 and SF-016 reverted the new tests fail. Real CI not run.
- **Not read by the reviewer:** generated types, lockfile, `infra.test.ts` in full, following-and-friends, decisions 0002 and 0006, most of the threat model.

### NOW-SF-019 to NOW-SF-024: review of DB-21 part 1
> Draft, not confirmed
- **Found:** 2026-10-22, Junior's inline review and the `now-security-reviewer` agent, run independently on DB-21 part 1 (committed and pushed as 94f8cb8 on `feature/db-21-visibility`, not merged) (`supabase/migrations/20261022130000_db_21_relationship_helpers.sql`: `is_follower`, `is_friend`, `is_blocked`, `is_muted`, `followers_of`, `place_visible`). Nothing Critical, High or Medium from either. Grants, guest handling, block mirroring and SECURITY INVOKER were checked and found clean.
- **SF-019** (Junior): `place_visible` showed a pending place to the adder's friends without checking blocks, relying on DB-23 deleting follows when someone blocks. Fix: the friend branch also requires `NOT is_blocked(adder, viewer)`. Why: one extra index lookup, and a missed clean-up then can't show a blocked person a place that may be a home (NFR-SAFE-02). New test; with the check removed it fails.
- **SF-020** (agent L1): a mutant adding `merged` to the visible statuses passed every test. Fix: tests for a merged place and for a guest on a rejected place.
- **SF-021** (agent L2): a mutant changing the filter to `status <> 'banned'` passed, so followers who are deleting their accounts would get inbox rows. Fix: tests for a `pending_deletion` follower and for a waiting follow request.
- **SF-022** (agent L3): the header said false-not-null keeps callers safe. For `is_blocked` and `is_muted`, false means allow, so a `can_view` that checks blocks before sending guests to the public projection would let a null viewer through. Fix: comment and contracts.md now say so. Still owed: a part 2 `can_view` test with a null viewer on a blocked author's non-public post.
- **SF-023** (agent L4): the helpers read as the table owner, who skips row level security. If it were ever forced on these tables, every read would come back empty and `is_blocked` would say false with no error. Fix: a test that fails if `relforcerowsecurity` is set on `follows`, `block_pairs`, `mutes`, `places` or `members`. Not done: a test through a SECURITY DEFINER wrapper owned like the api functions. Unverified: whether Supabase's `postgres` role has BYPASSRLS.
- **SF-024** (agent L5): the comment said an inline copy of the place rule is checked against this function; §7.1 says every copy is checked against the independent model. The contracts row also left out `is_follower` and `place_visible`. Fix: comment reworded; both signatures added to contracts.md §2.
- **Also raised, for Isaac:** (Q1) a banned or deleting adder's pending place stays visible to their friends; §7.1 doesn't say otherwise, and Junior recommends leaving it because staff reject such places. Changing it means changing §7.1 and the property test's model too. (Q2) whether DB-34 leaves muted authors out when it writes inbox rows, or filters them at read time (the agent suggests read time); `followers_of` correctly ignores mutes.
- **Evidence:** 33/33 tests on the local PGlite stand-in (places shimmed, no PostGIS), plus db_03 8/8, db_20 17/17, db_51 44/44; 10 mutants each fail at least one test. Real CI not run.

### NOW-SF-025 to NOW-SF-030: review of DB-12 (profile editing)
> Draft, not confirmed
- **Found:** 2026-10-22, the `now-security-reviewer` agent on Sonnet (Tolu's request) on DB-12 (`api.update_profile`, `api.get_settings`). Nothing Critical or High. Authorization (no member ID argument; everything keyed on `require_member`), grants, data exposure (never `legal_hold`, dates only), concurrency (`FOR UPDATE` on the member's row, unique index as backstop) and logging (one boolean) checked and clean.
- **SF-025** (M1): the old username is free the moment a member renames, so someone can take a known handle and inherit links and mentions; the owner can't take it back for 30 days. Not fixed in DB-12, since the hold length is a product call: open question E18 in the repo (Claude proposes a 90-day hold for the former owner and a staff-visible username history).
- **SF-026** (M2): no test proved a refused edit uses up a rate-limit slot. Fix: a fresh bucket, limit 2, one refused and one accepted edit, the third gets PT429.
- **SF-027** (L1): a member told "allowed on D" was refused on the morning of D. Fix: the rule compares Lagos dates; a test sets the allowed time to the end of today.
- **SF-028 to SF-030** (L2 to L4): comment reworded; an unchanged display name is not re-checked against reserved words; `get_settings` made VOLATILE.
- **Evidence:** 44 pgTAP tests pass in CI with the whole suite (run 39834498789, #52).

### NOW-SF-031 to NOW-SF-041: second review of DB-47 (Overture import)
> Draft, not confirmed
- **Found:** 2026-10-22, the `now-security-reviewer` agent on Sonnet, a fresh pass on #48's final code after an earlier pass whose fixes are in f4fdbfb. Nothing Critical or High. Grants (four tables and three functions closed to API roles, SECURITY INVOKER), re-import safety, pending places never changed, and hostile staged data checked and clean.
- **SF-031:** renumbered to `20261022150000`. **SF-032:** `FOR NO KEY UPDATE` at three places, and the script sets `lock_timeout` 5 s and `statement_timeout` 10 min. **SF-033:** the database skips rows outside the Lagos State box (`skipped_out_of_area`). **SF-034:** `app.overture_licensed_sources`, the seven sources `data/NOTICE.md` checked (Foursquare Apache-2.0; Overture, meta, Microsoft, AllThePlaces, DAC, PinMeTo CDLA-Permissive-2.0), counted as `skipped_licence`. Why an allow-list and not an OpenStreetMap block: an unchecked new source stays out until someone checks its licence. Sources were read from the committed research extract, not guessed. **SF-035:** `FOR SHARE` on the candidate.
- **SF-036 to SF-041:** the script trusts only the connection string's own host and prints a fixed message for a bad string; source names are filtered; httpfs and one-import-at-a-time are documented; contracts §2 says import reviews are staff-only and that `corrected_fields` is set by DB-67/DB-68.
- **Evidence:** 55 pgTAP tests in CI on `219bea2`, all green (run 39836187056).

### NOW-SF-042 to NOW-SF-049: review of DB-31 (post tables) and DB-02 factories
> Draft, not confirmed
- **Found:** 2026-10-22, the `now-security-reviewer` agent on Sonnet (Tolu's request), on #54 before merge. Nothing Critical or High. Grants and row rules, random IDs, RV3-02's checks and the photo-owner guard checked and clean.
- **SF-042, SF-043:** the factory clean-up now deletes posts and photos before the profile, always removes the login, and clears posts by place before a place.
- **SF-044:** a list post whose list is deleted keeps `audience = 'list'` with no list; DB-21 part 2's `can_view` must treat a list or picked post with no audience rows as author-only (with a test), and DB-27 must cancel a waiting widening when its list goes.
- **SF-045 to SF-047, SF-049:** a removed or deleted post freezes except the time cut and a place merge; inbox rows reference the post's author, date and rank; likes keep no time; a deleted comment stays deleted.
- **SF-048:** suggest a guard on Isaac's `photos` so the owner never changes once attached.
- **Evidence:** 55 pgTAP tests in CI with the whole suite (#54).

### NOW-SF-050 to NOW-SF-057: review of DB-32 (create_post) and DB-33 (ratings)
> Draft, not confirmed
- **Found:** 2026-10-22, the `now-security-reviewer` agent on Sonnet, on #55 before merge. Nothing Critical or High. Author from the token, the acting-member guard, receipts bound and single-use, places and lists not leaked, no times in answers, all checked and clean.
- **SF-050:** publishing activates the author's pending rating of the place whichever of their posts made it, and a rating counts while the member has any live post there. Why: "a verdict on every post" with one rating per place; the first post may be held or deleted.
- **SF-051:** a new rating after 30 days supersedes a held one too. **SF-054:** a staff-removed rating still blocks a new one for its 30 days.
- **SF-052:** DB-48 must supersede one of two ratings before moving it, keeping the earlier date. **SF-057:** DB-35's time cut covers ratings and comments.
- **SF-053:** a retry answers only held or scheduled. **SF-055:** the photo-list checks run only on a list (bracketed so PL/pgSQL doesn't end the IF at the CASE's THEN; CI caught that).
- **SF-056:** not changed: failing calls roll back their count, as in `create_profile`; receipts are signed, so nothing leaks.
- **Evidence:** 37 + 53 pgTAP tests in CI with the whole suite (#55).
