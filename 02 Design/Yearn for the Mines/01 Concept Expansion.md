---
title: Yearn for the Mines - Concept Expansion
project: Yearn for the Mines
parent-project: Mecha Paper Ratchet
concept-status: proposed-pivot
type: concept-expansion
status: draft
tags:
  - '#yearn-for-the-mines'
  - '#concept-expansion'
  - '#incremental'
  - '#first-person'
  - '#mining'
---

# Yearn for the Mines — Concept Expansion

## Purpose

Turn the direction blast into a concrete, reviewable game shape while keeping the ideas provisional. This note is a design interpretation, not a replacement for the source capture in [[00 Direction Blast - Source Capture]].

## One-sentence pitch

**Yearn for the Mines** is a first-person incremental mining game about starting powerless in a collapsed mine, manually excavating and sifting for value, buying increasingly capable tools, and deciding how far to push a dangerous descent before the mine—or the player’s assumptions about it—gives way.

## What makes the concept attractive

### Immediate fantasy

The player can understand the fantasy without a tutorial wall: look at material, work it with the current capability, collect what comes loose, sell it, buy better capability, go deeper.

### Strong visible progression

The mine itself provides a clean progression ladder:

- loose dirt and sand;
- siftable rubble;
- compacted clay or debris;
- soft stone;
- hard rock;
- reinforced or unusual strata;
- structures that are not natural geology.

Each tier can change what the player does, not only multiply income.

### A natural incremental loop

The game can make the next upgrade visible in the world. The player does not need to wonder why a pickaxe matters: the rock wall is the purchase justification.

### Built-in mystery

A descending tunnel creates a strong forward question: what is beneath the collapse? Collectibles, markings, records, tools, and geological anomalies can reward exploration without requiring a large overworld.

## Proposed core loop

1. Enter a collapsed mine entrance or current excavation chamber.
2. Inspect reachable material and identify what the current capability can affect.
3. Excavate manually using hands, a basic scoop, or a temporary improvised action.
4. Sift loose material for ore, objects, clues, and low-value waste.
5. Carry or deposit finds at a surface workbench/hoist.
6. Sell or process finds into money and research/discovery value.
7. Buy the next tool, capacity upgrade, energy efficiency, or safety improvement.
8. Push past the newly reachable material boundary.
9. Choose whether to bank progress, continue deeper, or risk a collapse event.
10. Return to the mine with a changed route, permanent unlock, or new clue.

## Recommended first-playable slice

The first slice should not attempt the entire mine, prestige system, temple, or child-labor mystery. It should prove the physical and economic sentence:

- one short first-person tunnel;
- hands as the starting capability;
- one loose material type;
- one sift interaction;
- one ore/item reward;
- one sell/deposit point;
- one purchasable tool or efficiency upgrade;
- one material barrier that clearly requires the purchase;
- one short descent beyond the barrier;
- one collapse/reset test state.

The success question is not “is the whole incremental economy complete?” It is:

> Is it satisfying to physically work the first material, discover a small reward, buy a capability, and use it to cross a visible boundary?

## Interaction model options

### Option A — Direct material interaction
The player targets a material face, holds an input, and the material visibly deforms or sheds pieces.

**Strength:** clearest first-person fantasy.

**Risk:** destructible terrain and deformation can become technically expensive.

### Option B — Authored excavation nodes
The mine is built from authored chunks or dig sites. Each interaction advances a node through staged visual states.

**Strength:** production-safe, deterministic, easy to tune.

**Risk:** can feel like clicking props rather than digging.

### Option C — Hybrid
Use authored excavation cells with layered material states and local particles/debris. The player experiences digging, but the mine remains structured and saveable.

**Working recommendation:** prototype Option C first. It preserves the fantasy while avoiding a commitment to fully voxelized terrain.

## Tool progression

| Tier | Capability | Material gate | New decision |
|---|---|---|---|
| 0 | Hands | loose dirt/rubble | spend energy versus search carefully |
| 1 | Scoop/sifter | loose deposits | trade speed, capacity, and find quality |
| 2 | Hand tool / trowel | compacted debris/clay | choose efficient clearing versus thorough searching |
| 3 | Pickaxe | soft stone | decide whether to chase veins or open a route |
| 4 | Reinforced pick/drill | hard rock | manage energy, heat, noise, or collapse risk |
| 5 | Specialized tool | anomalous/temple materials | commit to endgame route and lore discoveries |

The exact tools are open. The important principle is that each tool should unlock a material relationship, not simply increase the same number.

## Production interpretation

The claim that the game will be “easy” because assets exist should remain a hypothesis to test, not a planning fact. Asset availability may reduce modeling time while leaving difficult work in:

- first-person interaction feel;
- excavation readability;
- save/load of mine state;
- economy pacing;
- progression gates;
- tension and collapse feedback;
- lore presentation;
- performance in many small debris/ore objects;
- store-quality polish and accessibility.

## Current status

This direction is strong enough to research and prototype as a concept packet. It is not yet approved as a replacement for the existing Mecha Paper Ratchet action-roguelite project.

See [[04 Contestation and Decision Log]] before treating any recommendation as a commitment.
