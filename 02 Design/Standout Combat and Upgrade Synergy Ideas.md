# Standout Combat and Upgrade Synergy Ideas

## Why this note exists
This is a **consideration note**, not an implementation plan.

The goal is to track how the current enemy roster, movement kit, and future upgrade system could combine into something that feels more surprising than a standard action roguelite.

## Strong rule to keep from day one
Tag every upgrade for the **game systems**, not just for player-facing sorting.

Example direction:

```yaml
id: gravity_well
type: Upgrade
rarity: Rare

tags:
  - gravity
  - ground_pound
  - crowd_control
  - combo
```

```yaml
id: magnet_wrench
type: Upgrade
rarity: Rare

tags:
  - gravity
  - wrench
```

The real value is not the labels themselves. The value is that the systems can use them.

## Why tags matter so early
If upgrades are tagged from the start, the game can later use those tags for:
- weighted reward offers
- enemy counterplay selection
- level-event generation
- special combo / fusion upgrades
- dynamic hint text
- achievement / milestone checks
- boss behavior adaptation
- run-summary storytelling

This means tags should be treated as **system hooks**, not flavor metadata.

## Related-game takeaways worth borrowing carefully
Using live reference info gathered this turn:

- **Hades** is a roguelike action RPG. The useful takeaway is not mythology specifically — it is the feeling of **build identity through layered boons** rather than only raw stat growth.
- **Risk of Rain 2** is a roguelike third-person shooter. The useful takeaway is **stacking item interactions and escalation through emergent combinations**, not just hand-authored moves.
- **Ratchet & Clank** is an action-adventure platform / third-person shooter series. The useful takeaway is **weapon personality** and readable toy-like spectacle.
- **Returnal** combines third-person shooter, bullet hell, and roguelike elements. The useful takeaway is **dense combat readability under pressure**, especially when projectiles and movement tools overlap.

## Best direction for this project
The standout opportunity is probably **not** to out-Hades Hades or out-Returnal Returnal.

The stronger angle is:

> expressive 3D action movement + weird comic-paper weapon interactions + upgrade tags that create surprising cross-mechanic behavior.

That gives the project a lane that feels more distinct.

## Potential wow-factor pillars

### 1. Weapon-paper transformation moments
Upgrades should not only modify numbers. Some should visibly change the move language.

Examples:
- boomerang splits into folded paper wings on return
- wrench spin leaves cutout silhouette trails
- ground pound stamps a comic-panel shockwave into the floor
- lock-on shot draws a temporary paper sightline ribbon through targets

### 2. Tag-driven combo upgrades
The most exciting upgrades may be the ones that appear only when tag conditions overlap.

Examples:
- `gravity` + `wrench` -> wrench pulls enemies inward before final hit
- `gravity` + `ground_pound` -> slam creates a vacuum ring before impact
- `boomerang` + `air` -> boomerang hangs briefly, then dives back through marked enemies
- `spin` + `mobility` -> spin attack slightly drifts / surfs forward through crowds
- `ground_pound` + `xp` -> slammed enemies burst XP outward, then it magnetizes back in

### 3. Enemy-role mixes that create puzzle-like pressure
The enemy list should not only expand horizontally. It should combine into small readable problems.

Examples:
- shield enemy protecting healer
- turret plus flyer creating crossfire angles
- tank plus sniper forcing movement commitment
- summoner plus bomber creating crowd panic if ignored
- healer behind shield wall while a skirmisher keeps distance

### 4. Paper-specific combat readability
To stand out visually, mechanics can use paper logic rather than generic VFX logic.

Examples:
- folds, tears, creases, pop-up silhouettes, comic onomatopoeia bursts
- enemies briefly flatten, wrinkle, or crumple during stagger
- shield enemies unfold cover-panels instead of spawning energy bubbles
- sniper aim could appear as a ruler-straight crease line across the arena

## Combinations from the current and proposed lists

### Enemy combinations worth trying later

#### Shield + Healer
- creates a simple priority puzzle
- player must flank, launch, or disrupt rather than only DPS front target

#### Flyer + Sniper
- flyer forces horizontal motion
- sniper punishes predictable strafing
- good for testing aerial awareness vs floor commitment

