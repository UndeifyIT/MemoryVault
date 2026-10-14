---
status: active
project: now
type: reference
author: junior
created: 2026-10-13
updated: 2026-10-14
---
# NOW Architecture

Not decided yet (checked 2026-10-14). There is no application code, and no tech stack has been chosen. The stack is now needed before the private beta (repo open questions E1–E5, E9–E11; owner [[Tolu]]).

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
