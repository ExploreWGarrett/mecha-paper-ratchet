---
title: Godot Project Setup
project: Mecha Paper Ratchet
type: technical
status: active
tags:
  - '#mecha-paper-ratchet'
  - '#godot'
  - '#technical'
  - '#steam'
---

# Godot Project Setup

## Current Recommendation
Use **Godot 4** unless a prototype blocker proves Unity is necessary.

## Why Godot Fits
- fast iteration for solo development
- good hybrid 2D / 3D support
- lightweight project setup
- strong fit for prototype-first workflows

## Intended Code Location
Store the actual engine project in:

`game/mecha-paper-wrench/`

This keeps the project name distinct for future flexibility while leaving the Obsidian vault under the broader Mecha Paper Ratchet project.

## First Technical Milestones
1. create a new Godot 4 project in `game/`
2. create a simple 3D arena test scene
3. create a placeholder paper player presentation
4. implement movement and camera
5. implement lock-on and strafing
6. implement one ranged weapon
7. implement one enemy with one projectile attack

## Suggested Early Folder Ideas Inside `game/`
- `scenes/`
- `scripts/`
- `art/`
- `audio/`
- `data/`
- `ui/`

## Technical Priorities
1. movement feel
2. camera readability
3. lock-on clarity
4. shooting response
5. dodge fairness
6. hit feedback

## Godot 4.7 / Steam direction

- Target Godot **4.7 stable**; the project already declares the `4.7` feature version in `project.godot`.
- Keep Windows PC as the first assumed shipping target unless the kickoff questionnaire expands platform scope.
- Treat Steam integration as an optional adapter around local gameplay, saves, and settings.
- Track export and Steam-facing facts in [[02 Design/Research - Godot 4.7 and Steam Shipping]].
- Use [[06 Tasks/Agent Job Prompts]] for repeatable Godot audit and Steam export audit jobs.

## Documentation relationship

- Obsidian standards: [[05 Technical/Obsidian Documentation Standards]]
- Code traceability: [[04 Prototype/Prototype-Code Link Map]]
- Kickoff decisions: [[01 Vision/Development Kickoff Questionnaire]]

## Warning
Do not let content creation or Steam integration outrun the core controller.
