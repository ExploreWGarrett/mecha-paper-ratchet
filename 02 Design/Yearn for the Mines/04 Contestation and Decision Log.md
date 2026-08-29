---
title: Yearn for the Mines - Contestation and Decision Log
project: Yearn for the Mines
parent-project: Mecha Paper Ratchet
type: contestation
status: active
tags:
  - '#yearn-for-the-mines'
  - '#contestation'
  - '#decision-log'
  - '#scope'
  - '#risk'
---

# Yearn for the Mines — Contestation and Decision Log

## Related notes

- [[02 Design/Yearn for the Mines/00 Direction Blast - Source Capture]]
- [[02 Design/Yearn for the Mines/01 Concept Expansion]]
- [[02 Design/Yearn for the Mines/02 Progression Economy and Prestige]]
- [[02 Design/Yearn for the Mines/03 Lore, Child Labor, and Endings]]
- [[02 Design/Yearn for the Mines/05 Build Evidence Log]]


Use the statuses:

- **source:** directly stated in the direction blast;
- **proposal:** expanded by the agent for review;
- **open:** unresolved;
- **accepted:** explicitly chosen by the project owner;
- **rejected:** intentionally not pursued;
- **parked:** valuable but deferred.

## Claim: “It will be easy because assets already exist.”

**Status:** open / contested

Existing HUDs, overlays, props, and first-person assets may reduce asset creation time. They do not prove that the interaction model, digging feedback, terrain persistence, economy, save system, collapse events, lore delivery, or Steam-ready polish will be easy.

**Test:** build a one-room vertical slice using temporary assets and measure the actual work required for one satisfying excavation loop.

## Claim: “It is an easy cash grab for the incremental market.”

**Status:** contested

Incremental games can have simple visible loops, but players still expect satisfying numbers, meaningful decisions, stable pacing, quality-of-life automation, readable feedback, and enough content to justify continued play. Designing only for a cash grab risks shallow progression, poor trust, and weak retention.

**Alternative framing:** a compact, honest incremental mining game with a strong tactile hook and a distinct mystery.

## Claim: “First-person is definitely correct.”

**Status:** proposal / open

First-person strongly supports hand labor, material inspection, and immersion. It also raises camera comfort, interaction precision, animation, visibility, and motion-sickness requirements.

**Test:** compare first-person interaction against a close third-person or floating-camera mockup before building the whole mine around one camera assumption.

## Claim: “Start with hands.”

**Status:** proposal / strong candidate

Hands create a powerful before/after tool progression and support Callous as an early meaningful upgrade. The opening must be brief, tactile, and generous.

**Failure condition:** the player performs slow repetitive actions without discovering or buying something interesting within the first few minutes.

## Claim: “Purchasing tools is more fun than finding them.”

**Status:** proposal / open

Purchases reinforce the incremental market loop; finds reinforce exploration. A hybrid can preserve purchases as the capability gate while making rare discoveries alter the quality or route of the next purchase.

**Decision needed:** whether the game wants a shop-driven incremental identity, an exploration-driven identity, or a deliberate mix.

## Claim: “Rock requires a better tool.”

**Status:** proposal / strong candidate

Material gates are easy to understand and give the player visible goals. They become boring if every new layer only says “buy a bigger number.” Each tier should introduce a new action, risk, information problem, or route choice.

## Claim: “Mine collapses several times for prestige.”

**Status:** proposal / strong candidate

This gives the game a natural reset and token economy. It can also become a frustrating forced wipe or a shallow rebirth loop.

**Guardrail:** collapse must be telegraphed, narratively meaningful, and paired with persistent choices that expand options rather than only adding power.

## Claim: “The two endings are mine collapse and temple discovery.”

**Status:** source / open

These are strong visual anchors. They need mechanical definitions: when can each happen, what does the player do to reach them, and does the temple challenge the extraction loop or simply reward it?

## Claim: “Secret child-labor lore.”

**Status:** source / sensitive open

This can provide serious depth beneath a familiar incremental loop, but it should be handled deliberately. The subject should not become a punchline or cheap shock collectible layer.

**Approval gate:** define tone, audience, content presentation, and the player’s relationship to the institution before implementing the reveal.

## Major architectural contest: project identity

The direction blast describes a first-person incremental mining game, while the current project contains a playable third-person paper-comic action roguelite prototype under the Mecha Paper Ratchet name.

**Status:** unresolved project-level decision

Possible outcomes:

1. **Pivot:** Yearn for the Mines replaces Mecha Paper Ratchet as the main game.
2. **Spin-off:** Yearn for the Mines becomes a separate Godot project with its own vault area.
3. **Shared universe:** both projects remain separate games with linked lore only.
4. **Prototype branch:** build a tiny Yearn for the Mines test before deciding.

**Working recommendation:** treat Yearn for the Mines as a documented spin-off/prototype branch until a direct project decision is made. Do not overwrite the existing action prototype or its documentation.

## Decision table

| Topic | Current status | Next evidence needed |
|---|---|---|
| First-person camera | open | 10-minute interaction prototype |
| Hands-first opening | strong candidate | tactile excavation test |
| Bucket start | parked alternative | compare against hands in playtest |
| Tool purchases | strong candidate | economy pacing test |
| Tool discoveries | supporting possibility | decide hybrid role |
| Collapse prestige | strong candidate | reset/reward loop test |
| Temple ending | open | ending function and route definition |
| Child-labor lore | sensitive open | tone and content treatment review |
| Existing assets make it easy | rejected as assumption | vertical-slice effort measurement |
| Separate game or pivot | unresolved | project-owner decision after concept prototype |

## Review rule

New implementation proposals for this concept must link back to this note and state which contested claim they rely on. If a build disproves a claim, update this note rather than quietly patching around the contradiction.
