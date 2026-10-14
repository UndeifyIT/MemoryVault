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
