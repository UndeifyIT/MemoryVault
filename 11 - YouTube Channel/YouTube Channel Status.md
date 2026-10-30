---
status: active
project: youtube
type: reference
author: junior
created: 2026-10-30
updated: 2026-10-30
---
# YouTube Channel Status

> Draft, not confirmed. Concept recorded from Isaac's brief; the production architecture is proposed, not locked.

Planning stage: the concept is written up, Junior has proposed a production pipeline, and no production work starts until Isaac buys the ThinkPad.

## Snapshot
- **Stage:** Planning. Repo has GitHub's initial commit (`43c5f32`) plus Isaac's uncommitted `PROJECT_MASTER_BREIF.md` and a `character concepts` folder with two images (checked 2026-10-30).
- **Concept (source: the brief in the repo):** a faceless, avatar-led channel of short vertical (9:16, 30–60 s) low-poly 3D animated conversations between two original characters, The Builder (young developer in a dark hoodie) and The AI (small orange cube). Content pillars: Build with AI 50%, startup and tech skits 30%, building in public 20%. Long-form tutorials later. Visual reference for the format: the Instagram account Agent Morphy (format only, no copying).
- **Hardware (checked 2026-10-30):** Isaac's current laptop is an HP ProBook x360 11 G1 EE (Pentium N4200, about 4 GB RAM, Intel HD 505, about 11 GB free disk): fine for planning, not for rendering. Isaac will do the production work on a Lenovo ThinkPad he has not bought yet (advertised: 11th-gen i7, 8 cores, 32 GB RAM, "6 GB dedicated graphics", 770k). Unverified: the ThinkPad's real GPU.
- **Characters:** the AI is named Junior and keeps the concept's arms and legs (see [[YouTube Channel AI Character Decision]]); the Builder's name comes from Isaac later.
- **What does not exist yet:** channel name, the Builder's name, YouTube account (Unverified), any pipeline code or 3D assets.
- **Known issues:** the brief's example dialogue calls the AI "Claude"; scripts must call it Junior, which runs on Claude in the story.

## Where we stopped

### Isaac
Isaac chose the three.js pipeline with code-built characters (see [[YouTube Channel Renderer Decision]], 2026-10-30). On Isaac's go, Junior set up the repo (2026-10-30; Isaac committed it): our own skill `.claude/skills/builder-ai-reel/SKILL.md` (rewritten from the third-party file, Claude branding removed), `CHARACTER_BIBLE.md` v0.1 draft (the single source of truth for both characters), a repo `CLAUDE.md`, `.gitignore`, `.env.example`, `config/voices.json`, `golden/README.md` and an audio licence register; concept images moved to `assets/concept/`. Bible now v0.2 with Junior's name and limbs. Isaac confirmed the "Junior runs on Claude" wording and committed and pushed the repo setup himself (latest `a870356`, checked 2026-10-30). Phase A started: Junior drafted `docs/channel-strategy.md` (audience, hooks, next step, measurement) and three pilot scripts in `episodes/` (all uncommitted, Isaac edits). Next: Isaac decides the audience (global or Nigeria/Africa edge) and edits the scripts; Pilot 2 needs Isaac's real landing-page experiment; ThinkPad purchase and its pre-purchase checks are on Isaac.

### Tolu
Nothing yet.

## Next steps
1. Isaac decides Undeify-branded channel or separate brand.
2. Isaac gives the Builder's name when ready and gives the word to commit the repo setup.
3. Isaac verifies the ThinkPad before paying (real GPU and dedicated memory in Task Manager, no BIOS supervisor lock), then reinstalls Windows.
4. Name the channel; check the YouTube handle, domain and trademark are free.
