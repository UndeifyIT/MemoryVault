---
status: active
project: website
type: reference
author: junior
created: 2026-10-16
updated: 2026-10-16
---
# Undeify Website Status

## Snapshot
- **Stage:** v1 built and pushed (CompanyWebsite 1ed3a1e, 2026-10-16). Not deployed yet.
- **What works:** home page with the pinned scroll hero (night room → frame swings into a window in 3D → sunrise → daylight rises), intro, product folders (NOW, ShiftOS, a Yorùbá app "in research"), about, contact, footer; privacy notice, terms, security page, security.txt, strict security headers. Checked with the taste-skill lint and browser inspector at 1440, 768 and 390px: 0 fails, 2 defended warnings (no video; hero text sits on the night picture's dark space by design).
- **Figma:** https://www.figma.com/design/Hwsdaunvh7t4BMdTTnmM9U, page "Website v1" (8 frames). Shows a fallback font until Boska is installed.
- **Known issues:** the hero scenes are upscaled from the low-resolution ChatGPT collage and look soft on big screens; hello@undeify.com forwarding not confirmed; no street address or hours on the site yet (Apple may ask); CAC registration not complete, so no legal name or RC number on the site.

## Where we stopped

### Isaac
Site is in the repo, not live. Next: connect Cloudflare Pages to the repo (no build command, output folder `site`), then add undeify.com as a custom domain. Test by opening the live URL on a phone and a laptop and scrolling the hero both ways.

### Tolu
Nothing yet. Confirm undeify.com is ours in Namecheap and that hello@ forwards to a founder inbox.

## Next steps
1. Deploy to Cloudflare Pages and point undeify.com at it (Isaac).
2. Confirm hello@undeify.com forwarding (Tolu).
3. Send the full-size originals of the ChatGPT scene images to replace the soft crops (Isaac).
4. Founders approve or change the "Junior's call" decisions in the repo's `docs/decisions.md`.
5. After CAC registration: add the registered name and RC number to the About section and privacy notice.
