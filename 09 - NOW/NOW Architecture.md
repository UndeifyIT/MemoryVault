---
status: active
project: now
type: reference
author: junior
created: 2026-10-13
updated: 2026-10-13
---
# NOW Architecture

Not decided yet (checked 2026-10-13). There is no application code, and no tech stack has been chosen.

## Known constraints from the research
These come from the repo's `docs/research/2026-10-13-concept-research.md` and `docs/decisions/0003-home-screen.md`.
- **Android first.** About 82% of Nigerian phones are Android, mostly low-end Tecno and Infinix with 3–4 GB of RAM.
- **Data-light.** Mobile data costs ₦430–640 per GB, so: stills only, low-resolution images, no autoplay, and a data-saver mode by default.
- **Place data.** Overture Maps is the baseline. Meta-sourced records are under CDLA-Permissive-2.0 and Foursquare-sourced ones under Apache 2.0, so attribution is required. Don't use OpenStreetMap for the core database: its ODbL licence is share-alike.
- **WhatsApp sharing goes through ordinary links** to a web vote page that needs no install. Never use a WhatsApp Business API AI bot; Meta has banned those since 15 Jan 2026.
- **Phone-number sign-in by SMS code.** Plan account recovery around SIM-swap attacks.
- **Location safety:** no live location for individuals, friends' visits shown at least 24 hours late, and only aggregate counts.
