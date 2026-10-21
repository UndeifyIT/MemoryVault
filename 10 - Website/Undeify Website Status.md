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
- **Stage:** Isaac selected the handoff prototype to replace the production site's interface, with a precompiled React app, preserved production consent/analytics, and local testing before any deployment. No deployment is authorized.
- **What works:** home page with the pinned scroll hero (night room → frame swings into a window in 3D → sunrise → daylight rises), intro, product folders (NOW, ShiftOS, a Yorùbá app "in research"), about, contact, footer; privacy notice, terms, security page, security.txt, strict security headers. Checked with the taste-skill lint and browser inspector at 1440, 768 and 390px: 0 fails, 2 defended warnings (no video; hero text sits on the night picture's dark space by design).
- **Production port in progress:** React source files, prototype CSS, logo and icons have been copied into CompanyWebsite. The production app shell, build pipeline, routing, consent/analytics integration and accurate privacy copy are not implemented yet. The Formspree ID remains blank; the form must continue to fail closed with a direct-email fallback.
- **Figma:** https://www.figma.com/design/Hwsdaunvh7t4BMdTTnmM9U holds the dropped first design only.
- **Known issues:** the hero scenes are upscaled from the low-resolution ChatGPT collage and look soft on big screens; hello@undeify.com forwarding not confirmed; no street address or hours on the site yet (Apple may ask); CAC registration not complete, so no legal name or RC number on the site.

## Where we stopped

### Isaac
The `CompanyWebsite` worktree is on `agents/website-cleanup-and-analysis`, at `e8e453d`, matching `origin/main` before local edits. Prototype React components, styles, `logo-mark.svg` and ten icons are now copied into `site/src/` and `site/assets/`; `site/assets/site.css` has been replaced with the prototype stylesheet. No app entry, build script, URL routing, consent/analytics integration, privacy rewrite, or Security page removal has been completed. The next action is to finish the production app and run it locally. Keep Vercel Analytics and opt-in GA consent; remove the Security page and `security.txt` but retain protective response headers. JSX must be compiled before visitors load the site; no runtime Babel or `unsafe-eval`. Do not deploy. The shared Formspree form is still deliberately unconfigured, so do not claim it submits.

### Tolu
Nothing yet. Confirm undeify.com is ours in Namecheap and that hello@ forwards to a founder inbox.

## Next steps
1. Finish the precompiled React app and route direct requests to Home, About, Privacy, Terms and Contact.
2. Integrate the existing consent controls and opt-in Google Analytics with the React app; retain Vercel Analytics.
3. Update the Privacy notice to accurately describe analytics, consent and the unconfigured contact form.
4. Remove the production Security page and `security.txt`, while preserving protective HTTP headers.
5. Build and test locally, including direct links, navigation, consent choices, reduced motion and form fallback. Do not deploy without separate authorization.
6. Confirm `hello@undeify.com` forwarding (Tolu); obtain and review a real Formspree endpoint only before enabling submissions.
7. Founders approve or change the remaining "Junior's call" decisions in `docs/decisions.md`; after CAC registration, add the registered name and RC number to About and Privacy.
