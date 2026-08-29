---
title: Research - Godot 4.7 and Steam Shipping
project: Mecha Paper Ratchet
type: research
status: active
tags:
  - '#mecha-paper-ratchet'
  - '#research'
  - '#godot'
  - '#steam'
  - '#shipping'
---

# Research - Godot 4.7 and Steam Shipping

## Why this note exists

Capture current platform/engine facts that affect planning without letting release integration distract from the combat prototype.

## Source-backed findings

### Godot 4.7

- The official Godot download archive lists **Godot 4.7 stable** and provides standard builds for supported desktop platforms.
- The existing project configuration already declares `config/features=PackedStringArray("4.7", "Forward Plus")`.
- The project currently uses the standard GDScript workflow under `game/mecha-paper-wrench/`.
- Godot's 4.7 documentation describes desktop export as a project executable plus project data, with export presets and export templates required for packaging.

Sources:

- https://godotengine.org/download/archive/4.7-stable/
- https://docs.godotengine.org/en/4.7/tutorials/export/exporting_projects.html
- `game/mecha-paper-wrench/project.godot`

### Steam

- Steamworks describes an application as the main representation of a product on Steam with its own store page, Community Hub, and library presence.
- A product is represented by a unique App ID.
- Steamworks documentation separates depots, packages, builds, branches/betas, and applications. This matters for future release candidates, private test branches, and public builds.
- Steamworks says the SDK is required to upload content to Steam; other SDK features are optional. Do not assume achievements, cloud saves, or other integrations are required for the first prototype.

Sources:

- https://partner.steamgames.com/doc/store/application
- https://partner.steamgames.com/doc/sdk
- https://partner.steamgames.com/doc/home

## Working shipping interpretation

1. Keep Godot 4.7 as the engine target and verify the exact installed executable before release builds.
2. Treat Windows PC as the first shipping platform unless the questionnaire expands scope.
3. Build the game so Steam integration is optional at the gameplay layer: local play should work without an active Steam session during development.
4. Establish export presets and repeatable release builds before store-page work.
5. Use a private Steam branch for candidate builds once an App ID and Steamworks access exist; do not make Steam deployment a prerequisite for local playtests.
6. Delay SDK feature integration until the base save/settings/progression contracts are stable.

## Steam-facing planning checklist

### Early, after the first stable playable

- [ ] Confirm Windows export preset and export templates.
- [ ] Add a clean release build directory outside the source project.
- [ ] Decide whether game data is packed as PCK and how build artifacts are named.
- [ ] Verify save path, settings persistence, and clean first-launch behavior.
- [ ] Test keyboard/mouse and controller assumptions from the questionnaire.
- [ ] Document minimum/recommended display and performance targets.

### Later, when the loop has repeat value

- [ ] Create a Steamworks application/App ID.
- [ ] Prepare depots/packages and a private beta branch.
- [ ] Decide on achievements and whether they reflect discovery rather than grind.
- [ ] Decide on cloud saves only after the save schema is stable.
- [ ] Prepare store capsule art, trailer capture, screenshots, and feature bullets.
- [ ] Check Steam Deck/Linux viability if the questionnaire requests it.

## Risks and boundaries

- Godot export success is not the same as Steam release readiness.
- Steamworks account/setup requirements may change; re-check official docs before an actual upload.
- Do not add SDK calls to core gameplay scripts when a service boundary or optional adapter will do.
- Do not make a Steam-only progression dependency before offline behavior and save recovery are tested.
- Controller, accessibility, resolution scaling, and pause behavior are product requirements even if they are not needed for the first combat toybox.

## Agent job candidates

See [[06 Tasks/Agent Job Prompts]] for reusable prompts covering export verification, Steam readiness, and Godot project audits.

## Research status

Coverage is **strong for the official engine/download/export and Steamworks structure pages inspected on 2026-08-12**. This note is not a substitute for current Steamworks account/legal/release guidance at the time of launch.
