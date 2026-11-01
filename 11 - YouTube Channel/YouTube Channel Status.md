---
status: active
project: youtube
type: reference
author: junior
created: 2026-10-30
updated: 2026-11-01
---
# YouTube Channel Status

> Draft, not confirmed. Concept recorded from Isaac's brief; the production architecture is proposed, not locked.

Planning stage: the concept is written up and Junior has proposed a production pipeline. **Update 2026-11-01:** the "wait for the ThinkPad" gate no longer holds — Tolu's Surface Pro benchmarked real GPU rendering (not software fallback); see "Where we stopped" below. Prototyping work can start now.

## Snapshot
- **Stage:** Planning. Repo has GitHub's initial commit (`43c5f32`) plus Isaac's uncommitted `PROJECT_MASTER_BREIF.md` and a `character concepts` folder with two images (checked 2026-10-30).
- **Concept (source: the brief in the repo):** a faceless, avatar-led channel of short vertical (9:16, 30–60 s) low-poly 3D animated conversations between two original characters, The Builder (young developer in a dark hoodie) and The AI (small orange cube). Content pillars: Build with AI 50%, startup and tech skits 30%, building in public 20%. Long-form tutorials later. Visual reference for the format: the Instagram account Agent Morphy (format only, no copying).
- **Hardware:** Isaac's current laptop is an HP ProBook x360 11 G1 EE (Pentium N4200, about 4 GB RAM, Intel HD 505, about 11 GB free disk, checked 2026-10-30): fine for planning, not for rendering. The Lenovo ThinkPad Isaac plans to buy (advertised: 11th-gen i7, 8 cores, 32 GB RAM, "6 GB dedicated graphics", 770k) is still unbought and its real GPU Unverified. **Tolu's Surface Pro (i7-7660U, Intel Iris Plus 640, 16 GB RAM) is GPU-render-capable, benchmarked 2026-11-01** — see "Where we stopped" below.
- **Characters:** the AI is named Junior and keeps the concept's arms and legs (see [[YouTube Channel AI Character Decision]]); the Builder's name comes from Isaac later.
- **What does not exist yet:** channel name, the Builder's name, YouTube account (Unverified), any pipeline code or 3D assets.
- **Known issues:** the brief's example dialogue calls the AI "Claude"; scripts must call it Junior, which runs on Claude in the story.

## Where we stopped

### Isaac
Isaac chose the three.js pipeline with code-built characters (see [[YouTube Channel Renderer Decision]], 2026-10-30). On Isaac's go, Junior set up the repo (2026-10-30; Isaac committed it): our own skill `.claude/skills/builder-ai-reel/SKILL.md` (rewritten from the third-party file, Claude branding removed), `CHARACTER_BIBLE.md` v0.1 draft (the single source of truth for both characters), a repo `CLAUDE.md`, `.gitignore`, `.env.example`, `config/voices.json`, `golden/README.md` and an audio licence register; concept images moved to `assets/concept/`. Bible now v0.2 with Junior's name and limbs. Isaac confirmed the "Junior runs on Claude" wording and committed and pushed the repo setup himself (latest `a870356`, checked 2026-10-30). Phase A started: Junior drafted `docs/channel-strategy.md` (audience, hooks, next step, measurement) and three pilot scripts in `episodes/` (all uncommitted, Isaac edits). Audience decided: builders in Africa first (see [[YouTube Channel Audience Decision]]). The Builder keeps his concept look and sounds American; Isaac picks both voices later from ElevenLabs or a better provider. Next: Isaac edits the scripts and runs the EP002 experiment; Pilot 2 needs Isaac's real landing-page experiment; ThinkPad purchase and its pre-purchase checks are on Isaac.

### Tolu
2026-11-01: repo moved to `UndeifyLTD/U-Youtube_animated_Channel1` (was Isaac's personal account). Tolu asked Junior to start the characters and set in code; built `lib/characters/{builder,ai}.js` and `lib/set/{workspace,cameras}.js` from the bible and the skill's motion rules, pinned three.js (`package.json`), and actually rendered it with headless Chrome rather than just claiming it worked — found and fixed two real bugs (Junior's pose overwriting his own position; hair geometry swallowing the face). Committed and pushed (`b060f26`). See [[YouTube Channel Architecture]] for what's provisional.

Then benchmarked the GPU render path on Tolu's own machine (`tools/gpu-benchmark.mjs`, `003a7de`): **Surface Pro, Intel Iris Plus 640 — renders on the real GPU (ANGLE/Direct3D11), not the software fallback that would freeze the machine.** ~221ms/frame mean with no DOF/bloom chain yet (that doesn't exist), ~5.5 minutes estimated for a 50s/1500-frame episode. Not directly comparable to the skill's "0.15-0.3s/frame" reference figure, which assumes the full post-processing chain. Practical read: this machine can be used for prototyping now; the ThinkPad becomes a speed upgrade, not a blocker.

Also connected ElevenLabs for Tolu's own Claude Code (account "Toluwani", Free plan, 5/10,000 credits used) — not yet wired into `config/voices.json`, which is still all null; that's Isaac's call per the bible.

## Next steps
1. Isaac decides Undeify-branded channel or separate brand.
2. Isaac gives the Builder's name when ready.
3. Isaac verifies the ThinkPad before paying (real GPU and dedicated memory in Task Manager, no BIOS supervisor lock), then reinstalls Windows.
4. Name the channel; check the YouTube handle, domain and trademark are free.
5. Isaac reviews the character/set code against the bible through stills and locks Phase D proportions and colours, or sends corrections.
6. Build the real render pipeline (film.html/scene.js with DOF/bloom/composite, timeline.mjs, voices, mux) — the character/set library and a GPU benchmark are done; this is the next chunk.
