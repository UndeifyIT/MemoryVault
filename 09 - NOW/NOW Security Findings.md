---
status: active
project: now
type: reference
author: junior
created: 2026-10-22
updated: 2026-10-22
---
# NOW Security Findings

> Draft, not confirmed: NOW-SF-001 to NOW-SF-005 wait for Isaac's or Tolu's "lock it". When every finding is locked, this line goes; a new draft finding brings it back.

Every security gap found in a NOW security review, with the fix and why that fix was chosen, so anyone can see later why a piece of code is the way it is. Started on Isaac's request, 2026-10-22. Cross-project risks stay in [[Security Register]]; this note holds NOW's findings in detail.

**How to read it.** IDs (`NOW-SF-NNN`) are permanent and never reused. Severity is Junior's judgment: Critical, High, Medium, Low. Status is one of: **Open** (no fix yet), **Fixed (uncommitted)**, **Fixed** (with the commit), **Handed to** a task, or **Accepted** (a founder chose to live with it; Isaac only, per [[Vault Rules]]). A finding stays a **draft** until Isaac or Tolu says "lock it".

## Index

| ID | Date | Task | Finding | Severity | Status | Draft? |
|---|---|---|---|---|---|---|
| NOW-SF-001 | 2026-10-22 | APP-04 | Session key and ciphertext written in two steps; a read in between signs the member out | Medium | Fixed (uncommitted) | Draft |
| NOW-SF-002 | 2026-10-22 | APP-04 | The image library keeps friends-only photos on disk until sign-out | Medium | Handed to APP-27, MAP-11 | Draft |
| NOW-SF-003 | 2026-10-22 | APP-04 | No foreground/background handling for token refresh | Low | Handed to APP-10 | Draft |
| NOW-SF-004 | 2026-10-22 | APP-04 | On reopen, the stored public cache shows before the server confirms the session | Low | Handed to APP-10 | Draft |
| NOW-SF-005 | 2026-10-22 | APP-04 | Only PT401 counts as signed out; PostgREST token errors don't trigger the wipe | Low | Open | Draft |

## Findings

### NOW-SF-001: Session key and ciphertext written in two steps
- **Found:** 2026-10-22, APP-04 security review by Junior (inline, Isaac's call), on `main` at 0dc3998.
- **Where:** `app/src/data/secure-session.ts`, `setItem`.
- **What was wrong:** every session write made a new AES key, then saved the key to secure storage and the ciphertext to AsyncStorage as two separate writes. auth-js 2.117 reads and refreshes the session without a lock, so a read could land between the two writes, or two writes could cross. The read then paired the new key with the old ciphertext, decryption failed, and the "tampered" path deleted the whole session.
- **Impact:** availability, not confidentiality. A member gets signed out at random, the full shared-phone wipe runs (cache and photos gone), and the screen can still show them signed in while calls go out as a guest. Nothing leaks.
- **Fix:** one key per session, made at the first write and deleted at sign-out. Later writes change only the ciphertext with a fresh random nonce, which is one atomic write. The key is read from secure storage each time (no in-memory copy that could go stale after a reinstall or keychain wipe); only a key being made is shared, so two first writes can't make two keys. Before a new key is made, ciphertext left by a cut-off sign-out is dropped. The "tampered" path deletes only if the ciphertext it read is still the stored one.
- **Why this fix:** the auth-js `lock` option is deprecated (it warns and goes away in v3), so the fix belongs in our storage, not in a lock. Reusing one AES-GCM key with random 96-bit nonces is safe up to about 2^32 writes, and a session is written roughly once an hour. Sign-out still deletes the key, so a left-behind copy stays unreadable.
- **Evidence:** a new test (overlapping reads and writes) failed on the old code with a `null` read and passes now. Further tests: a new session after sign-out gets a new key; leftover ciphertext from a cut-off sign-out doesn't cost the next session its key. `app/src/data` tests 14/14, ESLint, Prettier and `tsc` clean.
- **Status:** Fixed (uncommitted, in Isaac's working tree on `feature/app-04-data-layer`).

### NOW-SF-002: Friends-only photos kept on disk
- **Found:** 2026-10-22, APP-04 security review.
- **Where:** `expo-image` default caching (`cachePolicy` defaults to disk); affects every screen that shows photos.
- **What was wrong:** EC-100 says non-public posts and photos are held in memory only. `expo-image` writes every photo it shows to disk. The APP-04 wipe clears that cache at sign-out, but a lost phone that stays offline keeps every friends-only photo it has shown.
- **Fix:** photos from non-public posts use `cachePolicy="memory"`. Written into the APP-27 row of `docs/implementation/workstreams/app.md` (uncommitted). MAP-11 must follow it for "People I follow" pins with photos.
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
- **Fix:** treat those codes as signed out too. Not yet applied.
- **Status:** Open.
