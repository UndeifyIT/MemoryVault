---
status: active
project: website
type: reference
author: junior
created: 2026-10-16
updated: 2026-10-21
---
# Undeify Website Status

## Snapshot
- **Stage:** redesigned in Vercel's design language on Isaac's call (CompanyWebsite 939fc6b, 2026-10-16); Home page matches Vercel's layout, corrected after Isaac's review (aa0f799). Not deployed yet.
- **What works:** home page with the pinned scroll hero (night room → frame swings into a window in 3D → sunrise → daylight rises), intro, product folders (NOW, ShiftOS, a Yorùbá app "in research"), about, contact, footer; privacy notice, terms, security page, security.txt, strict security headers. Checked with the taste-skill lint and browser inspector at 1440, 768 and 390px: 0 fails, 2 defended warnings (no video; hero text sits on the night picture's dark space by design).
- **Prototype candidate:** the separate handoff prototype has complete Privacy and Terms pages, no security or cookie-consent UI, page metadata, a skip link, bundled company branding/icons, a refined header, one shared contact form, and an automatically looping facts strip with pause and reduced-motion support. Its [Formspree](https://formspree.io/) form ID is blank, so it blocks submission and offers direct email instead. The privacy notice discloses the form data and provider. It is only a local prototype; nothing has been ported to the CompanyWebsite repo or deployed.
- **Figma:** https://www.figma.com/design/Hwsdaunvh7t4BMdTTnmM9U holds the dropped first design only.
- **Known issues:** the hero scenes are upscaled from the low-resolution ChatGPT collage and look soft on big screens; hello@undeify.com forwarding not confirmed; no street address or hours on the site yet (Apple may ask); CAC registration not complete, so no legal name or RC number on the site.

## Where we stopped

### Isaac
Review the handoff prototype and decide whether to port it into the CompanyWebsite repo. The shared contact form is browser-checked at desktop and phone widths, but live submission is untested because there is no Formspree form ID. Its facts strip now loops automatically, pauses on hover/focus or with its control, and becomes static with reduced motion; desktop, phone and reduced-motion behavior were browser-checked. If retaining the form, create a Formspree form targeting hello@undeify.com, provide its ID, and confirm retention and data-transfer safeguards before enabling it publicly. The production repo is unchanged and not live. Updated the local prototype's `website/HomeSections.jsx`, `website/refine.css`, `website/site.css`, and root `README.md`.

### Tolu
Nothing yet. Confirm undeify.com is ours in Namecheap and that hello@ forwards to a founder inbox.

## Next steps
1. Isaac reviews the handoff prototype and decides whether to port it into CompanyWebsite.
2. If the form stays, Isaac creates a Formspree form for hello@undeify.com and provides its ID; confirm its privacy, retention and transfer settings before public use.
3. Deploy the selected version to Cloudflare Pages and point undeify.com at it (Isaac).
4. Confirm hello@undeify.com forwarding (Tolu).
5. Send the full-size originals of the ChatGPT scene images to replace the soft crops (Isaac).
6. Founders approve or change the "Junior's call" decisions in the repo's `docs/decisions.md`.
7. After CAC registration: add the registered name and RC number to the About section and privacy notice.
