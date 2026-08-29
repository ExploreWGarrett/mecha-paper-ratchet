---
title: Progression and Meta Loop Plan
project: Mecha Paper Ratchet
type: design
status: draft
tags:
  - '#mecha-paper-ratchet'
  - '#progression'
  - '#roguelite'
  - '#upgrades'
  - '#economy'
  - '#research-synthesis'
---

# Progression and Meta Loop Plan

## Why this note exists

This is the first progression plan for a Steam-targeted Godot 4.7 action roguelite. It is intentionally provisional and must not outrun the combat prototype. The current build already has a playable combat ladder, XP, money pickups, destructible crates, weapon scaffolding, and a `PlayerUpgrade` resource direction; this note turns those foundations into a staged plan.

Related implementation surfaces and system notes:

- `game/mecha-paper-wrench/scripts/player_upgrade.gd`
- `game/mecha-paper-wrench/scripts/main_level_controller.gd`
- `game/mecha-paper-wrench/scripts/money_pickup.gd`
- `game/mecha-paper-wrench/scenes/Main.tscn`
- [[03 Systems/Enemy and Upgrade Foundations]]
- [[03 Systems/Mutations Momentum and Unlock Journal]]
- [[03 Systems/Destructibles and Currency]]
- [[04 Prototype/Prototype-Code Link Map]]

## Evidence and interpretation

### Source-backed project evidence

- The project vision calls for short replayable runs, escalating pressure, temporary upgrades, and long-term unlocks.
- The current prototype reality says permanent progression is deliberately out of scope until combat feel is accepted.
- Existing inspiration notes favor recognizable proc packages, evolutions/unions/fusions, status families, cycle engines, ricochet/split packages, positional packages, and threshold transformations over a flat list of stat increases.
- The existing anti-exploit notes identify reward duplication, crate farming, state-transition abuse, and runaway projectile/recall/mark loops as risks.

### Working interpretation

The safest progression architecture is **three layers with different jobs**:

1. **Run power** creates moment-to-moment build identity.
2. **Discovery/journal progress** records what the player has found without automatically forcing permanent power inflation.
3. **Permanent unlocks** expand choices, characters, weapons, challenges, and presentation before they become raw damage multipliers.

## Proposed progression layers

### Layer A — Run progression: temporary build

The player enters with a starter kit, earns XP and reward choices, and assembles a build during one run.

First authored families should be concrete:

- wrench/boomerang behavior rewrites
- melee/ranged alternation rewards
- spin and ground-pound setup/payoff
- projectile cadence, pierce, ricochet, or split packages
- movement-refresh and air-combat packages
- survivability and recovery support
- economy and pickup utility

Each upgrade should have tags, stack rules, conditions, and a clear player-facing behavior change. Use `PlayerUpgrade` as the data bridge; keep effect execution modular rather than placing a large switch statement in the main player script.

### Layer B — Run milestones: mutations and fusions

Mutations should be authored recipes or threshold transformations, not merely higher rarity. A first implementation-ready shape could be:

- two compatible tags reach a threshold;
- the player receives a visible discovery/reward moment;
- the resulting effect changes a move or relationship;
- the journal records the discovery.

Fusions can be explicit reward offers, emergent tag results, or both. Do not implement all three at once. Start with one low-risk, highly readable route after the first upgrade family is fun.

Candidate early routes:

- wrench + boomerang: return-path or recall payoff
- melee + ranged: intentional alternation/cash-out
- spin + mobility: short vacuum or crowd-control window
- ground-pound + impact: landing setup/payoff

### Layer C — Between-run progression: unlocks and journal

The meta layer should first expand the possibility space:

- new weapons or starter kits
- alternate characters with different early weighting
- challenge modifiers and difficulty anchors
- journal entries and codex illustrations
- cosmetic paper/comic presentation
- new encounter families

Permanent numeric power can exist later, but it should be capped, audited, and less efficient than learning a better build. Avoid making the game require a grind wall before the core run can be fun.

## Proposed run flow

1. Choose an unlocked character/starter kit.
2. Enter a compact arena/room sequence.
3. Fight, dodge, break selected objects, and collect XP/money.
4. Choose a weighted upgrade or authored event reward.
5. Cross a room/wave milestone and face increased pressure.
6. Discover mutations/fusions when conditions are met.
7. Reach an elite, miniboss, or boss checkpoint.
8. Complete, fail, or abandon the run.
9. Convert only eligible rewards into journal entries/unlocks.
10. Review discoveries and choose the next starting option.

## Reward economy proposal

Keep currencies separate by job:

- **XP**: run-level growth and reward access.
- **Money/scrap**: immediate utility, shops, repair, or authored crate value.
- **Journal/discovery flags**: records and unlock conditions, not spendable power.

Do not let a destructible crate become a safe, repeatable source of unlimited run power. Reward value should depend on risk, opportunity cost, and room pacing.

## Anti-exploit gates

Before expanding the system, test:

- reward popup opening twice across pause/replay/restart;
- duplicate conversion of XP, money, or discovery flags;
- crate farming that is safer than fighting;
- self-refreshing cooldown or mutation loops;
- projectile count, ricochet, split, and recall multiplication;
- mark/cash-out loops that produce more value than their setup requires;
- death/restart transitions that preserve rewards incorrectly;
- unlock conditions firing more than once or before their event is valid.

## Staged implementation plan

### Stage 0 — Current combat gate

**Goal:** prove the baseline wrench/Popper combat sentence and readability.

Out of scope: permanent power, procedural rooms, a full shop, multiple characters, and a large mutation catalogue.

### Stage 1 — One run reward slice

Add one reward choice screen and 6–10 upgrades across two concrete families. Persist run state only. Telemetry should record seed, offered IDs, picked ID, stack counts, and death/finish state.

### Stage 2 — One mutation route

Add one visible two-tag mutation with a journal entry. Verify the mutation is understandable without reading external documentation.

### Stage 3 — Discovery journal

Add a lightweight codex/log that records weapons, upgrades, tags, mutations, and unlock source text. It can initially be a read-only menu.

### Stage 4 — Choice-expanding meta unlocks

Add one alternate starter kit, one weapon unlock, and one challenge modifier. Do not add a permanent damage tree until the run loop survives repeated playtests.

### Stage 5 — Steam-facing retention layer

Only after the core loop has repeat value: achievements, cloud-save decisions, settings/accessibility coverage, demo/branch packaging, and release-facing progression communication.

## Open questions for questionnaire review

- Is the primary reward XP choice, shop choice, or room-choice routing?
- Should money be run-only, meta-spendable, or split into two currencies later?
- Are mutations discoverable by play or clearly hinted?
- How much permanent power is acceptable?
- Is a run a fixed room ladder or a branching route?
- Which weapon is the first authored progression authority: wrench, Paper Popper, or a different starter?

## Related concept branch

A separate source blast proposes a mining/incremental branch that reuses the Callous and Grit ideas in a hands-first labor loop. It is documented separately and remains unapproved:

- [[02 Design/Yearn for the Mines/00 Direction Blast - Source Capture]]
- [[02 Design/Yearn for the Mines/01 Concept Expansion]]
- [[02 Design/Yearn for the Mines/02 Progression Economy and Prestige]]
- [[02 Design/Yearn for the Mines/04 Contestation and Decision Log]]

## Decision status

Nothing in this note is implementation-approved until [[01 Vision/Development Kickoff Questionnaire]] is reviewed and the readiness gate is re-run.
