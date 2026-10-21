---
status: active
project: website
type: reference
author: junior
created: 2026-10-16
updated: 2026-10-21
---
# Undeify Website Architecture

- **Repo:** https://github.com/UndeifyLTD/CompanyWebsite (private, current worktree branch `agents/website-cleanup-and-analysis`; based on `e8e453d`, matching `origin/main` before local edits).
- **Stack:** React 18.3.1 and ReactDOM are self-hosted under `site/assets/vendor/`. JSX is compiled by pinned Babel dependencies at build time; visitors do not load Babel. Fonts are self-hosted. No runtime compilation, `unsafe-eval` or `unsafe-inline`.
- **Build and structure:** run `npm ci`, `npm run build`, then `npm start` to preview at `http://127.0.0.1:5174/`. `site/src/*.jsx` and `site/src/index.template.html` are sources; `tools/build_site.mjs` compiles them and writes five page shells plus `site/assets/app.js` and local React runtime files. `site/` is the deployment output. The obsolete `tools/build_docs.py` and vanilla `site/assets/site.js` were removed.
- **Routing:** Home, About, Privacy, Terms and Contact have static direct URLs (`/`, `/about.html`, `/privacy.html`, `/terms.html`, `/contact.html`) and React history navigation. Page titles, descriptions, canonical URLs and social metadata are unique per page.
- **Motion:** the home facts ticker loops continuously; reduced-motion preference disables the animation. Reveal effects run on route changes and include a no-observer fallback.
- **Hosting:** existing deployment configuration is Vercel with `site/` as output. No deployment was performed. Keep existing protective response headers; CSP permits only same-origin assets plus Google Analytics after consent and the Vercel analytics endpoint. Vercel Web Analytics is skipped on localhost.
- **Domain and email:** undeify.com, Namecheap nameservers and Namecheap email forwarding (MX checked 2026-10-16). Credentials are in the Namecheap account; who holds it: Tolu.
- **Data:** `site/assets/consent.js` keeps Google Analytics behind explicit consent in local storage; Cookie settings can reopen the choice, and withdrawal disables analytics and clears GA cookies. The consent card is normal-flow content after the home hero, not fixed to the viewport, and follows production's responsive lower-left card treatment. Vercel Web Analytics is cookie-free and loads on the deployed site. Contact remains disabled until a Formspree ID and privacy, retention and transfer settings are approved. Privacy copy documents actual behavior.
- **Removed surface:** the Security page and `site/.well-known/security.txt` are removed; the build cleans those exact stale outputs. Protective HTTP security headers remain.
- **Dependencies:** React/ReactDOM 18.3.1, Babel core 7.29.7 and preset-react 7.28.5 are pinned in the lockfile; last `npm audit` reported zero vulnerabilities.
