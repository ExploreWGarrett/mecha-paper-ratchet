---
title: Prototype-Code Link Map
project: Mecha Paper Ratchet
type: technical
status: active
tags:
  - '#mecha-paper-ratchet'
  - '#prototype'
  - '#code'
  - '#godot'
  - '#traceability'
---

# Prototype-Code Link Map

## Purpose

Connect Obsidian decisions to the Godot 4.7 project without duplicating code in notes.

## Current runtime ownership

| Responsibility | Implementation surface | Design/evidence notes |
|---|---|---|
| Run/menu orchestration | `game/mecha-paper-wrench/scripts/main.gd` | [[04 Prototype/Combat Prototype]], [[06 Tasks/Next Actions]] |
| Level catalog, arena switching, spawn/clear flow | `game/mecha-paper-wrench/scripts/main_level_controller.gd` | [[02 Design/Arena Mode]], [[04 Prototype/Combat Prototype]] |
| Settings and live options | `game/mecha-paper-wrench/scripts/main_settings_controller.gd`, `player_settings_controller.gd` | [[05 Technical/Godot Project Setup]], [[06 Tasks/Next Actions]] |
| Debug mechanic toggles | `game/mecha-paper-wrench/scripts/main_debug_controller.gd` | [[04 Prototype/Combat Prototype]] |
| Player movement/physics | `game/mecha-paper-wrench/scripts/player.gd` | [[01 Vision/Project Vision]], [[04 Prototype/Combat Prototype]] |
| Camera and aim | `game/mecha-paper-wrench/scripts/player_camera_controller.gd` | [[04 Prototype/Combat Prototype]] |
| Ability slots | `game/mecha-paper-wrench/scripts/player_ability_controller.gd` | [[03 Systems/Weapon Ideas]], [[04 Prototype/Combat Prototype]] |
| Combat input/routing | `game/mecha-paper-wrench/scripts/player_combat_controller.gd` | [[03 Systems/Weapon Ideas]] |
| Upgrade data scaffold | `game/mecha-paper-wrench/scripts/player_upgrade.gd` | [[03 Systems/Enemy and Upgrade Foundations]], [[02 Design/Progression and Meta Loop Plan]] |
| Enemy behavior | `game/mecha-paper-wrench/scripts/enemy.gd` | [[03 Systems/Enemy and Upgrade Foundations]] |
| XP/money pickups | `game/mecha-paper-wrench/scripts/xp_orb.gd`, `money_pickup.gd` | [[03 Systems/Destructibles and Currency]], [[02 Design/Progression and Meta Loop Plan]] |
| Project identity and input map | `game/mecha-paper-wrench/project.godot` | [[05 Technical/Godot Project Setup]], [[02 Design/Research - Godot 4.7 and Steam Shipping]] |

## Update rule

When a script responsibility changes, update this map and the nearest design note in the same work session. When a feature is implemented from an agent prompt, link the resulting code paths and verification note here.