#### Tank + Summoner
- tank anchors space while summoner changes battlefield density
- strong miniboss escort pattern

#### Bomber + Shield
- shield buys the bomber time to close distance
- adds urgency without needing huge health pools

#### Turret + Healer
- player must choose whether to break sustain or remove fixed pressure first

#### Tank + Bomber + Healer
- potentially strong late-run bundle, but only if readability stays high

### Upgrade combinations worth planning for

#### `gravity` + `ground_pound`
- slam pull-in
- delayed crush pop
- enemies grouped for follow-up wrench combo

#### `gravity` + `wrench`
- wrench hits drag or pin enemies briefly
- returning boomerang passes collect enemies into its lane

#### `boomerang` + `combo`
- melee marks enemies, return path detonates marks
- encourages close-range setup before ranged payoff

#### `spin` + `crowd_control`
- spin attack pushes or gathers depending on branch
- creates distinct build identities: scatter build vs blender build

#### `air` + `mobility`
- midair dodge leaves a slice trail
- long jump converts into dive slash or aerial boomerang burst

#### `xp` + `combo`
- skillful chaining spawns more pickup bursts
- lets XP become part of combat expression instead of only post-kill cleanup

## Ideas outside the current list that may be stronger than expected

### Mark / detonate systems
One move marks, another cashes out.

Examples:
- wrench marks enemies with paper cuts
- boomerang return detonates marked targets
- ground pound consumes marks for a crowd burst

This is a strong wow-factor candidate because it makes basic actions feel like parts of a loop.

### Position-writing mechanics
Let attacks temporarily write geometry or lanes into the arena.

Examples:
- crease lines that speed the player if dashed along
- folded cover walls from a defensive upgrade
- sticky paper patches that slow enemies

### Enemy remix rules instead of only new enemies
Add rule modifiers to known enemies.

Examples:
- armored sniper
- healer flyer
- unstable tank that becomes bomber on low health
- summoner shield unit that only protects spawned adds

This can multiply variety faster than making every role from scratch.

### Stylish failure / recovery systems
A unique game often has memorable recovery, not just attack.

Examples:
- near-miss bonuses during bullet-heavy moments
- dodge-cancel windows into boomerang recall
- ground-pound landing that refreshes air options if it hits enough targets

### Meta-synergy offers without heavy meta progression
Even before permanent progression, runs could offer:
- tag-reactive upgrade offers
- “if you already have 2 gravity tags, surface 1 combo offer”
- “if run has too much single-target damage, bias one crowd-control option”

This would help runs feel authored without fixed scripts.

## Candidate standout signatures for this game specifically
If the game wants one or two memorable signatures, these feel promising:

### Signature A: Fold / Pull / Smash loop
- boomerang or wrench applies pull / gather
- player repositions with long jump or air dodge
- ground pound cashes out the cluster

### Signature B: Comic gadget chain
- weapon hits create readable setup states
- second tool re-routes or escalates them
- visual result feels toy-like, punchy, and improvised

### Signature C: Paper battlefield shaping
- combat temporarily changes lines, folds, cover, or movement surfaces
- makes the arena itself part of the combo language

## Tagging guidance to preserve flexibility
Suggested tag buckets:

### Weapon tags
- `wrench`
- `boomerang`
- `spin`
- `ground_pound`

### Function tags
- `gravity`
- `crowd_control`
- `combo`
- `projectile`
- `aoe`
- `mobility`
- `defense`
- `healing`
- `summon`

### Positional tags
- `air`
- `ground`
- `close_range`
- `long_range`

### Economy tags
- `xp`
- `cooldown`
- `luck`
- `stacking`

### Risk / style tags
- `glass_cannon`
- `setup`
- `payoff`
- `precision`
- `chaos`

## Caution
The project should avoid adding ten disconnected mechanics just because they sound cool.

The best additions will probably be the ones that:
1. reinforce the current movement/combat toybox
2. increase interaction density between existing moves
3. make enemy mixes more legible, not noisier
4. create a recognizable identity the player can describe in one sentence

## Best near-future prep
As we continue implementing mechanics, keep asking:
- what tags does this add?
- what existing tags can react to it?
- what enemy role would pressure this build in an interesting way?
- what visual paper/comic twist makes this feel less generic?
