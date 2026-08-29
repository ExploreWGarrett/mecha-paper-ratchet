# Mecha Paper Ratchet

A solo-dev-friendly Godot 4 action-roguelite prototype focused on fast combat feel, readable paper-style characters, lock-on clarity, and compact testable milestones.

## Current prototype goal

Build a paper character in a simple 3D arena that can:

- lock onto one enemy
- strafe
- jump
- shoot / use a ranged weapon layer
- dodge projectile pressure
- defeat enemies and collect rewards

## Project structure

```text
01 Vision/      Project vision and alignment notes
02 Design/      Design plans, references, and decision records
03 Systems/     Gameplay systems and upgrade planning
04 Prototype/   Prototype notes, findings, and code links
05 Technical/   Godot setup, standards, and publish/sync notes
06 Tasks/       Current task tracking and reusable agent job prompts
game/           Godot project code and assets
assets/         Supporting source assets outside the engine project
```

The active Godot project is:

```text
game/mecha-paper-wrench/
```

## Current implementation highlights

- Godot 4.7 prototype scene scaffold
- player movement, jumping, crouch/roll, air dodge, double jump, feather fall, and ground pound experiments
- lock-on and camera mode experiments, including an explicitly labeled `First Person (Experimental)` option
- melee-first combat baseline plus Paper Popper reward/weapon layer
- destructible crates, money pickups, XP orbs, health, and HUD feedback
- enemy roster scaffold including grunt, flying ranger, and miniboss-style behavior
- refactored player components for camera, settings, ability/loadout, and combat input ownership
- refactored main-scene controllers for level flow, settings UI, and debug overlays

## Verification status

This prototype currently uses focused ad-hoc Godot headless verification scripts rather than a canonical automated test suite. Passing checks are documented in the Obsidian notes as **ad-hoc verified, not suite green**.

## Privacy / portfolio note

This repository is intended to contain non-identifying prototype code and project documentation only. Generated editor caches, local workspace state, exports/builds, logs, environment files, credentials, tokens, and machine-specific paths are excluded or redacted before publication.

## Running the prototype

Open the Godot project at:

```text
game/mecha-paper-wrench/
```

Recommended engine: Godot 4.7 stable.
