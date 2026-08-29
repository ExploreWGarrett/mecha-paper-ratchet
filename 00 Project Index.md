---
title: Mecha Paper Ratchet - Project Index
project: Mecha Paper Ratchet
type: index
status: active
tags:
  - '#mecha-paper-ratchet'
  - '#index'
  - '#documentation'
  - '#godot'
---

# Mecha Paper Ratchet — Project Index

## Purpose
This vault is the working home for **Mecha Paper Ratchet**.

Use it for:
- vision and design notes
- prototype planning
- technical decisions
- task tracking
- reference material
- source code in `game/`

## Core Project Mantra
> Combat first.  
> Paper style for simplicity.  
> Weird weapons for personality.  
> Procedural assembly, not procedural chaos.  
> Build one fun room before building a whole game.

## Current Direction
- Genre: solo-dev-friendly action roguelite
- Feel target: Ratchet & Clank combat energy
- Visual target: Paper Mario-style flat character readability in chunky 3D spaces
- Structure target: short replayable runs with escalating pressure and upgrade choices
- Engine leaning: **Godot 4**

## Proposed Spin-Off / Direction Branch

A new source blast proposes **Yearn for the Mines**, a first-person incremental mining game with hands-first excavation, tool purchases, descending mine progression, collectibles, hidden labor-history lore, collapse prestige, and a temple ending.

This is currently documented as a proposed spin-off or prototype branch, not a replacement for the existing Mecha Paper Ratchet action prototype:

- [[02 Design/Yearn for the Mines/00 Direction Blast - Source Capture]]
- [[02 Design/Yearn for the Mines/01 Concept Expansion]]
- [[02 Design/Yearn for the Mines/02 Progression Economy and Prestige]]
- [[02 Design/Yearn for the Mines/03 Lore, Child Labor, and Endings]]
- [[02 Design/Yearn for the Mines/04 Contestation and Decision Log]]

## Folder Map
- [[01 Vision/Project Vision]]
- [[01 Vision/Development Kickoff Questionnaire]]
- [[02 Design/Arena Mode]]
- [[02 Design/Progression and Meta Loop Plan]]
- [[02 Design/Lore and World Plan]]
- [[02 Design/Research - Godot 4.7 and Steam Shipping]]
- [[02 Design/Ideas/Side Notes - Callous and Grit]]
- [[02 Design/Yearn for the Mines/00 Direction Blast - Source Capture]]
- [[02 Design/Yearn for the Mines/01 Concept Expansion]]
- [[02 Design/Yearn for the Mines/02 Progression Economy and Prestige]]
- [[02 Design/Yearn for the Mines/03 Lore, Child Labor, and Endings]]
- [[02 Design/Yearn for the Mines/04 Contestation and Decision Log]]
- [[02 Design/Standout Combat and Upgrade Synergy Ideas]]
- [[02 Design/Inspiration Upgrade References/00 Inspiration Reference Index]]
- [[02 Design/Inspiration Upgrade References/05 Inspiration Buckets by Use]]
- [[02 Design/Inspiration Upgrade References/06 Inspiration Curation - Primary Secondary Tone]]
- [[02 Design/Inspiration Upgrade References/07 Mecha Paper Ratchet Design Authority Map]]
- [[02 Design/Inspiration Upgrade References/08 Mecha Paper Ratchet Design Commandments]]
- [[02 Design/Inspiration Upgrade References/09 Next Implementation Shortlist - Do Dont Parking Lot]]
- [[02 Design/Inspiration Upgrade References/10 Ranked Next Build Sequence]]
- [[02 Design/Inspiration Upgrade References/11 Concrete Implementation Packet - Next 3 Features]]
- [[02 Design/Inspiration Upgrade References/12 Feature Pass Implementation Checklists]]
- [[02 Design/Inspiration Upgrade References/13 Pre-Implementation Readiness Gate]]
- [[02 Design/Inspiration Upgrade References/14 First Implementation Session Brief]]
- [[02 Design/Inspiration Upgrade References/15 Readiness Gate Assessment - 2026-07-17]]
- [[02 Design/Inspiration Upgrade References/16 Baseline Feel Validation Checklist]]
- [[02 Design/Inspiration Upgrade References/17 Baseline Feel Validation Session Brief]]
- [[02 Design/Inspiration Upgrade References/18 2026-07-18 Readiness Gate Re-Run]]
- [[02 Design/Inspiration Upgrade References/19 Implementation Alignment Review Packet]]
- [[02 Design/Inspiration Upgrade References/20 Implementation Kickoff Brief]]
- [[02 Design/Exploit Awareness References/00 Exploit Research Index]]
- [[03 Systems/Room Generation]]
- [[03 Systems/Weapon Ideas]]
- [[03 Systems/Wrench Popper Upgrades and Fusion Planning]]
- [[03 Systems/Anti-Exploit Review Checklist]]
- [[03 Systems/Exploit Risk Grading for First Upgrade Families]]
- [[03 Systems/Enemy and Upgrade Foundations]]
- [[03 Systems/Destructibles and Currency]]
- [[04 Prototype/Combat Prototype]]
- [[04 Prototype/Baseline Feel Validation Findings Template]]
- [[04 Prototype/2026-07-18 Baseline Feel Validation Session]]
- [[04 Prototype/Prototype Roadmap]]
- [[05 Technical/Godot Project Setup]]
- [[05 Technical/Obsidian Documentation Standards]]
- [[05 Technical/GitHub Portfolio Sync Plan]]
- [[04 Prototype/Prototype-Code Link Map]]
- [[06 Tasks/Agent Job Prompts]]
- [[06 Tasks/Next Actions]]

