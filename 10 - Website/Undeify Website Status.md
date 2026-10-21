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
- **Stage:** The handoff prototype is now built into the CompanyWebsite worktree as a self-hosted React app with JSX precompiled at build time. It was tested locally; production has not been deployed, and deployment is not authorized.
- **What works:** Home, About, Privacy, Terms and Contact direct URLs; browser history navigation; the uninterrupted facts ticker; responsive header and layouts; local fonts, logo and icons; opt-in Google Analytics consent and Cookie settings. The consent card now matches production's lower-left normal-flow placement and styling, remains until a choice, and is removed after Accept or Decline. Vercel Web Analytics loads on Vercel hosts; privacy metadata/copy is updated. The Security page and `security.txt` are removed while protective response headers remain. Formspree is blank, so the form is disabled and gives a direct-email fallback. Browser-checked at 1440, 768 and 390px, including consent accept/decline/withdrawal, reduced motion, navigation, form fail-closed state, and no horizontal overflow.
- **Build and security checks:** `npm ci`, `npm run build`, JavaScript syntax checks and `npm audit` pass; npm reports zero known vulnerabilities. The initial replacement review found no vulnerabilities in its scope; the later consent-placement change was directly inspected, and its delegated reviewer could not access the separate CompanyWebsite worktree.
- **Figma:** https://www.figma.com/design/Hwsdaunvh7t4BMdTTnmM9U holds the dropped first design only.
- **Known issues:** the hero scenes are upscaled from the low-resolution ChatGPT collage and look soft on big screens; hello@undeify.com forwarding not confirmed; no street address or hours on the site yet (Apple may ask); CAC registration not complete, so no legal name or RC number on the site.

## Where we stopped

### Isaac
The `CompanyWebsite` worktree is on the pushed `isaac-revision` branch, based on `e8e453d`, with the local replacement committed as `8b6341e`. The branch is available for review; it is not merged or deployed. The app source is in `site/src/`; `npm run build` compiles JSX and writes five static page shells (`index.html`, `about.html`, `privacy.html`, `terms.html`, `contact.html`) plus the self-hosted React runtime. The local preview server is running at `http://127.0.0.1:5174/`. To reproduce: `npm ci`, `npm run build`, then `npm start`. Direct URLs and browser history work; the consent card is non-fixed and inserted after the home hero, matching production's 400px desktop / responsive mobile card; it stays until Accept or Decline. Google Analytics loads only after explicit acceptance, Vercel analytics is skipped on localhost and loads on Undeify/Vercel hosts, and the Formspree submit control remains disabled. CSP has no `unsafe-eval` or `unsafe-inline`; protective response headers are retained. The Security page and `security.txt` return 404. Next: Isaac reviews the branch and separately authorizes any deployment. Before enabling form submission, supply and review the Formspree ID and provider privacy, retention and transfer settings.

### Tolu
Nothing yet. Confirm undeify.com is ours in Namecheap and that hello@ forwards to a founder inbox.

## Next steps
0. **Pre-merge review (2026-10-21, design-critique + jaredrhod-marketing on `isaac-revision` 8b6341e):** blockers before merge: confirm hello@ forwarding (every CTA ends there); verify or soften "ShiftOS running in production" and the NDPA 2023 badge; fix the About page's "use our contact form" while the form is disabled; CSP `form-action 'none'` must allow Formspree when enabled; test GA under COEP on a Vercel preview. Then: benefit headline instead of "Our Own Software", a NOW beta waitlist as the main CTA, drop the "This website" shipped tile and the duplicate About button. Waiting for Isaac to pick fixes.
1. Isaac separately authorizes deployment before anyone deploys or pushes this replacement.
2. Confirm `hello@undeify.com` forwarding (Tolu); before enabling submissions, supply a Formspree ID and review its privacy, retention and transfer settings (Isaac).
3. Send the full-size originals of the hero scene images (Isaac) if they are still wanted; current images are soft when enlarged.
4. Founders approve or change remaining "Junior's call" decisions in `docs/decisions.md`.
5. After CAC registration, add the registered name and RC number to About and Privacy.
