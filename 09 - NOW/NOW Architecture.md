---
status: active
project: now
type: reference
author: junior
created: 2026-10-13
updated: 2026-10-15
---
# NOW Architecture

Stack **proposed** in the Now repo's decision 0008 by [[Tolu]] on 2026-10-14, waiting for Isaac; once accepted it is "Accepted with conditions" (11 conditions, each met before its part ships to testers). No application code yet.

## Proposed stack (decision 0008)
- **App:** Expo (React Native), TypeScript, one codebase for Android and iOS. Minimum OS versions set at project setup (MapLibre needs Android 6.0+; Expo's default may be higher).
- **Backend:** Supabase (Postgres, PostGIS, Row Level Security, Auth, Storage), Pro plan, London (`eu-west-2`); provisional until the lawyer answers legal item 12 (Supabase has no Africa region). Separate staging and production projects; production credentials never in test config (ShiftOS H3 lesson).
- **Maps:** MapLibre (the open-source code that draws the map in the app) on a Protomaps base map of Nigeria hosted on our own AWS (S3 + CloudFront, served as ordinary tiles by a small function). Isaac's change on 2026-10-15, replacing OpenFreeMap (no SLA) and the Mapbox fallback; recorded in 0008, not yet accepted. Google Maps rejected as the map layer (its places and ratings compete with ours). Map failure falls back to the list view. Map detail is OpenStreetMap's whatever the host; only Google has more.
- **Sign-in:** Google, Apple, email one-time code via Resend; no SMS in the beta.
- **Public place pages:** AWS (CloudFront), Isaac's change on 2026-10-15 (was Cloudflare Pages). **Share-in:** Expo share extension plus TikTok's official oEmbed; Instagram fetches nothing; spike on both platforms first.
- **AI search:** Claude Haiku 5.5, public posts only in the beta, model returns IDs only and facts come from the database; switched off until the NFR-AI-01 test set passes, otherwise the beta ships without it (0006 unchanged).
- **Third parties receiving data:** AWS (IP, map area and page at CloudFront; photos; backups), Anthropic (question and public posts), Resend (email). In the repo's data map and legal items 12 and 24.
- **Planning budget:** about $50 a month with spending alerts; prices are third-party 2026 figures, not quotes.


## Architecture draft (2026-10-14, not decided)
Full design in the repo's `docs/engineering/system-architecture.md` (Draft v2 after review pass 1), with a tested prototype in `prototypes/architecture-check/`. Main proposals beyond 0008: photos on Cloudflare R2 behind a Worker that re-encodes them and serves signed links valid 30–60 minutes; AI search where Haiku 5.5 only picks filters (no posts sent; Jev not adopted for now); guest and shared reads through a Cloudflare `edge` Worker; Following feed from a per-member inbox; friendship and public-ness computed when read; dates only, random IDs, encrypted cursors; posts appear 60–105 minutes after posting; hourly totals; staff functions need multi-factor sign-in from separate staff logins; no over-the-air updates in production; weekly encrypted backups in a separate Cloudflare account. Founder decisions it needs are in its section 15.

**Draft v5 (2026-10-15, Isaac's call, uncommitted):** all hosting outside Supabase moves to AWS: photos in S3 (London) with an `img` Lambda function and CloudFront checking signed links, the `edge` function behind CloudFront and AWS WAF, public pages, the Protomaps base map (`tiles` function), backups in a separate AWS account with S3 Object Lock, GitHub OIDC instead of stored AWS keys. CloudFront on a flat-rate plan (Free $0 or Pro $15/month, no overage charges; checked 2026-10-15 on AWS docs). Open: keep Cloudflare Access (admin console, FR-MOD-09) and Turnstile as free tools, or replace them; a CSAM hash-matching service to replace Cloudflare's free tool before open sign-ups (EC-49); spike items EC-121 to EC-124. The AWS parts have had no review pass or test.

## Known constraints
From the repo's research, decision 0006 and `docs/product/`.
- **Android and iOS** from the beta (0006). About 82% of Nigerian phones are Android, mostly low-end Tecno and Infinix with 3–4 GB of RAM.
- **Data-light.** Mobile data costs ₦430–640 per GB. Photos and video drain data far more than the map: compress photos on the phone, stills by default, no autoplay, a list view.
- **Map as the home screen** (0006), so map loads happen on every open: map provider cost matters (Google Maps Platform, Mapbox or self-hosted open tiles).
- **Place data.** Overture Maps is the baseline (Meta-sourced CDLA-Permissive-2.0, Foursquare-sourced Apache 2.0; attribution required). Don't use OpenStreetMap for the core database (ODbL share-alike). User-added places stay private to the adder and their friends until checked.
- **Sharing out** through ordinary links to a public place page with a preview card; no WhatsApp Business API bot (banned by Meta since 15 Jan 2026).
- **Sharing in** from TikTok and Instagram: our server calls only TikTok's official lookup, never the user's link (SSRF); Instagram links fetch nothing; the user picks the place.
- **AI search** only finds and summarises real posts; never invents a place, hours or a price. Billed in dollars per question.
- **Sign-in by Google, Apple or email one-time code, phone optional** (decided 2026-10-14, E13). No passwords. SIM-swap-proof recovery only matters for members who add a phone. Rating integrity rests on new-account weighting, per-account limits, multi-signal burst detection and review, not on phone numbers; these reduce abuse, they don't eliminate it.
- **Privacy enforced on the server:** post audiences, friends, private accounts, blocks; the access-control tests in decision 0002 §6 and `docs/product/following-and-friends.md` run before the beta.
- **Location safety:** no live location; posts appear 1 hour later by default and show the date, never the time; place totals only from 3 contributors.
