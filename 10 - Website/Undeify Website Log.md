---
status: active
project: website
type: log
author: junior
created: 2026-10-16
---
# Undeify Website Log

2026-10-16 | isaac | Repo created in the UndeifyLTD organisation | 82b106c
2026-10-16 | isaac | Spec skeleton and Copilot instructions (Junior) | e7996b6
2026-10-16 | isaac | v1 site built by Junior: scroll hero, products, legal pages, security headers; screens exported to Figma | 1ed3a1e
2026-10-16 | isaac | Redesigned in Vercel's design language (Isaac dropped the first design); docs/DESIGN.md records what is and is not copied | 939fc6b
2026-10-16 | isaac | Home page matched to Vercel's layout on Isaac's instruction: hanging 3D crate hero, alternating feature sections, Recently shipped grid, About page | b71250c
2026-10-16 | isaac | Hero crate made front-on and fixed at screen centre like Vercel's; app-window and phone mockups for NOW and ShiftOS | aa0f799
2026-10-16 | isaac | Hanging crate removed from the hero on Isaac's call | 610946f
2026-10-20 | junior | Updated the separate handoff prototype with full Privacy and Terms pages, removed security and cookie-consent UI, added metadata, keyboard skip link and bundled brand assets; production repo untouched | local prototype
2026-10-20 | junior | Refined the handoff prototype header to match the supplied reference: 64px height, larger 24px logo mark, 36px left inset, tighter nav and 8px action gap; checked at desktop/tablet/phone widths | local prototype
2026-10-20 | junior | Added a shared [Formspree](https://formspree.io/) contact form for Email us and Contact, updated the privacy notice and setup notes; submissions remain blocked until a form ID is supplied | local prototype
2026-10-21 | junior | Made the local prototype facts strip a continuous, pausable slider with a static reduced-motion fallback; browser-checked desktop and phone layouts | local prototype
2026-10-21 | junior | Fixed the ticker's desktop end gap by repeating the facts four times and moving by one run-width; verified continuous coverage at desktop, tablet and phone widths | local prototype
2026-10-21 | junior | Removed the ticker pause control and desktop/phone preview toggle; verified uninterrupted motion on hover and responsive layouts. Production replacement/deployment remains unauthorized | local prototype
2026-10-21 | junior | Began the approved local production port by copying the prototype components, styles, logo and icons into CompanyWebsite; React app, build, consent integration and local testing remain unfinished; no deployment | CompanyWebsite `agents/website-cleanup-and-analysis`
2026-10-21 | junior | Completed the local React replacement with precompiled JSX, direct routes, consent/analytics integration, updated privacy copy, retained CSP/security headers, removed Security page/security.txt, and a disabled form; `npm ci`, build, browser checks and dependency audit pass; no deployment | CompanyWebsite `agents/website-cleanup-and-analysis` at `e8e453d`
2026-10-21 | junior | Matched the local cookie-choice card to production's normal-flow lower-left placement and responsive styling; verified build, syntax, route persistence, accept/decline dismissal, and 390px layout; local only | CompanyWebsite `agents/website-cleanup-and-analysis`
2026-10-21 | junior | Pushed the approved local replacement, including consent placement and footer copy, to `isaac-revision` for review; project worktree clean, no merge or deployment | CompanyWebsite
2026-10-21 | junior | Applied every pre-merge review fix on `isaac-revision` (decision W16): headline, NOW beta waitlist, shipped section and NDPA badge removed, click-open menus, CSP form-action for Formspree; tested locally | uncommitted
