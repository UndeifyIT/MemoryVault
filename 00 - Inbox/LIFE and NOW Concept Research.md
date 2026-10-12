---
status: idea
project: meta
type: plan
author: junior
created: 2026-10-13
updated: 2026-10-13
---
# LIFE and NOW Concept Research

This note is a background check, competitor teardown and validation plan for Isaac's two consumer ideas: LIFE, a personal memory layer, and NOW, a place-first social network. Verdict: neither should be built as briefed. Each has one narrow version worth a zero-code test. Unverified until tested.

> Draft, not confirmed. These are research findings and a recommendation. Nothing here is decided until Isaac or [[Tolu]] says "lock it".

**Sources and confidence.**
- Five research agents ran on 2026-10-13. Every claim below was tagged verified, inference or hypothesis. Main source links are listed at the end.
- Each agent ran out of web-search budget before finishing. The gaps are listed in "What we didn't verify".
- We did not infer success from funding announcements, websites or app-store listings.

## 1. Verdict in one screen

| | LIFE (memory layer) | NOW (place-first social) |
|---|---|---|
| Has it been done? | Yes, by the platforms, and shipped in 2026: Apple Siri AI with personal context (Sep 2026), Google Gemini Personal Intelligence (global, but **Nigeria excluded**), Pixel Screenshots, and Nothing Essential Space (capture, then understand, then act). Free open-source tools already cover capture: Karakeep (29.6k GitHub stars), Linkwarden, Khoj, Memos. | Yes, many times, and it mostly failed outside China: Dodgeball, Gowalla (2023 relaunch paused after about 6 weeks), Facebook Places (6% tried it), Nearby Friends (killed for low usage), Foursquare consumer (shut Dec 2024), Zenly (killed despite about 15M daily users). Corner, the closest live analog, has 250K registered users after 4 years. |
| What survived | Nothing standalone at scale. Pocket shut (2025). Humane, Dot and Rewind/Limitless died or were absorbed by big tech. Evernote was squeezed by its new owner. | **Beli**: one category (restaurants), a solo ritual (rank each meal), friend comparison. 120M+ ratings with about 10 staff. Plus Asian incumbents (Xiaohongshu, Amap Street Stars, Tabelog). |
| In Nigeria | No African memory startup found. Nafini is a WhatsApp reminders assistant with no traction disclosed. Gemini PI and Pixel are not available here; Apple is about 9% of phones. | No place-social competitor found. Every standalone discovery or directory app stalled (VConnect, Mocality, Ofadaa, Tomachy). Survivors attach to a transaction: Chowdeck (1M+ orders a month), Tix (₦2B tickets in 2023). |
| Biggest killer | Platforms copy it. **Meta banned AI-first bots on the WhatsApp Business API from 15 Jan 2026, with no Nigeria exemption.** Android limits automatic capture. | Cold start (an empty map), plus fewer than 5% of users ever posting content. |
| Real gap | Android-first, WhatsApp-heavy users on cheap Tecno/Infinix phones with expensive data. Nobody turns *their* information (job flyers, transfer receipts, Pidgin voice notes, school deadlines) into reminders. | Trust: Lagos discovery runs on paid influencers who often don't disclose payment (BusinessDay, Jul 2026). Nobody shows "what real visitors saw this week". Instagram Map, TikTok Nearby/GO and Google Ask Maps are not confirmed in Nigeria. |
| How long the gap lasts | 12–24 months (hypothesis). It closes the day Google lifts Nigeria's Gemini exclusion or Transsion copies Essential Space. | 12–24 months (hypothesis), and only a dense local network makes it defensible. |
| Moat if it works | Weak: local trust plus local content understanding. | Real but conditional: a dense, fresh, trusted local graph of places, visits and friends. |

**Junior's pick, if only one: NOW, cut down to "Beli for Lagos".**
- It is the only one of the two with a real moat.
- Its path to money is proven locally: venues already pay creators, and ticketing takes fees.
- LIFE is quicker to prove but turns into a platform feature.

**Caveat on timing:** today the ShiftOS Critical (C1) is still open and the DPCO sprint started 13 Oct. See section 7.

## 2. LIFE: findings

