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
| NOW-SF-006 | 2026-10-22 | DB-20 | Prototype `block_pairs` key loses a second, mutual block; one unblock lifts both | High | Fixed (uncommitted) | Draft |
| NOW-SF-007 | 2026-10-22 | DB-51 | Prototype `verify_receipt` never marks a receipt used, so one photo receipt works many times | Medium | Fixed (uncommitted) | Draft |
| NOW-SF-008 | 2026-10-22 | DB-51 | Two ticket requests at once can both pass the 10-waiting-photos cap | Low | Open (proposed accept) | Draft |
| NOW-SF-009 | 2026-10-22 | DB-51 | Uploaded but never-posted photos stay in S3 until the daily clean-up and the BE-26 drain | Low | Handed to BE-20, BE-26 | Draft |

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
- **Status:** Fixed (uncommitted), on Isaac's clone.

### NOW-SF-007: A photo receipt works more than once
- **Found:** 2026-10-22, same audit, prototype `private.verify_receipt`.
- **What was wrong:** the prototype checks the receipt's signature, owner and expiry but records nothing, so one receipt can be used in many posts until it expires. The contract (contracts.md §2) says a receipt is valid once.
- **Fix:** DB-51's `verify_receipt` claims the photo in the same step (`UPDATE ... WHERE status = 'ticketed' RETURNING`). The claim is part of `create_post`'s transaction, so a failed post leaves the receipt usable, and of two posts racing with one receipt the second waits on the row and then finds it taken. Every failure is the same "bad request".
- **Why this fix:** no extra table and no extra state. The `img` function can't write to the database, so the old `upload_tickets.used` flag could never have been set; that table was dropped (Isaac, 2026-10-22).
- **Evidence:** `supabase/tests/db_51_photos.sql` 39/39 on PGlite (pgcrypto shimmed with SQL HMAC; ticket and receipt test vectors computed in Node match); with the single-use condition removed, "a receipt works only once" fails. The two-connection race is reasoned from Postgres row locking, not tested: pgTAP runs on one connection.
- **Status:** Fixed (uncommitted), on Isaac's clone.

### NOW-SF-008: The waiting-photos cap can be overshot
- **Found:** 2026-10-22, DB-51 build (Junior's inline review).
- **What:** `request_photo_uploads` counts waiting photos and then issues tickets without a lock, so two calls at the same moment can both pass and leave up to 15 waiting instead of 10.
- **Why it is Low:** the hourly limit (20 tickets) still bounds it, and the files are small re-encoded WebP. A lock would cost a row lock on every request.
- **Status:** Open; proposed to accept (Isaac decides).

### NOW-SF-009: Never-posted photos wait in S3
- **Found:** 2026-10-22, DB-51 build.
- **What:** a photo that is uploaded but never posted stays in S3 until the daily clean-up marks it `deleting` (after 24 hours) and BE-26 deletes the files. It is never served (signing needs a post the viewer can see), but it is still stored, which matters for illegal images.
- **Fix:** BE-20 adds an S3 lifecycle rule on `incoming/` as a backstop; BE-26 drains `deleting` rows.
- **Status:** Handed to BE-20, BE-26.
