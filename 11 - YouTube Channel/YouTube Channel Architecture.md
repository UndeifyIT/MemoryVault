---
status: active
project: youtube
type: reference
author: junior
created: 2026-10-30
updated: 2026-10-30
---
# YouTube Channel Architecture

> Draft, not confirmed. Junior's proposal of 2026-10-30, based on the repo's `PROJECT_MASTER_BREIF.md` and two concept images; nothing below is locked.

How episodes get made: a fixed "puppet theater" where the characters and stage are built once in Blender and each episode is a script file a pipeline turns into a video.

- **Repo:** https://github.com/isaaCecurity/U-Youtube_animated_Channel1 (default branch `main`). Under Isaac's personal GitHub account, not the Undeify organisation; visibility not checked.
- **Pipeline (proposed):** `script.yaml` → text-to-speech per line → `timeline.json` with exact timings and auto camera rules → Blender renders each shot headless (Eevee) → ffmpeg mixes audio, burns captions and exports the vertical video. Each stage cached by content hash.
- **Animation approach (proposed):** Builder seated, upper body only; procedural blinks, breathing and head sway; about 10 stored gestures; 10 expressions as presets in one YAML file. AI cube: sine-wave float, stored tilt and bounce actions per emotion, scale pulse from audio when speaking. Builder lip movement from audio loudness, Rhubarb Lip Sync if that looks off.
- **Tools (proposed, all free):** Blender, Python, ffmpeg, local text-to-speech (Kokoro or Piper; check each voice's licence), Whisper only for word-level captions, OBS for screen recordings. Optional paid: ElevenLabs for the Builder voice if the free voice is flat (price and commercial terms Unverified). Rejected: AI video generators (inconsistent characters, cost per second), Unreal or Unity (heavier than needed).
- **Alternative under review (2026-10-30):** a third-party skill file in the repo (`SKILL.md`, "dev-claude-reel", source not recorded) renders with three.js in headless Chrome instead of Blender: characters built from code primitives, timeline shared by Node and the browser, ElevenLabs voices with word timings, automated motion, grounding, subtitle and loudness checks. Junior's recommendation: use its pipeline and QA rules, build our own characters in code first, and bring in Blender-modelled characters (exported as glTF) only if the look needs it. Its "Claude" character branding conflicts with the brief's no-endorsement rule and must be replaced by our own AI character. Render speed claimed by the file (0.15–0.3 s a frame on a mid-range GPU) is Unverified.
- **Hardware split:** only the Blender render step needs a GPU; script, voice, timing, captions and assembly run on any laptop. Fallback if rendering is slow: cloud GPU rental or a community render farm (terms and prices Unverified).
- **Phases (proposed):** 0 hardware benchmark; 1 script-and-voice chain with an animatic (concept stills plus real voices and captions), no 3D; 2 characters; 3 stage and six cameras; 4 animation driver; 5 assembly; 6 Pilot 1 end to end; 7 Pilots 2–3 and long-form; 8 optional automation. Junior's estimate: 30–45 working days to Pilot 1 for a Blender beginner (Unverified).
- **Accounts and credentials:** none yet. API keys (for example ElevenLabs) go in a gitignored `.env`; record where logins are stored, never the values.
- **Security notes:** channel accounts are a prime hijacking target, often through fake sponsorship emails carrying malware: two-step sign-in with a passkey or security key, a Brand Account with a second manager, never open sponsor attachments on the work machine. Blender add-ons and downloaded `.blend` files can run code: keep "Auto Run Python Scripts" off and install Blender only from blender.org. Screen recordings for tutorials can leak keys and URLs: scan before publishing.
- **Open questions:** see [[YouTube Channel Status]].
