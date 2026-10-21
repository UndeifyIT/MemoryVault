---
status: active
project: website
type: reference
author: junior
created: 2026-10-16
updated: 2026-10-21
---
# Undeify Website Architecture

- **Repo:** https://github.com/UndeifyLTD/CompanyWebsite (private, `main`). Owned by the UndeifyLTD GitHub organisation, created by Isaac on 2026-10-15.
- **Stack:** production port in progress. React UMD runtime is planned with JSX compiled at build time by a local Babel toolchain; no runtime Babel or `unsafe-eval`. Keep fonts self-hosted. No build pipeline has been wired yet.
- **Structure:** `site/` is what gets served. Prototype components and styles are being ported to `site/src/` and `site/assets/`. `docs/` holds decisions and tokens. `tools/build_docs.py` currently regenerates static legal pages and must be reconciled with the app routes so it cannot recreate the removed Security page. `tools/` also holds screenshots (`capture.mjs`) and Figma export utilities. `design/source/` holds the AI reference collage and crops.
- **Motion:** the hero reads one number, `--p`, set from scroll; every move is CSS calculated from it. Reduced motion keeps only cross-fades. Without JavaScript the hero is one still screen.
- **Hosting (planned):** Cloudflare Pages, free plan, output directory `site`. Keep security response headers and update CSP for the precompiled app and pinned React runtime; do not add `unsafe-eval` or `unsafe-inline`.
- **Domain and email:** undeify.com, Namecheap nameservers and Namecheap email forwarding (MX checked 2026-10-16). Credentials are in the Namecheap account; who holds it: Tolu.
- **Data:** preserve the existing cookie choice and opt-in Google Analytics behavior in `site/assets/consent.js`; retain Vercel Web Analytics. The prototype contact form remains fail-closed until its Formspree ID and privacy settings are approved. Privacy copy must describe actual behavior.
- **Routing and removal:** Home, About, Privacy, Terms and Contact must work as direct URLs and through browser history. Remove the Security page and `security.txt` as requested, while retaining protective HTTP headers.
- **Copilot:** `.github/copilot-instructions.md` contains existing repository guidance; review it before changing build/dependency conventions.
