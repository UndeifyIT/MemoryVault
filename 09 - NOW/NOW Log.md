---
status: active
project: now
type: log
author: junior
created: 2026-10-13
updated: 2026-10-13
---
# NOW Log

Append-only record of what changed in NOW, oldest first. One line per change. Each line: date | author | what changed | commit or PR.

2026-10-13 | junior | Background check on LIFE and NOW (5 research agents); Isaac dropped LIFE for NOW (0001, proposed) | vault c1d75e0
2026-10-13 | junior | Overture data check for Lekki/VI: 8,679 places, ~691 food and drink; 16/18 established venues present, 2/14 new openings | vault
2026-10-13 | junior | Content model, trust rule and launch zone recorded (0002, proposed); home-screen brainstorm with an agent, options A–D, D recommended, left for Tolu (0003, open) | Now facdd69
2026-10-13 | junior | Repo UndeifyIT/Now set up with research, decisions, place data and rebuild script; vault project folder created | Now facdd69
2026-10-13 | junior | ChatGPT market analysis reviewed; six points adopted into 0002, 0003 and a new test plan; Niibow found as the closest Lagos competitor | Now 867e69e
2026-10-13 | junior | Test plan pass marks locked by Isaac; Tolu may challenge before day 1; start date due from Isaac on 2026-10-14 | Now b2a03d1
2026-10-13 | junior | Reviewed Tolu's uncommitted "social discovery" brief (9 docs, generated 18:20) and 5 screenshots: "Kona" is Corner; brief conflicts with 0003 (map/feed home, in-app voting) and 0002 safety; privacy/SSRF/access-control and interview parts worth adopting; nothing applied yet | Now (uncommitted)
2026-10-13 | junior | Isaac approved the adopt list: brief filed under docs/research/external, review doc added, 0002 section 6 (privacy and access control, proposed), interviews added to the test plan, 0003 question for Tolu | Now dc899c5
2026-10-13 | junior | NOW mapped like Lingora: roadmap (17 stages), open questions (42, T1–T13 before day 1), legal action list (31 items) | Now (uncommitted)
2026-10-13 | junior | Seven gaps settled with Isaac: groups, voting and link pasting cut from the MVP (share link stays); two-step rating; test measures now share rate and visit rate; venue interviews back in; rating rules 0004 and working name 0005 proposed; roadmap, open questions and legal list committed | Now 9942ce6
2026-10-13 | junior | Tolu's proposal written as decision 0006 (NOW as a social map) and a private beta plan replacing the concierge test; waiting for Isaac | Now (uncommitted)
2026-10-13 | junior | Tolu settled the 1-hour post delay, private-until-checked new places and stack-before-beta; 0006 and the beta plan pushed | Now b8069e9
2026-10-13 | junior | Tolu: price per head optional on every post (range shown only once 3+ gave one; team seeds always include it); committed on the laptop at 00:05 on 14 Oct | Now 276291a
2026-10-14 | junior | Isaac accepted 0006 and the beta, NOW first and Lingora on hold; locked in the repo with the user walkthrough and following-and-friends rules; roadmap v2 | Now 824fe1b
2026-10-14 | junior | Isaac: Worth it / Mid / No kept over stars; Snapchat-style saved audience lists; comment controls and four visibility rules accepted; sign-in by Google/Apple/email open until Tolu decides | Now 970c93c
2026-10-14 | junior | Isaac accepted Junior's remaining walkthrough and following proposals (incl. follow limits); welcome screen left to Tolu | Now 92d8561
2026-10-14 | junior | SRS (101 FR, 46 NFR, 10 out of scope) and risk register (28 risks, 5 High) added to the repo | Now 26dc46c
2026-10-14 | junior | Secret-scan hook installed and tested on Isaac's clone; SRS and risk register reviewed (108 FR, 52 NFR; 33 NOW-only risks, 7 High; EXIF stripping and public-surface visibility added) | Now c9adc32
2026-10-14 | junior | Engineering and operations documents drafted (document register, threat model, data model, CONTRIBUTING and CODEOWNERS, analytics plan, test strategy, moderation playbook, seeding guide, incident runbook, tester pack); 6 security requirements added from the threat model | Now (uncommitted, waiting for Isaac)
2026-10-14 | junior | Risk register: every risk now linked to the SRS requirements that reduce it, or to its management action | Now (uncommitted)
2026-10-14 | junior | Decision 0007 low-cost seeding proposed by Isaac (waiting for Tolu); FR-POST-15 past visits and FR-TEAM-03 founding posters added; T3 moved to Tolu, T16 added | Now (uncommitted)
2026-10-14 | junior | Claude Code setup for the Now repo: CLAUDE.md, now-trace-check skill and auto-run hook (tested), new-decision skill, docs-consistency-reviewer and now-security-reviewer agents, push/commit ask rule in settings.local.json (gitignored); Isaac committed the earlier docs himself (up to c286d84) | Now (uncommitted)
2026-10-14 | junior | Checked against GitHub: the documents, 0007 and the Claude Code setup are committed and pushed (c9d319f, 10a6ef2, c286d84, c8fe2f0); the "uncommitted" lines above are superseded. Now cloned on a second machine (DELL laptop); it has no secret-scan hook and no settings.local.json yet | Now c8fe2f0
2026-10-14 | junior | Secret-scan hook installed and tested on the DELL laptop clone of Now (blocked a fake AWS key); R-22 now covered on both known clones, Tolu's own machine unverified | Now c8fe2f0
2026-10-14 | junior | Correction: the DELL laptop session (clone, vault fix, secret-scan hook) was Tolu's, not Isaac's | -
2026-10-14 | junior | Tolu: sign-in decided (E13: Google, Apple or email code, phone optional); 0007 accepted; T16 = founding posters join 14 days before the beta, no exemption; FR-POST-16 to 18, FR-MAP-12, FR-MOD-08, NFR-PRIV-09 added for rating integrity; data map updated; trace check clean (115 FR, 59 NFR) | Now (uncommitted, waiting for Isaac)
2026-10-14 | junior | Tolu proposed the tech stack as decision 0008 (Expo, Supabase London, MapLibre + OpenFreeMap, no SMS, Haiku 5.5 AI search behind the NFR-AI-01 gate, public posts only), 11 conditions; NFR-REL-06, NFR-SEC-20, NFR-AI-03 to 05 added; data map and legal items 12, 24 name OpenFreeMap, Cloudflare, Anthropic; trace check clean (115 FR, 64 NFR) | Now (uncommitted, waiting for Isaac)
2026-10-14 | junior | Tolu accepted 0001 (drop LIFE) and 0005 (working name and public copy, both parts); 0001 revisit trigger now the beta pass marks (T14); roadmap tracker updated; trace check clean | Now (uncommitted, waiting for Isaac)
2026-10-14 | junior | All of Tolu's 2026-10-14 changes committed on branch tolu/2026-10-14-decisions for Isaac's review (Isaac OK'd a review branch); not pushed yet: push account unresolved (Steezy7 has no repo access) | Now b616bbd (local)
2026-10-14 | junior | Review branch pushed with Isaac's OK (as Mednova-lifesciences, Tolu's account; Steezy7 has no repo access) and pull request #1 opened for Isaac | Now PR #1 (b616bbd)
2026-10-14 | junior | Isaac reviewed Tolu's 2026-10-14 decisions; review and consistency fixes (FR-VEN-06, FR-AUTH-11 proposed, FR-MAP-12 counts people, Resend data flow, legal 12/24/26 before the beta, T17); merged into main and pushed | Now 8ac1e5e
2026-10-14 | junior | Tolu answered T17: FR-POST-12 clarified (retroactive full weight), FR-POST-17 amended (flag mode in the private beta, hold before launch), FR-TEAM-04 added; playbook 24-hour review; 0006 note; committed to main on Isaac's no-branches instruction | Now 33e63e0
2026-10-14 | junior | Tolu decided the welcome screen (P13): one screen, no slideshow, line without unprovable claims; FR-AUTH-12 added | Now b73a21a
2026-10-14 | junior | Architecture Draft v3 after review pass 2 (24 findings, 2 High, all fixed; prototype schema v3, block clean-up repro), committed and pushed by Isaac; baseline 79/79 scenarios, 21/21 signing, 14/14 AI output | Now b77f5fd
2026-10-15 | junior | Tolu proposed decision 0009: phone number and SMS code sign-in only in the beta (+234), guests still explore without an account; FR-AUTH-13 to 19, NFR-REL-07, NFR-SEC-21, NFR-SEC-22, E14, R-34 added; amendment notes on 0006 and 0008; trace check clean (126 FR, 67 NFR) | Now (uncommitted, waiting for Isaac)
2026-10-15 | junior | Decision 0009 committed and pushed to main on Tolu's explicit instruction as co-founder, overriding Isaac's push rule (logged for Isaac) | Now a57e3cf
2026-10-15 | junior | Architecture review pass 3 (last): 24 findings (3 High); Highs and most Mediums fixed in prototype schema v4, 141/141 scenario tests, Highs reproduced on v3 and fixed on v4; doc still v3; full tests not run (stopped by Isaac) | Now (uncommitted, prototypes/architecture-check)
2026-10-15 | junior | Tolu answered E7 (FR-MOD-09) and E12 (FR-MAP-04 formula), deferred E14 and P7, proposed decision 0010 (post timer, seeding anywhere, caps only on SMS and AI, accepts the architecture except the fail-closed cap) and shared answers for Isaac; pushed on Tolu's instruction | Now adc862e
2026-10-15 | junior | Architecture Draft v4: every remaining pass-3 finding fixed in the doc (untested at Isaac's request), EC-98 to EC-120, effects of 0009 and 0010 noted; trace check clean | Now (uncommitted)
2026-10-15 | junior | Architecture Draft v4 and prototype v4 committed and pushed by Isaac | Now fdbbf86
2026-10-15 | junior | Isaac accepted 0009 with one change: +234 plus a founder-set allowlist of foreign countries (E15), tighter limits and a separate cap for foreign numbers; FR-AUTH-13 to 19, NFR-REL-07, NFR-SEC-21, NFR-SEC-22 Accepted; FR-AUTH-03 to 06 to Later; FR-AUTH-11 Dropped; 16 files; trace check clean (128 FR, 67 NFR) | Now 56a949c (committed by Isaac)
2026-10-15 | junior | Isaac accepted 0010 in full with Tolu's answers (T2, T4, T13, T14, NFR-PRIV-09 with a keyed hash, P14); beta pass marks locked; FR-POST-19, NFR-COST-02, NFR-PRIV-09 Accepted; 15 files; trace check clean (128 FR, 67 NFR) | Now (uncommitted, Isaac's clone)
2026-10-15 | junior | Isaac moved all hosting outside Supabase to AWS and the base map to Protomaps on AWS (MapLibre stays as the drawing library); architecture Draft v5 (AD-30, section 4.15, EC-121 to EC-124), change note on 0008, data map, legal items 1/12/24, tester pack, E2/E6; trace check clean (128 FR, 67 NFR); open: Cloudflare Access and Turnstile, CSAM tool | Now (uncommitted)
2026-10-15 | junior | Isaac committed architecture v5 (AWS hosting); kept Cloudflare Access and Turnstile; CSAM detection options researched and listed in EC-49, data map row for Cloudflare | Now c2bdfaf, then uncommitted
2026-10-15 | junior | Tolu agreed to Isaac's AWS change to 0008 and proposed decision 0011 (FR-PLC-11, FR-POST-20, fixed spots only in the beta, P15, all-Lagos Overture import) | Now 40fc014
2026-10-15 | junior | Tolu added 0011 point 6: proposed amendment to NFR-PRIV-02 (three allowed uses of location; a place pin is map data; no background location) | Now 8d597d1
2026-10-15 | junior | Architecture Draft v6: 0009 and 0010 brought in, Junior's AWS self-review, docs-consistency review (2 High, 8 Medium) fixed across 9 files; CSAM-in-beta and v6 proposals added as founder decisions; prototype untouched | Now (uncommitted)
2026-10-15 | junior | Architecture v6.1: Isaac accepted the beta tester-list hook (waiting for Tolu); proposed for Tolu: sms-gate with app attestation (@expo/app-integrity, alpha) and single-use send tickets so NFR-SEC-21 device/network limits run server-side (EC-127), verify-rate cut-off (EC-130), alpha-package risk (EC-131); trace check clean (128 FR, 67 NFR) | Now (uncommitted)
2026-10-15 | junior | Isaac committed architecture v6.1 (Now 6641681); Junior aligned threat model T-12, data map (send tickets, Google/Apple as proposed recipients), tester-pack notice (conditional placeholder) and legal items 1 and 24; pushed on Isaac's word; trace check clean; no docs-consistency review (Isaac) | Now 3e87b59
2026-10-15 | junior | Participant notice, data map and legal items 1/24 now name Expo push (FCM/APNs), TikTok, Sentry and GitHub (backup transit), which architecture 7.4 listed but they lacked; AI-search wording (AD-08 vs 0008) left for Isaac's decision, reminder set 22:00 | Now (uncommitted)
2026-10-15 | junior | Isaac answered E15: allowlist +234, UK, US and Canada (+1 by country, never prefix: EC-132); Ghana only on tester need; UAE not now; waiting for Tolu | Now (uncommitted)
2026-10-15 | junior | CONTRIBUTING.md section 2 rewritten (docs straight to main, code by PR, no force pushes; Isaac's change, Tolu to agree); classifier blocked CLAUDE.md and 10 doc headers, left for Isaac; T1: Isaac ~10 h/day to end Nov, Junior proposed he take security work off Tolu's path; waiting for Tolu's hours; Tolu agreed AWS change and proposed 0011 (40fc014) | Now (uncommitted)
2026-10-15 | junior | Map brief reviewed; coverage check added to 0008 spike test 4; Isaac: Play internal testing first, TestFlight when affordable, no web build (E11, beta plan) | Now (uncommitted)
2026-10-15 | junior | Isaac: personal Google Play account for the beta; organisation account (D-U-N-S) before or during launch, reminder in Active Priorities; E11 updated | Now (uncommitted)
2026-10-15 | junior | Isaac chose AI search = filter picker (AD-08): Anthropic gets the question only, prompt injection from posts removed, Jev not now; 0008 banner, NFR-AI-04 and NFR-SEC-15 reworded, T-06/T-07, data map, tester pack, test strategy updated; Tolu to agree | Now (uncommitted)
