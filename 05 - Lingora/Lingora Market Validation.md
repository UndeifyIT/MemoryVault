---
status: active
project: lingora
type: reference
author: junior
created: 2026-10-05
updated: 2026-10-12
---
# Lingora Market Validation

Findings of the 2026-10-05 market validation of Lingora (pan-African heritage-language app, Yorùbá first; repo https://github.com/UndeifyIT/Lingora): feasible as a bootstrapped, family-first studio that adds languages only when evidence says so; not a fast-growth platform.

## Scope (Isaac, 2026-10-05)
- All African languages, Yorùbá first; English UI only for now. Bootstrapping, no raise planned. No traction yet; waitlist and socials planned after the research. Existing partnership with Spitch AI (speech API).
- Buyers named: diaspora parents, diaspora adults, Africans at home, non-Africans. Revenue: freemium, family plan, B2B (Nigerian private schools; churches/mosques). Pricing undecided.

## Pan-African findings (checked 2026-10-05)
- Every roadmap language already has 2–3 competitors (Memrise, Ling, NKENNE, Dialogue Africa, Duolingo free for Swahili and Zulu). None is family/kids-first; that is the open lane.
- Recommended order (pushback on Isaac's plan): Yorùbá → gate → Igbo → Twi → Amharic or Somali by waitlist demand; Hausa only for Nigeria/schools; Swahili and Zulu last. Reason: UK language retention is ~8% for Nigerians, ~18% Ghanaians, ~35% Somalis, so non-speakers are concentrated in Nigerian and Ghanaian heritage.
- Model v4 (critic-checked): Yorùbá-only phase ≈ $2K–$153K a year (base $26K ≈ ₦35M); six languages + some school sales at year 3+ ≈ $8K / $91K / $434K (base ≈ ₦124M). No costs gathered yet.
- Nigerian private schools: 91,252 schools / 13.7M pupils (UBEC 2022); South-West 3.38M pupils. Fit is weak: they teach Yorùbá to children who already speak it. Churches/mosques = distribution, not revenue.
- Spitch (docs): speech in/out for en, yo, ha, ig, am; tone marking Yorùbá only; STT $0.00042/s ≈ $0.025 per learner-minute → about $400–$3,000/month per 10K free users. Cap Speak in the free tier. No published accuracy figures. Twi has no Spitch or Google speech support.

- **Full report (private artifact):** https://claude.ai/artifact/1SBwmj3XAMTdJdn1fwukhh. Source HTML and data: `research/market-validation/` in the Lingora repo (committed in 5d9830a and cb4fd26; corrected 2026-10-12).
- **Method:** 23 claims, each attacked by a separate critic agent over three rounds; none survived unchanged, 21 amended, 2 cut to hypotheses. Sources: ONS Census 2021, US ACS 2019–2024, StatCan 2021, Duolingo FY2025 10-K, Google Play/iTunes data, Google Trends, competitor press. All checked 2026-10-05.

## Key facts (checked 2026-10-05)
- Duolingo has no Yorùbá course; its Zulu course has 717K learners, Swahili 665K. Memrise has a free 110+ lesson Yorùbá course with native video and an AI speaking partner.
- No Yorùbá-only learning app has passed ~100K lifetime Android installs (largest: Pronunciator 90,111). NKENNE (category leader): 180K active / 7K paid (Dec 2024), now pivoting to B2B language AI. Lingawa: tutoring from $10.50/lesson, $1.1M pre-seed.
- Diaspora: US Nigerian ancestry 858,236 (ACS 2024); UK Nigerian ethnicity 271,390 (2021); Canada Yorùbá origin 42,075 (2021). Nigeria has the highest search intensity but near-zero willingness to pay.
- Google Trends "learn yoruba" roughly flat 2022–2025 after Google's Jan 2022 sampling change; on par with "learn zulu". Do not cite "+98% growth"; it was a measurement artefact.
- Revenue model (sourced inputs, critic-accepted ranges): Yorùbá-only consumer app ≈ $2K–$153K a year, base $26K.
- Risks: 12+ apps already named "Lingora" on the App Store; prototype spells the first greeting two ways (Ẹ káàrọ̀ / Ẹ kààárọ̀), so native-linguist QA is a launch blocker; open Yorùbá speech recognition supports only word-match checks; N-ATLaS licence caps free use at 1,000 active users.

## Lesson
- Google Trends series crossing 1 Jan 2022 are not comparable (Google changed its sampling). Compare from 2022 onward only.