## Working Rules
1. Protect scope.
2. Prototype the feel before expanding content.
3. Prefer small, testable additions.
4. Write decisions down when they become real.
5. Keep code in `game/` and notes in the vault.

## First Real Build Goal
> A paper character in a simple 3D arena can lock onto an enemy, strafe, jump, dodge pressure, defeat the enemy, and collect the XP reward.

## Immediate Focus
- Confirm Godot 4 as engine
- Create a minimal combat toybox plan
- Build the first prototype in `game/mecha-paper-wrench/`
- Track open design questions before features multiply

## Current Prototype Update
- Bare-bones circular and square arenas now alternate across a five-level combat ladder
- Default player now reads more like a paper-thin directional wedge than a plain flat rectangle
- Default combat starts melee-first
- Movement/combat fusion target: Ratchet & Clank + Jak and Daxter
- Current scaffold includes lock-on, melee combo, boomerang throw, high jump, long jump, roll, spin-finisher behavior, ground pound, double jump, feather fall, crouch spin, one-use midair dodge, a first weapon reward flow with fallback melee inputs while armed, destructible crate money pickups, and a live decimal difficulty slider in the pause menu
- Player now has health, temporary invincibility, XP attraction/collection, HUD text, a health bar, and a separate money total
- Enemy roster now includes a ground grunt, a flying ranger with keep-away projectile pressure, and a first grunt-based miniboss with an AOE slam plus extra XP payout
- Enemy base is now being reshaped around explicit Idle / Chase / Attack / Stagger states plus family + role-tag metadata for future variants
- Level flow now includes enemy-clear progression, replay/restart menu hooks, and WASD + Space splash-menu scaffolding between stages
- Feedback polish now includes fall respawn with health loss, higher-tier XP colors, projectile trails, light camera shake, distinct hit/hurt sounds, slightly more centered pistol presentation, softer crate durability with fall break potential, and a boomerang fail-safe that lets the wrench get caught briefly before auto-returning
- Escape now opens a real pause/settings menu with working audio/sensitivity/shake/difficulty options and a controls toggle
- While the boomerang is out, the player now falls back to a weaker/faster short-range punch + emergency spin kit instead of reusing the full wrench attacks
- Upgrade prep now lives in a lightweight `PlayerUpgrade` resource scaffold for future reward screens and player-build experiments
- Mutation / Momentum / alternate-character / unlock-journal planning now lives in `03 Systems/Mutations Momentum and Unlock Journal.md`


## Current Practical Milestone
- The default player-driven character feels close to locked in as a prototype baseline
- Current work is shifting from a single reusable base enemy into a small reusable enemy roster and first miniboss encounter
- Design prep now also includes a dedicated note for standout upgrade-tag synergies, enemy-role combinations, paper/comic wow-factor hooks, mutation ideas, Momentum routing, alternate character starts, and unlock-journal planning
- Weapon planning now includes a stance-based ranged layer, multi-camera support, first-pass notes on stack / order-sensitive weapon upgrades, and the first destructible economy tie-in
- Inspiration planning now includes grouped reference markdowns for upgrade/powerup structures across Mega Bonk, Risk of Rain 2, Noita, Stack Gun Heroes, Vampire Survivors, Gunfire Reborn, Hades, The Binding of Isaac, Enter the Gungeon, Dead Cells, plus added notes on Returnal and Roboquest
- Exploit-prevention planning now includes a SpiffingBrit-inspired awareness set focused on repeatable extraction loops, bad exchange rates, state-transition abuse, and reward-duplication risks to watch before the progression layer grows
- World-economy planning now includes destructible crates, separate money pickups, scalable reward hooks, and future-ready drop-table prep
- Main tuning concerns now are attack readability, hit reliability, enemy pacing, flyer spacing, miniboss fairness, crate value, impact feedback, and where the Normal / Hard / Brutal anchor points should land on the decimal slider
