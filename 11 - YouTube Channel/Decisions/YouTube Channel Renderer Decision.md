---
status: active
project: youtube
type: reference
author: junior
created: 2026-10-30
updated: 2026-10-30
---
# YouTube Channel Renderer Decision

Pilot 1 is made with a three.js pipeline rendered in headless Chrome, with characters built in code; Blender is the upgrade path, not the foundation.

- **Decided by:** Isaac, on 2026-10-30 (answered "yes" to Junior's proposal).
- **Context:** the brief assumed Blender. Isaac is new to Blender, and hand-modelling and rigging the Builder was the slowest, riskiest step (estimated 8–14 days). A third-party skill file in the repo describes a complete code-driven reel pipeline with strong automated quality checks.
- **Options considered:** Blender with a Python-driven pipeline (closest to the concept art's soft lighting, but slowest to a first video); the skill's three.js pipeline as is (fast, but builds characters per video and brands the AI as "Claude"); three.js with our own shared character library (chosen).
- **Why:** gets to a first pilot in roughly half the time (estimate), Claude Code can drive the whole loop, and the format gets tested before weeks go into modelling.
- **Cost and risk:** free tools. Risk: code-built characters look blockier than the concept art. Mitigation: model the Builder in Blender later and load him as glTF. The skill's "Claude" branding is removed.
- **Revisit when:** the locked character stills don't match the brand closely enough, or the render benchmark on the ThinkPad is too slow.
