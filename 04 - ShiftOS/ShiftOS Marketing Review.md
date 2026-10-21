---
status: active
project: shiftos
type: reference
author: junior
created: 2026-09-28
updated: 2026-10-21
---
# ShiftOS Marketing Review

Junior's evaluation of the ShiftOS marketing site and funnel against the `jaredrhod-marketing` playbook: the site looks finished but can't capture a single lead yet, and the brand name and contact domain belong to other companies.

> Locked by Isaac, 2026-10-21. Findings verified against repo `main` at `1defe67` and live DNS/HTTP on 2026-09-28. Pricing and the name are still Isaac's to decide.

## Verdict
Don't send traffic to the site yet. Marketing amplifies what's there, and right now it would amplify lost leads, a name we don't own, and security claims the audit contradicts. Fix the P0 list first (about a week of work), then start the organic engine.

## P0: blocks any marketing
1. **The name and contact domain belong to others.** `shiftos.app` serves "ShiftOS: Sim Racing Venue Software" and has its own mail server, yet the site, onboarding and invite pages send people to `hello@shiftos.app`, and the privacy policy sends data requests to `privacy@shiftos.app`. Every prospect email and every privacy request goes to a stranger. `shiftos.com` redirects to works.ai (Trusted Works, health-system staffing and scheduling), and the hero mockups show `app.shiftos.com`. Ownership not checked by WHOIS; what the domains serve was checked. Unverified: whether "ShiftOS" is trademarked by anyone.
2. **The demo form is fake.** `apps/web/src/pages/marketing/DemoPage.tsx`: submit waits 900 ms and shows "Request received, we'll confirm within one business day". Nothing is sent or stored.
3. **The newsletter form is fake.** `apps/web/src/marketing/MarketingFooter.tsx`: submit sets "you're on the list" and discards the email.
4. **Security claims ahead of reality.** The pricing FAQ says org data is isolated while audit C1 (invitation takeover) is open; the privacy page says support access is logged while audit H7 says nothing is logged. Open signup plus no Shifty cost caps (H5) means marketing traffic also means an OpenAI bill.

## Offer and pricing
- The pricing page (Starter ₦0 up to 15 staff; Professional ₦12,000/month with unlimited staff and branches) contradicts the repo's own strategy doc `docs/product-foundation/PF-012-PRICING-STRATEGY.md` (Starter ₦15,000 for 25 staff; Growth ₦45,000 for 100; it rejects flat unlimited pricing). The page's paid tier costs less than the doc's entry tier. Needs a decision.
- No payment provider (Paystack, Flutterwave, Stripe) and no plan-limit enforcement found in the code, so the trial, the 15-staff cap and the prices can't be enforced yet.
- A free plan and a 30-day trial side by side blur the offer. No guarantee, no tripwire, no profit maximizer.

## Copy
- The headline "Run every shift from one screen" describes the product. It fails the "so what?" test and picks neither fear nor gain.
- The page is features-first (feature grid, role cards) with no story, no proof and no "what's in it for me". The code comment says the copy was ported verbatim from a design handoff, not written from customer research.
- The audience is too broad: "retail" in the badge and pricing, "your store" in features, eight industries in the strip, including factories and hotels.
- Zero proof: no testimonials or customers ("Case studies are coming", which is honest). Em-dashes throughout.
- The best copy material is already in `docs/product-foundation/PF-008-CUSTOMER-PERSONAS.md`, in the owner's own words: "I don't know what is happening across my branches", "I depend too much on individual managers".

## Funnel (Content, Lead Magnet, Tripwire, Core, Profit Maximizer)
- **Content:** none. Resources lists eight article titles whose links go to `#`; all four social icons go to `#`.
- **Lead magnet:** only "Stay updated", which is the playbook's textbook bad example. The no-card trial is a valid lead magnet but untracked.
- **Email or WhatsApp list:** no autoresponder, no list.
- **Analytics:** none. No analytics script, no per-page titles (one title for every route), no robots.txt or sitemap. Canonical is `shiftos-web.vercel.app`.

## Recommended order
1. Decide the name: keep ShiftOS on a domain we control, or rename now while it costs nothing.
2. Wire the demo and newsletter forms to a real store, with a bot check and rate limit; replace every `shiftos.app` and `shiftos.com` reference.
3. Decide pricing and make the page match what the code enforces.
4. Add free analytics.
5. Rewrite the hero around one segment (multi-branch supermarkets and pharmacies) and one feeling (knowing what's happening at every branch without calling managers).
6. Build one specific lead magnet (a free weekly rota template for supermarkets) and a WhatsApp-plus-email list.
7. Run 3 to 5 free pilots in exchange for honest feedback, to earn the first real testimonials.

## Sources
Read whole: `LandingPage.tsx`, `PricingPage.tsx`, `DemoPage.tsx`, `MarketingFooter.tsx`, `apps/web/index.html`. Copy strings only: Features, Solutions, Resources, About, Legal pages. Sections read: PF-007 (first 90 lines), PF-008 (Persona 1), PF-012 (up to the Growth plan). Not read: PF-010 beyond a keyword search, the mobile app.

## Related
- [[ShiftOS]]
- [[ShiftOS Status]]
- [[Marketing Hub]]
- [[Low-Budget Marketing Plan]]
