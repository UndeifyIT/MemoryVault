---
status: active
project: website
type: reference
author: junior
created: 2026-10-16
updated: 2026-10-16
---
# Undeify Website Architecture

- **Repo:** https://github.com/UndeifyLTD/CompanyWebsite (private, `main`). Owned by the UndeifyLTD GitHub organisation, created by Isaac on 2026-10-15.
- **Stack:** static HTML and CSS, one small script (`site/assets/site.js`), no framework, no dependencies, no build step. One typeface, Boska from Fontshare, self-hosted.
- **Structure:** `site/` is what gets served. `docs/` holds decisions and tokens. `tools/` rebuilds the legal pages (`build_docs.py`), takes screenshots (`capture.mjs`) and exports screens to Figma (`figma_doc.py`, then `figma_flatten.mjs`). `design/source/` holds the AI reference collage and crops.
- **Motion:** the hero reads one number, `--p`, set from scroll; every move is CSS calculated from it. Reduced motion keeps only cross-fades. Without JavaScript the hero is one still screen.
- **Hosting (planned):** Cloudflare Pages, free plan, output directory `site`. Security headers in `site/_headers` (Content-Security-Policy allowing only our own files, HSTS, no framing).
- **Domain and email:** undeify.com, Namecheap nameservers and Namecheap email forwarding (MX checked 2026-10-16). Credentials are in the Namecheap account; who holds it: Tolu.
- **Data:** the site sets no cookies and runs no analytics or forms. Contact is `mailto:` only.
- **Copilot:** `.github/copilot-instructions.md` tells Copilot to build only from the repo's spec and never write copy, add dependencies or forms.
