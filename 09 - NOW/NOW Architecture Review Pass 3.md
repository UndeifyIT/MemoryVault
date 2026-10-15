---
status: idea
project: now
type: reference
author: junior
created: 2026-10-15
updated: 2026-10-15
---
# NOW Architecture Review Pass 3

> Draft, not confirmed: review pass 3 findings on the NOW system architecture Draft v3. All are now fixed in the uncommitted Draft v4 and prototype v4. The prototype fixes are tested; the document-only fixes are untested at Isaac's request (2026-10-15). Waiting for Isaac.

Review pass 3 (night of 2026-10-14 to 15) of the Now repo's `docs/engineering/system-architecture.md` Draft v3 found 24 issues: 0 Critical, 3 High, 11 Medium, 10 Low, so v3 does not pass. It was the last pass: Isaac said to stop after pass 3, then to wrap up without more tests. Source: an independent reviewer agent; Junior reproduced the three Highs on the prototype. The reviewer's full report and scripts were in a temporary folder and are not kept; this note is the record.

## Fixed in prototype schema v4
Uncommitted in the Now repo, `prototypes/architecture-check/` (schema.sql, test-rules.mjs, test-visibility.mjs, new repro/rv3-highs.mjs and repro/schema-v3.sql).
- **RV3-01 (High):** a post its author deleted, or staff removed, came back live after two "clear" actions. Now publish and clear touch only posts that were never live and are waiting or held.
- **RV3-02 (High):** hiding and then keeping a live post re-ran publishing, so people added to a list since then got old posts, the date moved and followers got duplicate inbox rows. Now a new "hidden" state; keeping a post restores it as it was.
- **RV3-03 (High):** search scores and pin prices revealed hidden activity below the 3-person threshold. Now search returns no score, and ranking, filters and price use only values past their own threshold (3 people who gave a price, for price).
- Also fixed:
  - RV3-04: locking against unfollow and publish races. Reasoned through, not tested, because PGlite has a single connection.
  - RV3-05: approving a held edit is tied to the text the moderator reviewed.
  - RV3-06, partly: a post counts in totals only once it is an hour old.
  - RV3-13: audience changes on live posts. Losses apply at once, gains after the delay.
  - RV3-14: no block oracle, and an empty search path on every function.
  - RV3-15: retired keys are refused, and cursors survive key rotation.
  - RV3-16: a sturdier risky-word check.
  - RV3-17: a banned author's waiting post doesn't publish.
  - RV3-19 with FR-SOC-03: follow requests, which blocks now remove.
  - FR-SOC-11: follower lists.
  - FR-MAP-03: pins need a photo.
  - RV3-20, partly: tile parameter checks.
  - Found while fixing: guests and members could read the raw totals table in the prototype. Closed.
- **Evidence:**
  - 141/141 scenario tests pass.
  - `repro/rv3-highs.mjs` shows all three Highs as REPRODUCED on v3 and fixed on v4.
  - A small property-test run found 0 disagreements over 99,056 viewer–post pairs.
  - **Not run on v4:** the full-size property test and the performance test, both stopped on Isaac's instruction.

## Fixed in the document only (Draft v4, 2026-10-15, untested at Isaac's request)
The design changes, new edge cases EC-98 to EC-120 and founder decisions are in the doc's sections 15 and 16 and Appendix C. Each item below is addressed there:
- RV3-07: two remaining ways to test whether an email uses NOW (the hook's timing, and adding a backup email).
- RV3-08: photo backups can be deleted from production; dumps never expire; the doc contradicts itself on where the dump runs (§4.13, §6.2, §7.4).
- RV3-09: the restore replay misses sessions, identity unlinks, staff removals and place rejections.
- RV3-10: founders' direct reads are not logged.
- RV3-11: deleting the analytics key doesn't unlink events, because timestamps join back to members.
- RV3-12: a phished Expo login can still ship a malicious build through store submission.
- RV3-18: the under-18 refusal memory is wiped after 7 days, not 30.
- RV3-21: the AI cache key can be poisoned.
- RV3-22: deleted posts and exact times are kept.
- RV3-23: the §17 numbers are stale. Scenario tests are 79 on v3 and 141 on v4, not 57. Publishing 500 posts took about 19 s on v3, not the 4 ms the doc gives.
- RV3-24 and RV2-24: cross-document contradictions, and an incomplete §15.E list.
- Pass-2 items only partly fixed:
  - §4.1: the phone's cache is wiped only when the member taps sign-out.
  - F-03: the unique index should also cover pending ratings.
  - Bulk mode must be set per transaction.

## Founder decisions it raised
- RV3-06: how often totals refresh, and whether counts are rounded, at quiet places.
- RV3-08: whether backups are pulled from the backup account (this leaves up to a week of photo copies at risk).
- RV3-10: a standing read role with logged reads, or break-glass access only.
- §4.1: whether the phone may keep non-public content in its cache.
- RV1-26: whether to keep the optional safety hide, which is safe now that "hidden" is its own state.
- RV3-13: confirm the rule for audience changes (losses at once, gains after the delay, list to list included).
- New since pass 3: [[Tolu]]'s decision 0009 (phone and SMS sign-in, proposed, Now a57e3cf) changes the architecture's sign-in design (§4.2, F-02).

## Related
- [[NOW Status]]
- [[NOW Architecture]]
