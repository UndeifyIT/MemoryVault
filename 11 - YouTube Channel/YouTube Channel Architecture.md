---
status: active
project: youtube
type: reference
author: junior
created: 2026-10-30
updated: 2026-10-30
---
# YouTube Channel Architecture

> Draft, not confirmed. The renderer is decided (see [[YouTube Channel Renderer Decision]]); the rest is Junior's proposal of 2026-10-30 and not locked.

How episodes get made: two characters and one set are built once in code with three.js, and each episode is a script and timeline that a Node pipeline renders frame by frame in headless Chrome and mixes into a vertical video.

- **Repo:** https://github.com/isaaCecurity/U-Youtube_animated_Channel1 (default branch `main`). Under Isaac's personal GitHub account, not the Undeify organisation; private (GitHub answers 404 to an unauthenticated request, checked 2026-10-30).
- **Pipeline:** script → voice takes per line with word timings → `timeline.mjs` (single source of truth for cues, gaps, shots) → `film.json` (voice buses, mouth envelopes, subtitle chunks) → three.js page with a pure `setT(t)` rendered one frame at a time in headless Chrome on the GPU → ffmpeg mix (−14 LUFS) and mux to 1080×1920, 30 fps. Defined in the repo skill `.claude/skills/builder-ai-reel/SKILL.md`, our rewrite of a third-party file ("dev-claude-reel", source not recorded).
- **Characters and set:** built from code primitives in a shared library used by every episode (the skill builds them per video; we don't, so they can't drift). Expressions and gestures as named key tables. The AI is our own original character with its own name, not "Claude" (the skill's Claude branding conflicts with the brief). Upgrade path: Blender-modelled characters exported as glTF if the code-built look falls short.
- **Character consistency:** `CHARACTER_BIBLE.md` in the repo is the single source of truth (look, expressions, AI states, voices, personality, change process); code in `lib/characters/` must match it, and approved golden frames catch drift. The repo's `CLAUDE.md` makes every Claude session read it first.
- **Quality checks (from the skill, plus Junior's additions):** still-frame contact sheet approved before any full render; automated motion (jitter, teleports), grounding, penetration, subtitle and audio checks; loudness −14 LUFS, true peak ≤ −1.5 dBTP; golden-frame regression test against approved frames so the characters can't drift.
- **Tools:** Node 22+, three.js (pinned version), Chrome or Edge, ffmpeg, all free. Voices: free local text-to-speech for prototypes; ElevenLabs paid plan once a pilot proves the format (the skill says the free plan has no commercial licence; price and terms Unverified). OBS for tutorial screen recordings.
- **Hardware:** renders on the GPU through WebGL; a strong graphics card matters less than it did with Blender. The skill claims 0.15–0.3 s a frame on a mid-range GPU (Unverified); benchmark on the ThinkPad first. The skill stops if Chrome falls back to software rendering.
- **Phases (proposed):** A format proof (scripts, AI character's name, reference breakdown, five cold readers); B repo scaffold and our own skill; C ThinkPad setup and render benchmark; D character and set library, looks locked by Isaac; E Pilot 1 end to end; F Pilots 2–3 and the tutorial path. Junior's estimate: roughly 10–20 working days to Pilot 1 (Unverified).
- **Accounts and credentials:** none yet. API keys (for example ElevenLabs) go in a gitignored `.env` kept outside the folder the render server serves; record where logins are stored, never the values.
- **Security notes:** channel accounts are a prime hijacking target, often through fake sponsorship emails carrying malware: two-step sign-in with a passkey or security key, a Brand Account with a second manager, never open sponsor attachments on the work machine. The render server binds to 127.0.0.1 and must not serve dotfiles; Chrome's debugging port stays local with a throwaway profile. Pin three.js and use a lockfile. Screen recordings for tutorials can leak keys and URLs: scan before publishing.
- **Open questions:** see [[YouTube Channel Status]].
