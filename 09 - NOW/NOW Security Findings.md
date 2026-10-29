---
status: active
project: now
type: reference
author: junior
created: 2026-10-22
updated: 2026-10-30
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
| NOW-SF-022 | 2026-10-22 | DB-21 | Comment says "false" is always safe; for `is_blocked` and `is_muted` it means allow | Low | Fixed (94f8cb8); part 2 test written ("a guest sees public posts only", every author has a block) | Draft |
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
| NOW-SF-044 | 2026-10-22 | DB-31 | A list post whose list is deleted keeps no list; safe only if can_view treats it as author-only | Low | Handed to DB-27; DB-21 part 2 side done (deleting a list deletes its snapshot rows, tested) | Draft |
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
| NOW-SF-058 | 2026-10-22 | E19 | The picks cascade test passed without testing anything | Medium | Fixed (#56, 6e5c0e8) | Draft |
| NOW-SF-059 | 2026-10-22 | E19 | set_post_picks didn't check the post is a picked post | Medium | Fixed (#56, 6e5c0e8) | Draft |
| NOW-SF-060 | 2026-10-22 | E19 | Readers and writers of post_picks need rules (author check, re-trim, never a grant) | Low | Handed to DB-26, DB-27, DB-21 part 2 (contracts §2) | Draft |
| NOW-SF-061 | 2026-10-22 | E19 | A pick can go stale between posting and publish (no follow lock) | Low | Handed to DB-26 (re-trim at publish) | Draft |
| NOW-SF-062 | 2026-10-22 | DB-32 | A dialled delay under an hour lets a watcher guess when someone was there, as "Post now" does | Medium | Accepted by Tolu as the member's choice; app warning (APP-33) | Draft |
| NOW-SF-063 | 2026-10-22 | DB-32 | Minutes were accepted without a custom timer or with "Post now" | Low | Fixed (#57, a1efefe) | Draft |
| NOW-SF-064 | 2026-10-23 | DB-21 | A snapshot row left after an unfollow reopens old list and picked posts once the two follow each other again | Medium | Fixed (de78a98, `feature/db-21-visibility-rule`, not merged) | 2026-10-29 (Isaac) |
| NOW-SF-065 | 2026-10-23 | DB-21 | The snapshot check doesn't require, or lock, the member's place on the source list, so a removal racing the publish keeps access | Medium | Fixed (de78a98, `feature/db-21-visibility-rule`, not merged) | 2026-10-29 (Isaac) |
| NOW-SF-066 | 2026-10-23 | DB-21 | Snapshot rows from a post's earlier list or picks keep granting after its audience changes | Low | Fixed (de78a98, `feature/db-21-visibility-rule`, not merged) | 2026-10-29 (Isaac) |
| NOW-SF-067 | 2026-10-23 | DB-34 | The publish job locked its whole batch of posts until the run ended | Medium | Fixed (#58, 0b848bc) | Draft |
| NOW-SF-068 | 2026-10-23 | DB-34 | A list or picked post goes live with an empty snapshot until DB-26 | Medium | Handed to DB-21 part 2 (author-only test) | Draft |
| NOW-SF-069 | 2026-10-23 | DB-34 | Inbox rows are candidates; a public post at an unchecked place reached non-friends | Medium | Partly fixed (#58); read re-check handed to DB-41 | Draft |
| NOW-SF-070 | 2026-10-23 | DB-34 | held_reason wasn't tied to the held status | Low | Fixed (#58, 0b848bc) | Draft |
| NOW-SF-071 | 2026-10-23 | DB-34 | A waiting post could be set straight to hidden by hand | Low | Fixed (#58, 0b848bc) | Draft |
| NOW-SF-072 | 2026-10-23 | DB-34 | A banned author was sent a "post held" notice | Low | Fixed (#58, 0b848bc) | Draft |
| NOW-SF-073 | 2026-10-23 | DB-34 | A transient error holds a post as publish_failed until staff clear it | Low | Open (by design; noted) | Draft |
| NOW-SF-074 | 2026-10-23 | DB-34 | Supabase Cron's run log grows without limit | Low | Fixed (#58: prune_cron_runs) | Draft |
| NOW-SF-075 | 2026-10-23 | DB-31 | A member can't delete a list once any post shared with it was deleted or removed: `posts_guard` refuses the cascade's `list_id` change | Medium | Fixed (de78a98, `feature/db-21-visibility-rule`, not merged) | 2026-10-29 (Isaac) |
| NOW-SF-076 | 2026-10-23 | DB-07 | The staff check trusted the token's multi-factor claims, so a leaked service key could swap a staff login's authenticator and get full staff power, founder powers included | High | Fixed (#73, b2164d7) | 2026-10-29 (Isaac) |
| NOW-SF-077 | 2026-10-23 | DB-07 | Removing staff left the login and its authenticators, so an authenticator a thief added survived a later re-add | Medium | Fixed (#73, b2164d7) | 2026-10-29 (Isaac) |
| NOW-SF-078 | 2026-10-23 | DB-07 | Free-text audit reasons could hold phone numbers or emails, kept for good | Medium | Fixed (#73, b2164d7) | 2026-10-29 (Isaac) |
| NOW-SF-079 | 2026-10-23 | DB-07 | The member-or-staff lock doesn't hold under repeatable read | Low | Fixed (#73, b2164d7) | 2026-10-29 (Isaac) |
| NOW-SF-080 | 2026-10-23 | DB-07 | The SMS-factor test used a method name Supabase never issues | Low | Fixed (#73, b2164d7; moot, the token's amr is no longer read) | 2026-10-29 (Isaac) |
| NOW-SF-081 | 2026-10-23 | DB-03 | The function-body guards were satisfied by a commented-out call | Low | Fixed (#73, b2164d7) | 2026-10-29 (Isaac) |
| NOW-SF-082 | 2026-10-23 | DB-07 | Staff rows could be edited in place, unlogged, and direct changes aren't attributed | Low | Fixed (#73, b2164d7: edits blocked); attribution handed to DB-08 (pgaudit) | 2026-10-29 (Isaac) |
| NOW-SF-083 | 2026-10-23 | DB-07 | A login with a phone number could be made staff | Low | Fixed (#73, b2164d7) | 2026-10-29 (Isaac) |
| NOW-SF-084 | 2026-10-23 | DB-07 | No tests for schema and sequence access; the 100-target cap will split bulk staff actions | Low | Fixed (#73, b2164d7: tests); cap handed to DB-61 | 2026-10-29 (Isaac) |
| NOW-SF-085 | 2026-10-23 | DB-07 | A staff login's first sign-in step can only come from the service-key code path today | Medium | Handed to open question E20 (Isaac) | 2026-10-29 (Isaac) |
| NOW-SF-086 | 2026-10-23 | DB-07 | The audit log had no purge, so the data map's 12 months could never be kept | Low | Fixed (#73, b2164d7) | 2026-10-29 (Isaac) |
| NOW-SF-094 | 2026-10-23 | DB-07 | A staff login deleted through the Auth admin API leaves no audit row, only a revocation entry purged after 40 days | Low | Open, fix proposed | 2026-10-29 (Isaac) |
| NOW-SF-095 | 2026-10-23 | DB-07 | The 12-month audit purge has no legal-hold exemption, and 12 months is still a lawyer proposal | Low | Handed to legal item 36 (before 2027-10) | 2026-10-29 (Isaac) |
| NOW-SF-096 | 2026-10-23 | DB-03 | The function-body guards can still be met by a string literal | Low | Open, note proposed | 2026-10-29 (Isaac) |
| NOW-SF-097 | 2026-10-23 | DB-07 | Phone numbers split by `_`, `*`, letters or non-ASCII digits pass the reason check | Low | Accepted (Isaac, 2026-10-29) | 2026-10-29 (Isaac) |
| NOW-SF-098 | 2026-10-23 | DB-07 | If the old migration version was ever pushed to a shared database, DB-32's same-numbered migration is skipped there | Low | Open: check staging | 2026-10-29 (Isaac) |
| NOW-SF-099 | 2026-10-23 | DB-52 | A tie, or a margin set to 0, called one tag the clear leader | Medium | Fixed (#60, 73b5052) | Draft |
| NOW-SF-100 | 2026-10-23 | DB-52 | The refresh scanned every post twice per rating | Medium | Fixed (#60, 73b5052) | Draft |
| NOW-SF-101 | 2026-10-23 | DB-52 | Malformed or unknown tag pairs in the settings made odd Mixed entries | Low | Fixed (#60, 73b5052) | Draft |
| NOW-SF-102 | 2026-10-23 | DB-52 | Tags need 3 people, stricter than FR-PLC-14's 3 posts | Low | Open (Tolu to confirm) | Draft |
| NOW-SF-103 | 2026-10-23 | DB-09 | The seed's guard passed on an empty staging or production database | Medium | Partly fixed (#61, df43003); hand-running against an empty remote accepted | Draft |
| NOW-SF-104 | 2026-10-23 | DB-09 | The seed's phone-number comment overstated why the numbers are safe | Low | Fixed (#61, df43003) | Draft |
| NOW-SF-105 | 2026-10-23 | DB-09 | Seed ratings depended on row order; direct status changes looked like the app's path | Low | Fixed (#61, df43003) | Draft |
| NOW-SF-106 | 2026-10-23 | DB-57 | set_app_config could empty the ranking settings or a budget, freezing totals or lifting a cap | Medium | Fixed (#62, 1823c6c) | Draft |
| NOW-SF-107 | 2026-10-23 | DB-57 | set_rating_status and take_rating took their locks in opposite orders (deadlock) | Medium | Fixed (#62, 1823c6c) | Draft |
| NOW-SF-108 | 2026-10-23 | DB-57 | The keep test passed in bulk mode, so it never exercised the go-live guard | Medium | Fixed (#62, 1823c6c) | Draft |
| NOW-SF-109 | 2026-10-23 | DB-57 | Keep and unban aren't logged, so a restore's replay undoes them | Low | Accepted (restore procedure: staff re-apply) | Draft |
| NOW-SF-110 | 2026-10-23 | DB-57 | Keep could restore a banned author's post; a rating restriction waits for the hourly refresh | Low | Fixed keep (#62); refresh delay accepted | Draft |
| NOW-SF-111 | 2026-10-23 | DB-15 | The clean-up could delete a returning sign-up's login mid-flow; one failing step undid the rest | Medium | Fixed (#63, c6b3983) | Draft |
| NOW-SF-112 | 2026-10-23 | DB-15 | Staff logins are safe only by convention (no phone) until DB-07's staff table exists | Medium | Fixed 2026-10-29 (#73): `20261029100000` adds the `app.staff` check and two DB-15 test cases; CI green | Draft |
| NOW-SF-113 | 2026-10-23 | DB-15 | Phone-less logins (future sign-in methods) aren't cleaned; other clean-up steps belong to other tasks | Low | Open (noted in DB-15 row) | Draft |
| NOW-SF-114 | 2026-10-23 | DB-40 | A "Did you go?" push that never arrives lost the question | Medium | Fixed (#64, 33aa527) | Draft |
| NOW-SF-115 | 2026-10-23 | DB-40 | A private "Did you go?" rating could cancel a member's public post rating | Medium | Fixed (#64, 33aa527) | Draft |
| NOW-SF-116 | 2026-10-23 | DB-40 | The saved list gave public IDs but the other calls take place IDs | Medium | Fixed (#64, 33aa527) | Draft |
| NOW-SF-117 | 2026-10-23 | DB-40 | No cap on saves; a flaky ordering test; merges must merge saves too | Low | Fixed (#64); merge note handed to DB-48 | Draft |
| NOW-SF-118 | 2026-10-23 | DB-44 | Founder safety alerts had no overall cap: a wave of reports could flood both founders | Medium | Fixed (#65, 96cb3bf) | Draft |
| NOW-SF-119 | 2026-10-23 | DB-44 | Registering a phone at the same moment as another member could answer "registered" with nothing stored | Medium | Fixed (#65) | Draft |
| NOW-SF-120 | 2026-10-23 | DB-44 | Push tokens outlive "log out of all devices" and bans; removing a phone was rate-limited | Low | Rate limit fixed (#65); token removal handed to DB-13 | Draft |
| NOW-SF-121 | 2026-10-23 | DB-44 | A queued push ignored a switch turned off while it waited; follower notifications outlived the follow | Low | Fixed (#65) | Draft |
| NOW-SF-122 | 2026-10-23 | DB-44 | Unconfirmed pushes come back (possible duplicates); first page marks hidden rows seen | Low | Accepted; idempotent sends handed to BE-07 | Draft |
| NOW-SF-123 | 2026-10-23 | DB-36 | The 30-day erasure of rejected places could fail silently | Medium | Fixed (#66, 4258856): `rejected_places_overdue` in health facts | Draft |
| NOW-SF-124 | 2026-10-23 | DB-36 | The server's same-place check could be skipped with six or more similar places | Medium | Fixed (#66) | Draft |
| NOW-SF-125 | 2026-10-23 | DB-36 | Nothing slowed a member whose pins keep getting rejected; no view of the pending backlog | Medium | Fixed (#66): 3 rejections in 30 days stop adds (proposed); pending counts in health facts | Draft |
| NOW-SF-126 | 2026-10-23 | DB-36 | A pending place keeps its adder and creation time until the team acts | Medium | Open: auto-reject after 30 to 60 days proposed for the founders (DB-68 or clean-up) | Draft |
| NOW-SF-127 | 2026-10-23 | DB-36 | A same-place answer used up an add; long names processed before the length check | Low | Fixed (#66) | Draft |
| NOW-SF-128 | 2026-10-23 | DB-46 | Guest app opens and share-page opens always failed: `check_rate` refused their keys | High | Fixed (#67, a842da3) | Draft |
| NOW-SF-129 | 2026-10-23 | DB-46 | A guest could write up to 400,000 event rows an hour, and one abuser could use up every guest's limit | High | Fixed (#67): one guest app open a call, lower ceilings; per-visitor limits stay with AWS WAF | Draft |
| NOW-SF-130 | 2026-10-23 | DB-46 | Phone events took any properties (numbers could carry coordinates) and a malformed one failed the batch | Medium | Fixed (#67): allowlist per event, platform from the server only | Draft |
| NOW-SF-131 | 2026-10-23 | DB-46 | Turning exact times off kept old times; nothing runs the beta deletion; cascades logged as members' acts | Medium | Fixed (#67) except the beta-end job, handed to the beta-end clean-up | Draft |
| NOW-SF-132 | 2026-10-23 | DB-46 | Small numbers in kept weekly reports; events stay pseudonymous after account deletion | Low | Accepted (founders-only; recorded in the data map) | Draft |
| NOW-SF-133 | 2026-10-23 | DB-48 | A save, "Been here" or rating written while a merge ran landed on the merged place and was lost | High | Fixed (#68, db80682): `place_not_merged` trigger | Draft |
| NOW-SF-134 | 2026-10-23 | DB-48 | The merge could deadlock with `take_rating` | High | Fixed (#68): rating locks first, sorted | Draft |
| NOW-SF-135 | 2026-10-23 | DB-48 | A newer pending or "Did you go?" rating could replace one that counts publicly | Medium | Fixed (#68) | Draft |
| NOW-SF-136 | 2026-10-23 | DB-48 | Undo could fail, revive a place whose survivor moved on, or bring back what members removed; member IDs kept forever in merge records | Medium | Fixed (#68): 90-day undo window, purge in the clean-up (proposed); DB-14 scrubs deleted members | Draft |
| NOW-SF-137 | 2026-10-23 | DB-48 | Totals, pins and inbox rows not rebuilt by a merge; small edge cases | Medium | Survivor gets a totals row; readers show live and closed places only and re-check inbox rows (DB-38, DB-41, pins) | Draft |
| NOW-SF-138 | 2026-10-23 | DB-13 | Recovery-email requests could flood any inbox through many accounts | Medium | Fixed (#69, 384de6a): 3 a day per address | Draft |
| NOW-SF-139 | 2026-10-23 | DB-13 | `change_phone` trusts its caller fully and left the phone identity stale | Medium | Fixed (#69): identity updated, 3 a day; BE-03 must take the member from the checked code (test) | Draft |
| NOW-SF-140 | 2026-10-23 | DB-13 | Confirming a link shared the add limit | Medium | Fixed (#69) | Draft |
| NOW-SF-141 | 2026-10-23 | DB-13 | A stolen session can replace the recovery email with no fresh code | Medium | Fixed (#70): a replacement, or a first address from a phone first used within a day, waits 24 hours unless a fresh code confirms it; cancelled by the member or by logging out everywhere (decided by Tolu) | Draft |
| NOW-SF-142 | 2026-10-23 | DB-13 | Logout needed a registered device; a bad address could block the email queue; two races | Low | Fixed (#69) | Draft |
| NOW-SF-143 | 2026-10-23 | DB-59 | The dormancy gate only works if check-code calls it before any token exchange, fails closed and shows one neutral screen | Medium | Rules in contracts §2 for BE-03, with tests there | Draft |
| NOW-SF-144 | 2026-10-23 | DB-59 | The email check wasn't bound to the asking phone; a number's new holder could use up the owner's daily codes | Medium | Fixed (#71): bound to the install; limits per phone and per account | Draft |
| NOW-SF-145 | 2026-10-23 | DB-59 | Session refresh time, old known phones, code lifetime, contract kinds | Low | Fixed (#71): refreshed_at counted, known phones expire after a year, 10-minute codes | Draft |
| NOW-SF-146 | 2026-10-23 | DB-58 | The quiet-place hold could publish once when a place dropped below 10, and kept removed content in a verdict up to a day | Medium | Fixed (#72): held only while nothing went down; quiet while either count is under 10 | Draft |
| NOW-SF-147 | 2026-10-23 | DB-58 | The quiet threshold could be set below 10 | Low | Fixed (#72): clamped to 10-1000 | Draft |
| NOW-SF-148 | 2026-10-29 | APP-06 | A queued batch could be sent under a different session than its owner's for a moment (sign-up, server sign-out) | Low | Fixed (#80): the phone's session is checked before each batch; a mismatch drops the owner's events | Draft |
| NOW-SF-149 | 2026-10-29 | APP-06 | Guest app opens were sent at every foreground, using up the one shared guest limit | Low | Fixed (#80): only the owner's first app_opened of the Lagos day is queued | Draft |
| NOW-SF-150 | 2026-10-29 | APP-06 | No test proved DataProvider drops the last member's events | Low | Fixed (#80): a test in query.test.tsx, checked by a mutant | Draft |
| NOW-SF-151 | 2026-10-29 | DB-62 | A member can learn the risky-word list by posting and seeing "being checked"; spelling tricks pass | Low | Accepted (Isaac, 2026-10-29): post limit slows probing, reports are the backstop | 2026-10-29 (Isaac) |
| NOW-SF-152 | 2026-10-29 | DB-62 | The list's trigger writes `risky_word_list_version` in Tolu's `app_config` directly | Info | Tolu to confirm (DB-05 reserved the key for DB-62) | 2026-10-29 (Isaac) |
| NOW-SF-153 | 2026-10-29 | DB-62 | `check_risky_text` fails if called as an API role; edits and comments must call it too | Low | Documented in contracts §2 (c69055e, `feature/db-62-risky-words`, not merged) | 2026-10-29 (Isaac) |
| NOW-SF-154 | 2026-10-29 | DB-41 | The Following feed's direct query ran on every page once an inbox was full, checking every followed account's whole history | Medium | Fixed (#92): inbox first on a matching index; per-account newest 21 only when the inbox runs out | Draft |
| NOW-SF-155 | 2026-10-29 | DB-41 | Near you cast the place column, so the places index was unused, and sorted every public post in the radius; no member rate limit | Medium | Fixed (#92): bounding-box cut on places_geom_idx, 30-day window (proposed), `feeds` limit 600 an hour (proposed); guests limited at the edge | Draft |
| NOW-SF-156 | 2026-10-29 | DB-41 | A verdict held for integrity review showed on a post | Low | Fixed (#92): only pending, active or superseded verdicts show. Open: a second post at the same place within 30 days shows no verdict (take_rating reuses the first) | Draft |
| NOW-SF-157 | 2026-10-29 | DB-41 | The photos list held one null per photo, revealing the count before DB-50 | Low | Fixed (#92): missing links left out | Draft |
| NOW-SF-158 | 2026-10-29 | DB-41 | The daily inbox trim ranked the whole inbox table | Low | Fixed (#92): only inboxes over 300 | Draft |
| NOW-SF-159 | 2026-10-29 | DB-41 | After an unfollow dropped an inbox below 300, older posts vanished | Low | Fixed (#92) by the new fallback; a new follow's unseeded posts newer than the inbox's end still show only on the profile | Draft |
| NOW-SF-160 | 2026-10-29 | DB-41 | Test gaps: fallback negative case, private account, unchecked place, stale hidden post | Low | Fixed (#92): cases added | Draft |
| NOW-SF-161 | 2026-10-29 | DB-41 | If slow-query logging is on in production, Near-you coordinates could land in Postgres logs | Low | Open: check Supabase log settings before launch (Tolu, Isaac) | Draft |
| NOW-SF-162 | 2026-10-29 | DB-60 | Two safety reports at the same moment, on a post and on its photo, each counted only itself, so the safety hide never ran | Medium | Fixed (#95): the count runs after taking the post's row lock | Draft |
| NOW-SF-163 | 2026-10-29 | DB-60 | A member who chose "spam" and then "threat" was dropped, so the founders never heard | Low | Fixed (#95): a safety reason replaces an earlier ordinary one and alerts | Draft |
| NOW-SF-164 | 2026-10-29 | DB-60 | Two accounts over 14 days old can hide any live post they can see with safety reports, until a person decides | Low | Founders decide (Isaac): keep the safety hide on? Bounded by 20 reports a day, founder alerts and the `safety_hide` switch | Draft |
| NOW-SF-165 | 2026-10-29 | DB-60 | A block hides the other person's posts; read-only mode refuses reports, safety ones included | Low | For APP-50 and the founders: report before block; show the support address in read-only mode | Draft |
| NOW-SF-166 | 2026-10-29 | DB-45 | Strip tests couldn't catch a leak (excluded posts could never reach the top 10) | Low | Fixed (#96): excluded posts carry enough likes to top the list | Draft |
| NOW-SF-167 | 2026-10-29 | DB-45 | Near-you cursors from DB-41 get a 400 after DB-45 | Low | Open for the app (Tolu): restart Near you from page 1 on a 400 | Draft |
| NOW-SF-168 | 2026-10-29 | DB-45 | Likes made while a post was friends, list or picked would start lifting it in public if widened to Public, hinting at private likes (EC-02) | Medium | Fixed (#96): `likes.counts_in_public`, set by DB-39 at the moment of the like; only those count | Draft |
| NOW-SF-169 | 2026-10-29 | DB-45 | Every Near-you page rebuilt and scored the whole candidate set, with per-row block and mute calls | Medium | Fixed (#96): scores stored hourly; ranked_nearby plain SQL with cursor and limit passed in; anti-joins | Draft |
| NOW-SF-170 | 2026-10-29 | DB-45 | Ranking movement can tell an account whether its likes count (held or young), once DB-63 is real | Low | Accepted risk for the founders to confirm (T-15): likes are counted only hourly; consider a 2-liker floor if abuse appears | Draft |
| NOW-SF-171 | 2026-10-29 | DB-45 | The hourly recount rewrote every row, could fail as a whole on a bad weight, and could overlap | Low | Fixed (#96): only changed rows, GREATEST 0, advisory lock | Draft |
| NOW-SF-172 | 2026-10-30 | DB-39 | A comment written while the post's author blocked its writer stayed live and visible to others (the block's clean-up couldn't see it yet) | Medium | Fixed (DB-39, not pushed): comment_shown and the counts hide comments from someone the author blocks; comment locks the follow rows | Draft |
| NOW-SF-173 | 2026-10-30 | DB-39 | Reaction counts on every feed item ran a function per comment, so a post with thousands of comments made public feed pages expensive | Medium | Fixed (DB-39, not pushed): inline block checks, counts stop at 100 ("99+") | Draft |
| NOW-SF-174 | 2026-10-30 | DB-60 | The report check ignores `made_private`: after a widening, anyone who can see the post can report (and so confirm) a private comment, given its random ID | Low | Open for Isaac: use private.comment_shown in report_target | Draft |
| NOW-SF-175 | 2026-10-30 | DB-39 | A like made while the author went private could still count in public ranking | Low | Fixed (DB-39, not pushed): the like locks the author's row too | Draft |
| NOW-SF-176 | 2026-10-30 | DB-39 | Test gaps: guest feed reactions, picked posts, the block race | Low | Fixed (DB-39, not pushed): cases added; like-notification read path left to DB-44's tests | Draft |
| NOW-SF-177 | 2026-10-30 | DB-32 | The `posting_enabled` switch is never checked: turning it off doesn't stop posting | Info | Open for Tolu: check it in create_post beside read_only (and decide whether it also stops comments) | Draft |
| NOW-SF-178 | 2026-10-30 | DB-63 | Two burst-check runs at once could both flag a rating; the second failed on the key and lost its run | Low | Fixed (f61a470, not merged): one run at a time (advisory lock) | Draft |
| NOW-SF-179 | 2026-10-30 | DB-63 | At a busy place, one coordinated signal can sweep in an honest rater (an account made within an hour of others, a shared café network); in hold mode that holds an honest rating until staff look | Low | Open for the founders: accepted in flag mode (review only); revisit the rules before switching to hold mode | Draft |
| NOW-SF-180 | 2026-10-30 | DB-63 | The network signal depends on Supabase passing Cloudflare's `cf-connecting-ip` to the database; if it stops, or ratings go through our own server, every member shares one address or none | Low | Open for Tolu: check once on staging that a rating records a network signal | Draft |
| NOW-SF-181 | 2026-10-30 | DB-63 | With the abuse key missing from Vault, signals stop being recorded with only a database log line (fails open so posting never breaks) | Low | Open: add a "signals recorded in the last day" count to the health check (BE-11) | Draft |
| NOW-SF-182 | 2026-10-30 | DB-63 | No burst check for likes, saves or "Been here" (F-17): coordinated likes can lift a post in Near you and the strip with nothing flagged | Medium | Open for Isaac: build before public launch (likes have no held state yet) or accept for the beta | Draft |
| NOW-SF-087 | 2026-10-23 | DB-37 | A verdict given on a private post reached public totals when an older public post existed | High | Fixed (#59, 098a58b) | Draft |
| NOW-SF-088 | 2026-10-23 | DB-37 | The hour before counting ran from writing, not from going live | Medium | Fixed (#59, 098a58b) | Draft |
| NOW-SF-089 | 2026-10-23 | DB-37 | Three posts by one person unlocked a place verdict | Medium | Fixed (#59, 098a58b) | Draft |
| NOW-SF-090 | 2026-10-23 | DB-37 | Ranking settings unchecked: floors could go below 3, a bad value stopped the job | Medium | Fixed (#59, 098a58b) | Draft |
| NOW-SF-091 | 2026-10-23 | DB-37 | A ban or removal at a quiet place stayed public until the nightly run | Medium | Fixed (#59, 098a58b) | Draft |
| NOW-SF-092 | 2026-10-23 | DB-37 | Raw counts and weights must stay out of place reads and pins | Low | Handed to DB-38, DB-55 (contracts §2) | Draft |
| NOW-SF-093 | 2026-10-23 | DB-37 | At a quiet place, hourly differences can show someone joined or left | Low | Accepted (EC-99; readers round) | Draft |

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

### NOW-SF-058 to NOW-SF-061: review of E19 (post picks)
> Draft, not confirmed
- **Found:** 2026-10-22, the `now-security-reviewer` agent on Sonnet, on #56 before merge. Nothing Critical or High. Picks reach only current, unblocked, active friends; grants, RLS and the replaced `create_post` checked and clean.
- **SF-058, SF-059:** the tests now prove replacement and the cascade; `set_post_picks` refuses a post that isn't an unpublished picked post.
- **SF-060, SF-061:** contracts §2 now says DB-27 checks the author and clears picks when leaving picked, DB-26 reads picks only for picked posts and trims them again under the follow locks, and `can_view` never reads `post_picks`.
- **Evidence:** 17 pgTAP tests in CI with the whole suite (#56).

### NOW-SF-062 and NOW-SF-063: review of the post timer dial
> Draft, not confirmed
- **Found:** 2026-10-22, the `now-security-reviewer` agent on Sonnet, on #57 before merge. Nothing Critical or High; grants after the DROP and CREATE, validation, Lagos times and the jitter on the default, tonight and tomorrow morning checked and clean.
- **SF-062:** a dialled 5-15 minutes tells a watcher about as much as "Post now", and round values are guessable. Kept by Tolu's decision (the member's own choice); the app shows the "people may know you're there" warning under 60 minutes (APP-33, 0010 amendment). Totals can't leak it: they count only after an hour (AD-12).
- **SF-063:** minutes are now refused unless the timer is custom, and with "Post now".
- **Evidence:** 60 pgTAP tests in CI (#57).

### NOW-SF-064 to NOW-SF-066 and NOW-SF-075: review of DB-21 part 2 (the visibility rule)
- **Found:** 2026-10-23, Junior's inline review (Isaac's call, no agent) of DB-21 part 2, uncommitted on `feature/db-21-visibility-rule` (`supabase/migrations/20261022210000_db_21_visibility_rule.sql`: `can_view`, `post_audience`, `post_audience_pending`, the snapshot trigger, the list-removal trigger, `public_posts`). Nothing Critical or High. Checked and clean: `can_view` matches system architecture §7.1 line by line (guests go to the public branch before any block check, so SF-022's worry can't happen; a missing post is false; author sees every state but deleted); member and post statuses match DB-10 and DB-31; the projection carries no exact time, pending text, client ID or audience; grants, row rules and `security_invoker` on the view; `posts` stays closed to the API roles, so dropping the RV3-14 policy wrapper opens nothing. All three gaps below were reproduced on PGlite before writing them up.
- **SF-064:** the trigger header says "a row a clean-up missed opens nothing", and the test checks that only while the two are still apart. When they follow each other again, `is_friend` is true and the old row grants the old list or picked post, which FR-AUD-04 says they lost. Everything hangs on DB-22, DB-23, DB-14 and the revocation replay each deleting the rows. Proposed fix: an AFTER DELETE trigger on `app.follows` that deletes `post_audience` and `post_audience_pending` rows between the two, both ways, the same pattern this migration already uses for list removals. Why: any follow ending (unfollow, remove follower, block, purge, replay) then cleans up with no task having to remember.
- **SF-065:** `post_audience_check` checks the list is the author's but not that the member is on it, and it locks only the follow rows. If DB-26 reads the list, a removal commits, and DB-26 then inserts the removed person, the removal's clean-up ran too early and the row stays. Proposed fix: for a list row, the trigger requires the `audience_list_members` row and locks it (FOR KEY SHARE), so the removal waits and then deletes the new row. Why: the same RV3-04 lock-first rule the follow rows already get.
- **SF-066:** `can_view` accepts any snapshot row for the post. If DB-27 moves a post from one list to another, or from a list to picks, and misses deleting the old rows, the old people keep it. Proposed fix: a list post's row must come from the post's current list, a picked post's row from no list. Why: one condition on a row `can_view` already reads; it fits AD-14's "only people in both old and new audience" during a widening.
- **Evidence:** DB-21 part 2 tests 31/31 on PGlite, also on top of current `main` (a1efefe); the other failures there (vault shim, PostGIS) fail on `main` too. Repro tests for SF-064, SF-065 and SF-066 each fail on the current code. Real CI not run.
- **Fixed (uncommitted), 2026-10-23, on Isaac's OK:** all three as proposed (`follows_ended` trigger; the snapshot trigger requires and locks the list entry; `can_view` counts only rows for the current audience). Seven new tests (38 in the file); all 38 pass once SF-075's path is avoided, and each fix removed on its own makes at least one test fail (4 mutants, all caught). The branch was brought up to `main` 0b848bc (DB-34) and the migration renumbered to `20261023110000`, after DB-34's, so `db push` accepts it (the SF-031 lesson); the test now writes its posts in DB-34's bulk mode. contracts.md §2 now says the triggers do the clean-up.
- **SF-075 (found while testing the fixes):** once the test gave list posts their list, deleting a list failed with "a removed or deleted post stays that way". `app.posts.list_id` and `pending_list_id` are ON DELETE SET NULL, and DB-31's `posts_guard` refuses any change to a removed or deleted post. So a member who deleted one list post can never delete that list. EC-92's "deleting a list ends access" then fails for every live post on it too, because the whole delete rolls back. A purge that deletes lists before posts hits the same wall. Proposed fix: `posts_guard` lets those two columns become empty on a removed or deleted post (a new migration replacing the function; DB-31 is Tolu's, so he reviews it). Why: the cascade is the only thing that writes them there, and an empty list ID opens nothing. **Fixed (uncommitted), 2026-10-23, on Isaac's OK:** `posts_guard` replaced in the DB-21 part 2 migration; two new tests (the list delete goes through; a deleted post still can't be moved to another list, and a mutant allowing that is caught). Branch brought up to `main` 098a58b (DB-37) and the migration renumbered again to `20261023130000`, since DB-37 took `20261023110000`. Whole suite on PGlite: `db_21_visibility_rule` 40/40, `db_31`, `db_34` and `db_37` pass; the only failures are the stand-in's missing vault and PostGIS functions, which fail on `main` too.
- **Locked:** by Isaac, 2026-10-29.

### NOW-SF-067 to NOW-SF-074: review of DB-34 (the publish step)
> Draft, not confirmed
- **Found:** 2026-10-23, the `now-security-reviewer` agent on Sonnet, on #58 before merge. Nothing Critical or High. No member path can make a post live: `now.go_live` and `now.bulk_mode` are transaction settings PostgREST can't set, and bulk mode is refused when a member is signed in. Concurrency, hold reasons, notifications and `pg_cron` checked.
- **SF-067:** the job selects due posts without locking and locks each one only as it publishes it, 100 a run; the cron command stops a run at 50 seconds.
- **SF-068:** `can_view` (DB-21 part 2) must show a live list or picked post with no snapshot rows to its author only, with a test.
- **SF-069:** inbox rows now skip followers who can't see the place; DB-41's read must re-check `can_view`, `place_visible`, blocks and mutes, with an access test.
- **SF-070 to SF-072, SF-074:** a held post always has its reason; nothing jumps from waiting to hidden; no notice to a banned or deleting author; `prune_cron_runs` keeps 3 days of the cron log.
- **SF-073:** kept: a failed publish waits for staff rather than retrying.
- **Evidence:** 33 pgTAP tests in CI with the whole suite (#58).

### NOW-SF-076 to NOW-SF-086 and NOW-SF-094 to NOW-SF-098: review of DB-07 (staff logins and the audit log)
- **Found:** 2026-10-23, the `now-security-reviewer` agent on the DB-07 draft (uncommitted, `feature/db-07-staff-audit`), plus SF-086 by Junior. One High: the rest of the draft held (empty `search_path`, no API role reaches the tables, sequence or functions, refusals unlogged by design, append-only log).
- **SF-076 (High, NFR-SEC-24):** `require_staff` read `aal` and `amr` from the token. With the service key, an attacker can delete a staff login's authenticator through the Auth admin API, start a session for that login, enrol a new authenticator (allowed when none is verified) and get a valid `aal2` token. **Fix:** each role is pinned to one verified TOTP factor at `add_staff`; `require_staff` reads the session's `aal` and factor from `auth.sessions` and the TOTP time from `auth.mfa_amr_claims`, and the factor must be the pinned, still-verified one. **Why this fix:** the database already holds the truth about how a session was raised, and a swapped factor can't match the pin, so it fails closed and only a founder over a direct connection can re-pin. Columns confirmed on a live Supabase project (read-only schema query).
- **SF-077:** `remove_staff` now deletes the staff login itself; sessions, refresh tokens and authenticators cascade. A returning moderator gets a new login.
- **SF-078:** the reason is capped at 200 characters and refuses 10 or more digits in a row, `@` and new lines; IDs go in `target_ids`. The role moved into the action name (`founder_added`, `moderator_added`).
- **SF-079 to SF-084:** repeatable read refused in the member-or-staff trigger; the test fixture rewritten (amr no longer read); the DB-03 guards strip comments before matching (all three, not only the staff one); `UPDATE` on `app.staff` refused; `add_staff` refuses a login with a phone number; schema and sequence privilege tests added. Attribution of direct changes waits for DB-08's pgaudit; the 100-target cap is noted for DB-61.
- **SF-085:** with email sign-in and the phone provider off (system architecture §4.10), only the service-key path can create a staff session. SF-076's pin means a stolen key still gets no staff power, but the first step shouldn't depend on that key. Written up as open question E20 for Isaac; blocks DB-61 and APP-51.
- **SF-086:** the audit log's append-only trigger blocked every delete, so the data map's 12-month retention could never be applied. `private.purge_audit_log()` (same pattern as DB-06), run daily by Supabase Cron.
- **Evidence:** `db_07_staff_audit.sql` 56/56 and `db_03` 9/9 on the PGlite stand-in (Auth's MFA tables and a cron shim added to mirror the live schema); seven mutants (factor pin, verified check, phone regex, phone-login check, keeping the login on removal, purge age check, a commented-out staff check) each fail at least one test. Real CI not run. Second review pass pending.
- **Second pass (2026-10-23, same agent, on the fixed code):** SF-076 to SF-084 and SF-086 confirmed fixed; nothing Critical, High or Medium. Checked read-only on a live Supabase project's Auth schema (MindBridge's, the only one the connector sees; schema metadata only): the service key can't write `auth.sessions`, `auth.mfa_factors` or `auth.mfa_amr_claims`; `postgres` can delete from `auth.users`; no Storage foreign key points at `auth.users`; Auth times are `timestamptz`. New Lows: **SF-094** (proposed fix: the `staff_removed` trigger writes the audit row, so an admin-API deletion is audited too); **SF-095** (legal item 36); **SF-096** (contrived, a reviewer catches it; note it in the test); **SF-097** (accept); **SF-098** (the old file was never committed, so CI and Tolu's pushes never saw it; only a local `supabase db push` by Isaac could have applied it to staging).
- **Locked:** by Isaac, 2026-10-29.

### NOW-SF-087 to NOW-SF-093: review of DB-37 (place totals)
> Draft, not confirmed
- **Found:** 2026-10-23, the `now-security-reviewer` agent on Sonnet, on #59 before merge. One High; nothing Critical.
- **SF-087 (High):** every post takes a rating (DB-32) and a post 30 days later replaces it, so a member with an old public post who later posted Friends-only had their private verdict and price counted publicly. Fix: a rating counts only if an eligible public post made it or showed it later (`source_id`, or a public post written after the rating). Tested both ways.
- **SF-088 to SF-091:** an hour from going live too; 3 people for a verdict; settings validated with floors of 3 and a prior of at least 1; places with public totals refresh hourly.
- **SF-092:** contracts §2 tells DB-38 and DB-55 what they may show (raters only beside a verdict; no raw counts below the thresholds; never the weights).
- **SF-093:** accepted as EC-99 already records it.
- **Evidence:** 32 pgTAP tests in CI with the whole suite (#59).

### NOW-SF-099 to NOW-SF-102: review of DB-52 (summary rules)
> Draft, not confirmed
- **Found:** 2026-10-23, the `now-security-reviewer` agent on Sonnet, on #60 before merge. Nothing Critical or High: tags and "Varies" come only from what DB-37 already counts, and every floor holds.
- **SF-099 to SF-101:** a tie is never a clear lead and the margin floors at 0.01; one scan of each person's posts; only real pairs of two different NOW tags.
- **SF-102:** the code needs 3 people for a tag (one person's posts can't make one); FR-PLC-14 says 3 posts. Tolu to confirm the stricter rule and the wording.
- **Evidence:** 15 pgTAP tests in CI with the whole suite (#60).

### NOW-SF-103 to NOW-SF-105: review of DB-09 (development seed data)
> Draft, not confirmed
- **Found:** 2026-10-23, the `now-security-reviewer` agent on Sonnet, on #61 before merge. Nothing Critical or High; the data is made up and nothing can load it but `pnpm db:seed` (`--local`, seeding off in config.toml, enforced by the CI config guard).
- **SF-103:** the seed now also refuses any login or tester it didn't make, which staging and production have from the first tester (tested). Accepted: someone deliberately running the file by hand against an empty remote database; the README says never to.
- **SF-104, SF-105:** the numbers are 12 digits, one short of a Nigerian number, so no SMS reaches them; ratings in post order; direct status changes marked as seed shortcuts.
- **Evidence:** CI loaded the seed (16 posts in every status, 7 members, 2 inbox rows) and saw it refuse a stranger and skip a second run (#61).

### NOW-SF-106 to NOW-SF-110: review of DB-57 (state helpers)
> Draft, not confirmed
- **Found:** 2026-10-23, the `now-security-reviewer` agent on Sonnet, on #62 before merge. Nothing Critical or High; transitions (no re-publish, no resurrection, never two current ratings), logging of hides, removals, comment hides and bans, and the held-edit hash check are clean.
- **SF-106:** `private.config_shape_ok`: a setting keeps its keys and types, numbers stay at least 0, and only a monthly cap may go back to null (its feature then fails closed).
- **SF-107:** the advisory lock first, then the row, in both functions. **SF-108:** keep is tested with the guard on, with a negative control.
- **SF-109:** accepted: `revocation_log` holds removals only, so after a restore staff re-apply keeps and unbans (system architecture's restore procedure).
- **SF-110:** keep refuses an inactive author; a rating restriction counts from the next hourly refresh (accepted).
- **Evidence:** 54 pgTAP tests in CI with the whole suite (#62).

### NOW-SF-111 to NOW-SF-113: review of DB-15 (daily clean-up)
> Draft, not confirmed
- **Found:** 2026-10-23, the `now-security-reviewer` agent on Sonnet, on #63 before merge. Nothing Critical or High: no member, staff login, tester, used invite or evidence can be deleted; `app.members` blocks deleting any login with a profile.
- **SF-111:** logins signed in to within 7 days are left, locked ones are skipped, and each step runs on its own.
- **SF-112:** for Isaac: once DB-07 adds `app.staff`, `private.cleanup` must also skip staff logins, with a pgTAP case. **Fixed 2026-10-29 on Tolu's go:** `20261029100000_db_07_cleanup_skips_staff.sql` (merged in #73, CI green) adds the check; two DB-15 cases cover the staff check and the authenticator check alone; `now-security-reviewer` found nothing. 
- **SF-113:** logins with no phone stay until the rule covers future sign-in methods (E13); abuse signals, analytics and inboxes are cleaned by DB-63, DB-46 and DB-41.
- **Evidence:** 17 pgTAP tests in CI with the whole suite (#63).

### NOW-SF-114 to NOW-SF-117: review of DB-40 (saves, Been here, Did you go?)
> Draft, not confirmed
- **Found:** 2026-10-23, the `now-security-reviewer` agent on Sonnet, on #64 before merge. Nothing Critical or High: rows are owner-only, never reach a public output, and pending places give the same "not found".
- **SF-114:** `get_saved` shows `did_you_go_pending`, so the app can ask even if the push is dropped.
- **SF-115:** a "yes" leaves a post rating alone; `take_rating` lets a post supersede a "Did you go?" rating rather than inherit it (its verdict counts in public; the private one never does).
- **SF-116:** `get_saved` gives the place ID (random, as every other place call takes it) with the public ID.
- **SF-117:** 2,000 saves a member (proposed); DB-48 merges saves and "Been here" like ratings.
- **Evidence:** 37 pgTAP tests in CI with the whole suite (#64).

### NOW-SF-118 to NOW-SF-122: review of DB-44 (notifications)
> Draft, not confirmed
- **Found:** 2026-10-23, the `now-security-reviewer` agent on Sonnet, on #65 before merge. Nothing Critical or High: every read and every push re-checks that the member may still see what it is about (T-23); the push carries only the notification ID; the `pgmq` schema and the four tables give API roles nothing.
- **SF-118:** `alert_founders` sends at most 10 of a kind an hour; the rest are kept unsent and counted by `health_facts`.
- **SF-119:** `register_push_token` retries once and otherwise raises a retryable error.
- **SF-120:** `remove_push_token` is never rate-limited; DB-13's "log out of all devices" (and a ban) must delete the member's tokens.
- **SF-121:** `claim_pushes` drops a push whose type was switched off; `new_follower` and `follow_back` show only while the follow stands.
- **SF-122:** BE-07 sends idempotently; marking all rows seen on the first page accepted.
- **Evidence:** 70 pgTAP tests in CI with the whole suite (#65).

### NOW-SF-123 to NOW-SF-127: review of DB-36 (adding a place)
> Draft, not confirmed
- **Found:** 2026-10-23, the `now-security-reviewer` agent on Sonnet, on #66 before merge. Nothing Critical or High: no lookup or same-place answer shows a pending place the member can't already see, and `added_by` is never returned.
- **SF-123:** the health check counts rejected places still holding details after 30 days.
- **SF-124:** places the member ruled out leave the candidates before the 5-place cap.
- **SF-125:** 3 rejections in 30 days return `too_many_rejected` (proposed); `places_pending` and `oldest_pending_place_days` show the backlog.
- **SF-126:** open, for the founders: a pending place links its adder, pin and creation time until reviewed; proposed auto-reject after 30 to 60 days.
- **SF-127:** only a place made counts against the 10 a day; names over 500 characters are refused first.
- **Evidence:** 45 pgTAP tests in CI with the whole suite (#66).

### NOW-SF-128 to NOW-SF-132: review of DB-46 (analytics)
> Draft, not confirmed
- **Found:** 2026-10-23, the `now-security-reviewer` agent on Sonnet, on #67 before merge. No event stores a member ID, free text or location.
- **SF-128:** guest and share-page calls now use the all-zero UUID as their rate key (CI confirmed the failure first).
- **SF-129:** one guest `app_opened` a call; 5,000 guest calls and 20,000 share-page opens an hour (proposed), behind AWS WAF.
- **SF-130:** `private.ui_event_props` fixes each phone event's properties; `analytics_props_ok` never errors on a value that isn't an object.
- **SF-131:** turning `exact_times` off clears kept times; cascade deletes log nothing (detected by the missing other end, since FK cascades don't raise `pg_trigger_depth`); the beta-end clean-up must call `delete_beta_events`.
- **SF-132:** accepted.
- **Evidence:** 43 pgTAP tests in CI with the whole suite (#67).

### NOW-SF-133 to NOW-SF-137: review of DB-48 (place merge)
> Draft, not confirmed
- **Found:** 2026-10-23, the `now-security-reviewer` agent on Sonnet, on #68 before merge. Nothing shows a hidden or pending place's posts reaching anyone who shouldn't see them.
- **SF-133:** writes at a place wait for a merge and follow it (saves, "Been here") or are refused (ratings).
- **SF-134:** the merge takes take_rating's per-member locks, sorted, before the place locks.
- **SF-135:** kept rating ranked: a post's over "Did you go?", active over pending over held, then newer.
- **SF-136:** undo checks the survivor and later merges, restores dropped rows only if the kept one still exists, skips departed members; member data purged after 90 days or on undo.
- **SF-137:** handed on: DB-38, DB-41 and pins show only live and closed places and resolve old IDs.
- **Evidence:** 42 pgTAP tests in CI with the whole suite (#68).

### NOW-SF-138 to NOW-SF-142: review of DB-13 (devices and recovery)
> Draft, not confirmed
- **Found:** 2026-10-23, the `now-security-reviewer` agent on Sonnet, on #69 before merge (a first run stalled and was rerun). Nothing Critical or High: the device check is bound to the session and member, tokens are 256-bit, hashed, single-use and member-bound, and the add answer is the same in every branch.
- **SF-138:** `recovery_email_target` limit, counted in both branches.
- **SF-139:** `auth.identities` phone data updated; BE-03 test that check-code never takes the member from the request.
- **SF-140:** `recovery_email_confirm` limit.
- **SF-141:** open for the founders: a fresh phone code or a 24-hour hold to replace a recovery email, before recovery by email goes live.
- **SF-142:** `log_out_all_devices` needs only a live session; `claim_emails` archives an address that won't decrypt; races on confirm and register answer cleanly.
- **Evidence:** 47 pgTAP tests in CI with the whole suite (#69).

### NOW-SF-143 to NOW-SF-145: review of DB-59 (recycled numbers)
> Draft, not confirmed
- **Found:** 2026-10-23, the `now-security-reviewer` agent on Sonnet, on #71 before merge. Nothing Critical or High in the SQL; the main risk is how check-code (BE-03, not built) uses it.
- **SF-143:** BE-03 must gate before any token exchange, treat errors and limits as refusal, take member and install from the checked attempt, and show one neutral screen.
- **SF-144:** checks carry the install hash; 3 codes a day per phone, 10 per account.
- **SF-145:** fixed as listed.
- **Evidence:** 23 pgTAP tests in CI with the whole suite (#71).

### NOW-SF-146 to NOW-SF-147: review of DB-58 (quiet-place totals)
> Draft, not confirmed
- **Found:** 2026-10-23, the `now-security-reviewer` agent on Sonnet, on #72 before merge. No Critical or High; the hold stops the hourly verdict leak (EC-99).
- **SF-146:** a removal (deleted or removed post, ban, rating restriction) releases the hold at once (FR-MOD-08); DB-38 and DB-41 show a verdict only with enough eligible posts.
- **SF-147:** `quiet_contributors` clamped.
- **Evidence:** 15 pgTAP tests in CI with the whole suite (#72).

### NOW-SF-148 to NOW-SF-150: review of APP-06 (interface events client)
> Draft, not confirmed
- **Found:** 2026-10-29, the `now-security-reviewer` agent, on the uncommitted `feature/app-06-ui-events` (Claude for Tolu). No Critical, High or Medium: events are fixed codes, held in memory only, filtered again by the server.
- **SF-148:** the queue knows its owner; before each batch the phone's session must match, or the owner's events are dropped.
- **SF-149:** one app_opened a day per owner, so guests don't drain the shared 5,000-an-hour limit.
- **SF-150:** the owner-change test; removing the reset in DataProvider fails it.
- **Evidence:** app suite 36/36, typecheck and lint clean, on this laptop.

### NOW-SF-151 to NOW-SF-153: review of DB-62 (risky-word check)
- **Found:** 2026-10-29, Junior's inline review for Isaac (no agent, on Isaac's instruction), on `feature/db-62-risky-words` before a PR. No Critical, High or Medium: the only pattern is a fixed character class, text is capped at 5,000 characters, and the list is never turned into a pattern.
- **SF-151 (Low, accepted for the beta):** a member can learn the list by posting and seeing "being checked"; the post limit (20 an hour, photos needed) slows it. Spelling tricks such as "sc4m" pass; reports are the backstop.
- **SF-152 (Info, Tolu to confirm):** the list's trigger raises `risky_word_list_version` in Tolu's `app_config` directly, as Tolu's own migrations do; DB-05 reserved the key for DB-62.
- **SF-153 (Low, documented):** `check_risky_text` reads `app.risky_terms`, which only the owner can read, so a caller running as an API role would fail; contracts.md now says to call it from owner-run code, and that edits and comments (DB-35, DB-39) must call it too.
- **Evidence:** db_62 36/36, db_32 62/62, db_18 21/21 on the PGlite harness; whole suite unchanged apart from harness-only failures. Real CI not run.
- **Locked:** by Isaac, 2026-10-29.

### NOW-SF-154 to NOW-SF-161: review of DB-41 (feeds)
> Draft, not confirmed
- **Found:** 2026-10-29, the `now-security-reviewer` agent, on PR #92 before merge (Claude for Tolu). No Critical or High: no feed path shows a post the viewer may not see; every candidate passes can_view, the follow and mutes; Near you reads only the public projection.
- **SF-154, 155:** speed and denial-of-service fixes in the Following fallback and Near you.
- **SF-156 to 160:** held verdicts hidden, photo count not leaked, cheaper trim, no vanishing posts, more tests.
- **SF-161:** open until the production log settings are checked.
- **Evidence:** CI on #92 (db_41_feeds.sql and the whole suite).

### NOW-SF-162 to NOW-SF-165: review of DB-60 (reports)
> Draft, not confirmed
- **Found:** 2026-10-29, Junior's inline review for Isaac (no agent), on `feature/db-60-reports` before a PR. No Critical or High: reports reach only what the reporter can see, the answer is always "received", and nothing is removed automatically except the planned safety hide.
- **SF-162 (Medium, fixed):** two established safety reports at the same moment, one on a post and one on its photo, sit on different items, so each could count only itself and the safety hide never ran. The count now runs after taking the post's row lock.
- **SF-163 (Low, fixed):** reports are kept once per member and item, so a member who first chose "spam" and then "threat" was dropped and the founders never heard. A safety reason now replaces an earlier ordinary one and alerts.
- **SF-164 (Low, founders decide):** two accounts over 14 days old can hide any live post they can see with safety reports, until a person decides (RV1-26 by design). Bounded by 20 reports a day, every safety report alerts both founders, and the `safety_hide` switch turns it off. The switch shows in `get_app_config`, which tells people whether it is on.
- **SF-165 (Low, for APP-50 and the founders):** a block hides the other person's posts, so the app must send a report before a block; profiles stay reportable through a block and in any account state. In read-only mode reports, safety ones included, are refused, so the app should show the support address then.
- **Evidence:** db_60 48/48 on the PGlite harness; mutants (no visibility check, no established filter, no legal hold, no comment status, no switch, no safety upgrade) each fail a test; whole suite unchanged apart from harness-only failures. Real CI not run.

### NOW-SF-166 to NOW-SF-171: review of DB-45 (ranking reads)
> Draft, not confirmed
- **Found:** 2026-10-29, the `now-security-reviewer` agent, on PR #96 before merge (Claude for Tolu). No Critical or High: Near you and the strip read only the public projection; no score, count, time or liker is returned.
- **Numbering:** first drafted as SF-162 to 167, which clashed with DB-60's SF-162 to 165 (merged first, #95). DB-45's 162 to 165 became 168 to 171 on 2026-10-29 (Tolu); 166 and 167 kept their numbers.
- **SF-168:** the one product rule this adds: a like counts in public ranking only if the post was public when it was liked. DB-39 sets `counts_in_public`.
- **SF-169, 171, 166:** speed, robustness and test fixes. **SF-170:** accepted risk for the founders. **SF-167:** app follow-up.
- **Evidence:** CI on #96.

### NOW-SF-172 to NOW-SF-177: review of DB-39 (likes and comments)
> Draft, not confirmed
- **Found:** 2026-10-30, the `now-security-reviewer` agent, on the uncommitted `feature/db-39-likes-comments` (Junior for Tolu). No Critical or High. Before the review Junior had already closed a widening leak: a list post widened later would have shown its list members' comments and like count to everyone, so `made_private` now keeps them private for good (EC-02).
- **SF-172, 173, 175, 176:** fixed in DB-39. **SF-174:** Isaac's DB-60. **SF-177:** pre-existing in DB-32, Tolu's call. Also noted: hidden comments are never erased (retention to confirm); like counts left blocked likers in (fixed with SF-173).
- **Evidence:** reviewer's report; CI not run yet (branch not pushed).

### NOW-SF-178 to NOW-SF-182: review of DB-63 (rating integrity)
> Draft, not confirmed
- **Found:** 2026-10-30, Junior's inline review for Isaac (no agent), on `feature/db-63-rating-integrity` (f61a470). No Critical or High: abuse signals are HMACs under their own Vault key, recorded only in the member's own request from headers a caller can't set; the tables are closed to every API role; the mode switch is founder-only and audited; burst notes carry counts and signal names only.
- **Numbering:** first drafted as SF-172 to 176, which clashed with DB-39's 172 to 177 (Tolu's session the same night); renumbered in f4af753.
- **SF-178 (fixed):** an advisory lock makes the 10-minute job run one at a time.
- **SF-179, 180, 181 (Low, open):** detection quality, not data exposure. **SF-182 (Medium, Isaac):** F-17 covers likes, saves and "Been here" too; DB-63's plan line covers ratings only.
- **Evidence:** db_63 36/36 on the PGlite harness; whole suite unchanged apart from the known harness-only failures (db_07 #37, db_13, db_30, db_36); DB-37's and DB-45's fixtures changed for real weights. Real CI not run.