**What the competitors already do (late 2026)**
- **Apple Siri AI**, released 14 Sep 2026 in beta, in English. It searches Messages, Mail and Photos, and acts in Reminders and Calendar. iPhone 15 Pro or newer only.
- **Gemini Personal Intelligence** answers from Gmail, Photos and Search. Paid tiers went global on 14 Apr 2026. Its FAQ (checked 13 Oct 2026) excludes the EEA, UK, Switzerland and **Nigeria**. South Africa has it.
- **Pixel Screenshots / Magic Cue** index screenshots on the device and turn them into calendar events. Pixel phones are not officially sold in Nigeria.
- **Nothing Essential Space** is the closest product to LIFE. A hardware key captures a screenshot or voice note; since Mar 2026 it suggests action items, detects events and does semantic search. Nothing phones only.
- **ChatGPT**: memory and Gmail/Calendar connectors on paid plans. Pulse is for the Pro plan. It has no inbox for things you save; it remembers what you said in chat. ChatGPT Go costs ₦7,000/month in Nigeria. It is the platform most likely to add a "save to ChatGPT" feature.
- **Transsion (Tecno/Infinix/itel, about 51% of Nigerian phones)** has EllaClaw in closed beta: an agent that remembers habits and acts across apps. **The most underrated threat**, and also a possible partner.
- **Samsung Now Brief** (flagships, about 12% of the Nigerian market) is a proactive briefing, not a capture tool.
- **Paid PKM tools** (personal knowledge management: Mem, Saner, mymind, Fabric, Readwise, Raindrop) cost $3–$20+ a month in USD and are built for Western desktops. Mem keeps changing its pricing.

**Demand evidence**
- The pain is plausible but **not quantified anywhere, and not at all for Nigeria**:
  - Old Pocket data: 10–44% of saved items were ever opened.
  - Vendor surveys: 55% of camera-roll photos go unseen for a year.
  - A study of 892 students found people remember screenshotted information *worse* than information they only viewed.
- Some widely shared statistics have no source. Do not cite "62% of Instagram saves never revisited" or "82% of Pocket saves never read".
- Willingness to pay in Nigeria:
  - Benchmarks: Spotify ₦1,600, YouTube Premium ₦1,700, Netflix Mobile ₦2,500 per month.
  - Realistic ceiling for LIFE: about **₦1,000–2,500 a month (under $2)**.
  - At roughly 4% conversion (Notion's estimated rate), "free" only works with on-device or very cheap AI, because model costs are billed in dollars.

**Platform limits that shape the product**
- **WhatsApp Business API**: AI-first assistants have been banned since 15 Jan 2026. Italy, the EEA and Brazil are exempt after regulators intervened; Nigeria is not. A "forward it to the LIFE bot" product would probably be shut off.
- **Android**:
  - AccessibilityService excludes "assistants", so screen-scraping risks a Google Play takedown.
  - Broad photo access has needed justification since May 2025.
  - The safe capture route is the **share sheet**, plus the photo picker.
- **Instagram links**: since Nov 2025 Meta's oEmbed returns no thumbnail or author, so a saved Instagram link has almost nothing to index without a screenshot.
- **Phones and data**: Android is about 82% of Nigerian phones, mostly 3–4 GB RAM Transsion devices. Data costs about ₦430–640 per GB, so compress on the device and offer Wi-Fi-only sync.

**Narrow version worth testing: "Catch it before it's gone"**
- An Android share-sheet app for **job seekers and students**.
- The user shares a WhatsApp job flyer, screenshot, PDF or voice note.
- The app reads the text **on the device** (Google ML Kit OCR, free, offline) and pulls out the deadline, requirements, link and contact.
- It proposes a reminder for the user to approve, then answers "which vacancies close this week?" with the original item attached.
- Single-player value on day one. No integrations, no cold start.

## 3. NOW: findings

**What the competitors already do**
- **Snap Map**:
  - 400M+ monthly map users.
  - Paid "Promoted Places".
  - Since Apr 2026, "Place Loyalty" badges built from passive location data. That already delivers NOW's "verified visit" idea, for free.
  - Snapchat has about 20–23M users in Nigeria.
- **Instagram Map**: US Aug 2025, India Oct 2025. Drew a stalking backlash and letters from 37 US attorneys general. Meta has published no usage figures. Not confirmed in Nigeria.
- **Google Maps**:
  - 2B+ monthly users.
  - Local Guides produce 70–75% of user content.
  - Ask Maps (Gemini) is US and India only.
  - It is not a social feed. NOW should sit **on top of** it (link matching, directions), not compete with it.
- **TikTok**: Nearby feed (UK, FR, IT, DE since Dec 2025) and **TikTok GO** for in-app booking (ID, US, JP). TikTok is heading straight for "see it, then book it". Not in Nigeria yet.
- **Beli**: pairwise ranking ("better or worse than X?") produces a 1–10 score; personal guides unlock after 30 ratings. Ratings doubled in about 15 months. No published MAU or revenue.
- **Go There and similar indie apps** already turn TikTok/IG/YouTube links into a map. **Import alone is a commodity.**
- **Asia**:
  - Xiaohongshu shows place discovery is won by *a content platform with search*, not by a map.
  - Amap Street Stars (400M users in a month, Sep 2025) shows passive visit data beats written reviews when an incumbent owns the data.

**Nigeria evidence**
- **Who reaches people:**
  - Instagram reaches only about 10M Nigerians, so it is an elite Lagos/Abuja channel.
  - TikTok and Snapchat reach far more.
  - Food critic Opeyemi Famakin (1.2M Instagram followers) moves opinion.
  - Curator pages exist: EatDrinkLagos; Lagos Weekender sells a ₦10,000 guide.
- **Where venues are:** 14 of Lagos Weekender's 15 new venues for Sep–Dec 2025 are in **VI or Lekki Phase 1**.
- **Money:**
  - Venues pay creators per post (nano about ₦84K–421K; micro up to about ₦2.5M; estimates conflict).
  - Tix takes about 5% plus a per-ticket fee.
  - Booking commissions (Reisty, MoreTables) are unproven.
- **Data cost:** a video-first map feed costs students real money. Use thumbnails, tap-to-play and low-bitrate video.
- **Safety:** we found no direct case of people being targeted from venue posts, but fear of kidnapping and of showing wealth is high. Defaults:
  - post *about* a place, never "I'm here now"
  - publish with a delay
  - no live location for individuals
  - no home or hostel pins
  - aggregate counts only
- **Free place data:**
  - Foursquare Open Source Places: 100M+ places, Apache 2.0, free for commercial use.
  - Overture Places.
  - Avoid basing the core database on OpenStreetMap: its share-alike licence (ODbL) conflicts with any future proprietary data business.
  - **Lagos coverage of these datasets is unverified. Check it first.**

**Narrow version worth testing: "Beli for Lagos" in one zone**
- **Where and what:** food, lounges and bars in Lekki Phase 1 and VI. That is where venues spend and where new openings cluster.
  - Option: UNILAG/Yaba. Denser, but students have little money, ASUU strikes can empty the campus, and some first-years are under 18.
- **The loop:**
  1. Save a place from a TikTok, IG or WhatsApp link.
  2. See which friends saved it too.
  3. Go.
  4. Rank it in one tap after the visit, with a short optional clip.
  5. The place page shows "what real visitors said this week", separate from paid posts.
- **Value before any social layer:** your own ranked list and personal guide.
- **Not in v1:** the map-as-feed, events, live activity.

## 4. Open source: what it does and doesn't fix

- **Open source is a distribution and trust tactic, not a business model.**
  - Every sustainable example has a patron or a business-to-business revenue line:
    - Signal: about $50M/yr in costs, funded by Brian Acton's loan.
    - Immich: funded by FUTO.
    - Mozilla: about 76% of revenue is search royalties.
    - Bitwarden: open-core with business-to-business revenue.
  - Omnivore (open source, free) ended as an acqui-hire.
- **"Free, monetise later" is the recipe that killed Zenly** and led to Evernote's squeeze. Decide the paid path before launch. Possible paths:
  - LIFE: a hosted pro tier, a phone-maker (OEM) partnership, or a diaspora payer.
  - NOW: venue tools, promoted placement (always labelled), or a ticketing or booking partnership (e.g. with Tix, rather than competing).
- **If we open-source:**
  - Licence: **AGPL** (copies run as a service must publish their code) plus a trademark policy plus a written governance document, from day one.
  - The CoMaps fork of Organic Maps (May 2025) happened over opaque governance and donations.
  - Keep the brand and the hosted service ours.
- **For LIFE, open source helps trust.** Local-first storage that can be exported and deleted is the answer to Humane and Pocket deleting their users' data. **For NOW, the moat is the data and the network, not the code.** Licence the data separately.

## 5. Security and legal (CISO view)

- **LIFE holds the highest-value data a breach could hit:** screenshots of bank transfers, IDs and other people's messages, including sensitive data and other people's data.
  - Under NDPA/GAID 2025 this is high-risk processing: a **data protection impact assessment (DPIA) before launch**, registration once past 200 users in 6 months, and breach reporting within 72 hours.
  - Sending content to US-hosted AI APIs is a cross-border transfer that needs a documented legal basis.
  - Default to processing on the device; send text only, never raw images, to the server; encrypt at rest; one-tap export and delete.
- **NOW: location data is personal data.**
  - Use the safety defaults in section 3.
  - Run a DPIA, since we assume it counts as "systematic monitoring".
  - On campuses, treat users as possible minors (anyone under 18 counts as a child under Nigerian law).
  - Instagram Map shows that even Meta gets burned by a map with location sharing; Path paid an FTC fine.
- **Enforcement is real:** the NDPC has fined Fidelity Bank ₦555.8M and Multichoice ₦766.2M.
- **Self-hosted forks** of open-source code will mishandle data under our name unless the trademark policy stops them using it.

## 6. Scores (1–5; E = backed by evidence, H = our hypothesis)

| Dimension | LIFE (narrow) | NOW (narrow) |
|---|---|---|
| Severity and frequency of the problem | 3 H (plausible, unmeasured) | 3 E (influencer trust gap; weekly eating out) |
| Value on first use | 4 H (works solo, day one) | 3 H (needs seeded places) |
| Habit potential | 2 H (event-driven, not daily) | 4 E (Beli's ritual works weekly) |
| Organic sharing | 2 H (private by nature) | 4 E (Beli about 80% referrals) |
| Retention | 2 E (Pocket and Dot died; saves decay) | 3 E/H (Beli yes; most place apps no) |
| Willingness to pay or other revenue | 2 E (under $2/month; dollar AI costs) | 3 E (venues pay creators; ticket fees) |
| Competitive intensity (5 = low) | 1 E (Apple, Google, Nothing, Transsion, open source) | 3 E (incumbent features not yet in Nigeria) |
| Network effects | 1 E (none) | 4 H (local density, if it ever forms) |
| Technical feasibility for 2 people | 4 E (commodity pipeline) | 3 H (media, moderation, seeding) |
| Privacy and trust burden (5 = light) | 1 E (sensitive data and third parties) | 2 E (location safety) |
| Cost to acquire users | 3 H | 2 H (must seed a whole zone) |
| Global expansion | 2 H (platforms own rich markets) | 3 H (repeat city by city) |

These numbers are not added up on purpose. Several are hypotheses, and the 2-week tests below replace them with data.

## 7. What to do next: zero-code tests, 2 weeks each

**Timing first.** The ShiftOS Critical (C1) has been open since 28 Sep. The DPCO pack is due 19 Oct and its calls run until the 30 Nov gate. Lingora's validation sprint is waiting on a start date. Recommendation:
- Run no code on LIFE or NOW before the DPCO gate on 30 Nov.
- Only the cheap tests below, and only if Isaac takes something else off the list.

**NOW test (concierge, Lekki/VI):**
- Recruit 30–50 people who eat or go out weekly.
- They log each visit through a 3-button form: liked / fine / disliked, plus "better than X?".
- Every Friday we send a WhatsApp digest, "what real visitors said this week", from a human-run number. Do not use the Business API bot.
- Also:
  - Download the Foursquare Open Source Places data for Lekki and count its venues against a walk of 2 streets.
  - Interview 10 venue owners: would they pay for verified-visitor insight?
- **Continue if:** at least 40% still log a visit in week 4, and at least 30% say the digest changed where they went (hypothesis thresholds).
- **Kill if:** under 25% log in week 4.

**LIFE test (diary study plus concierge):**
- 20–30 job seekers and students.
- Week 1: they count every "where was that?" moment, missed deadline and saved screenshot.
- Week 2: they send items to a human-run inbox, and we manually create reminders and answer their questions.
- **Continue if:** at least 2 retrieval or reminder requests per user per week, and at least half of the reminders are acted on.
- **Kill if:** below that, or if people won't share the screenshots.

## 8. What we didn't verify

- How many Lagos venues the Foursquare and Overture datasets actually contain (the most important gap for NOW).
- Swarm's current usage; why the 2023 Gowalla relaunch stopped.
- Whether Ask Photos, Meta AI memory and Instagram Map are live in Nigeria.
- Whether Nothing and Pixel phones are sold in Nigeria through grey-market channels.
- Notion AI, Tana, Capacities, Reflect, Sunsama and Motion: no fresh check.
- Luma, Pinterest places, Roamr, Thoughtly, Hapn, Spots, Whisp: not found.
- Current student smartphone data; how campus apps have fared.
- Google Play's NotificationListener policy; WhatsApp's terms for unofficial clients.
- Tix figures for 2024–26.

## Key sources

- WhatsApp AI-chatbot policy:
  - https://respond.io/blog/whatsapp-chatbot-policy-2026
  - https://techcrunch.com/2025/12/24/italy-tells-meta-to-suspend-its-policy-that-bans-rival-ai-chatbots-from-whatsapp/
- Gemini Personal Intelligence regions: https://gemini.google/overview/personalization/ (checked 2026-10-13)
- Siri AI: https://www.apple.com/newsroom/2026/09/siri-ai-a-profoundly-more-capable-and-personal-assistant-is-here/
- Nothing Essential Space: https://9to5google.com/2026/03/13/nothing-essential-space-event-detection-search-update/
- Tecno EllaClaw: https://propakistani.pk/2026/06/24/tecnos-new-ai-agent-can-save-battery-and-reduce-mobile-data-use/
- Nigerian phone brands: https://intelpoint.co/insights/tecno-has-the-highest-share-among-phone-brands-in-nigeria-at-23-55-as-of-february-2025/
- ChatGPT Go in Nigeria: https://techcabal.com/2025/10/23/openai-brings-chatgpts-cheapest-plan-to-nigeria-kenya-south-africa/
- Android accessibility policy: https://support.google.com/googleplay/android-developer/answer/10964491
- Snap Map:
  - https://newsroom.snap.com/2025-snap-map-mau
  - https://techcrunch.com/2026/04/22/snap-maps-new-place-loyalty-badges-will-show-the-spots-you-visit-most-often/
- Beli: https://www.bostonglobe.com/2026/08/04/lifestyle/beli-restaurant-rating-app/
- Corner: https://dnyuz.com/2026/07/21/a-startup-building-a-map-to-help-you-make-plans-with-friends-has-doubled-its-funding/
- TikTok GO: https://newsroom.tiktok.com/introducing-tiktok-go
- Amap Street Stars: https://www.alibabagroup.com/document-1910786468402429952
- Chowdeck: https://techcabal.com/2025/11/03/chowdeck-crosses-one-million-monthly-orders-in-nigeria/
- Tix: https://techcabal.com/2024/07/22/tix-africa-crossed-%e2%82%a62-billion-tickets/
- Influencer trust gap: https://businessday.ng/?p=1166497
- New Lagos venues: https://thelagosweekender.com/15-new-restaurants-and-lounges-sep-dec-2025/
- Foursquare Open Source Places: https://foursquare.com/resources/blog/products/foursquare-open-source-places-a-new-foundational-dataset-for-the-geospatial-community/
- Nigerian data and app prices:
  - https://techcabal.com/2026/02/09/how-nigerians-spent-%E2%82%A620-87billion-daily-on-data-in-2025/
  - https://nairametrics.com/2025/06/04/netflix-hikes-subscription-prices-in-nigeria-again-premium-plan-now-n8500/
- Pocket shutdown: https://techcrunch.com/2025/05/27/read-it-later-app-pocket-is-shutting-down-here-are-the-best-alternatives
- Zenly: https://restofworld.org/2022/fearing-competition-snap-decided-to-shut-down-zenly-rather-than-sell-it/
- Gowalla: https://en.wikipedia.org/wiki/Gowalla
- Organic Maps / CoMaps fork: https://alternativeto.net/news/2025/5/organic-maps-contributors-fork-project-as-concerns-over-governance-and-transparency-grow/
- Immich: https://linuxiac.com/immich-team-goes-full-time/
- Instagram Map backlash: https://www.dailylobo.com/article/2025/08/new-instagram-map-feature-draws-backlash-from-attorneys-general-legislators-and-users
- NDPA overview: https://www.dlapiperdataprotection.com/?c=NG&t=law

## Change log
- 2026-10-13, Junior for Isaac: first version, from five research agents.
