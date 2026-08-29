# Mutations, Momentum, and Unlock Journal

## Why this note exists
This note captures the next layer of run-identity thinking before the full upgrade system lands.

The current combat toybox is starting to support more than simple stat growth. The next useful question is how upgrades, character starts, and run-state meters can create new decisions instead of only larger numbers.

## Core rule to preserve
When evaluating a future upgrade, ask:

> Does this create a new combat decision, or does it only make the number bigger?

Big numbers still matter. They feel good. But the stronger direction for this project is:
- exciting interaction first
- number growth second
- very large numbers as the result of interesting interactions, not as the only reward loop

## Stacking direction
The long-term system should support effectively infinite stacking, but not in the laziest possible way.

### Two promising balancing models
#### 1. Diminishing-return stacks
Each additional copy still helps, but the slope softens.

Examples:
- first 3 fire-rate stacks feel dramatic
- stacks 4 to 8 still matter, but less
- later stacks become refinement, not total takeover

This keeps favorite upgrades pickable forever without letting one linear stack erase all build tension.

#### 2. Escalating-difficulty pressure
The player can keep taking powerful stackable upgrades, but run pressure grows with them.

Examples:
- rarer offers appear later and are stronger but narrower
- enemy behavior responds to build intensity
- difficulty pressure rises as the player accumulates especially efficient tags

This fits the prototype's new difficulty-slider direction because the game can later treat player power and encounter pressure as two linked dials.

### Best hybrid for now
The best likely route is a hybrid:
- allow effectively infinite stacking
- use mild diminishing returns on the most obviously linear upgrades
- use difficulty / encounter pressure / rarity weighting to keep the run honest

## Mutation concept
A strong way to keep upgrades feeling fresh is to let some of them **mutate** when paired with other tags or when stacked deeply enough.

### What a mutation should mean
A mutation is more than a higher tier.

It should mean one of these:
- a move changes behavior
- a familiar action gains a new rule
- one upgrade reinterprets another upgrade's output
- a standalone effect becomes part of a loop

### Mutation triggers worth planning around
- tag pair thresholds
- tag trio recipes
- reaching a stack count
- meeting a style / momentum threshold
- specific weapon + movement combinations
- character-specific early bias paths

### Mutation examples
#### Boomerang / wrench mutations
- repeated `boomerang + combo` stacks mutate into a return-path detonation rule
- `boomerang + air` mutates the return into a hanging dive-through attack
- `wrench + gravity` mutates hits into short pull bursts before impact

#### Mobility / slam mutations
- `ground_pound + momentum` mutates landing into a stored shockwave if style is high enough
- `air + mobility + combo` mutates long-jump chains into follow-up slice trails

#### Weapon mutations
- sustained `pistol + projectile + stacking` mutates into cadence states rather than only more DPS
- `pistol + mark + melee` mutates into a cash-out sidearm that wants alternating ranged and close attacks

## Momentum / Flow / Style / Overdrive direction
A momentum-style meter is promising because it can reward expressive play without requiring permanent progression.

This system could eventually be named:
- Momentum
- Flow
- Style
- Overdrive
- Rhythm
- Charge
- Adrenaline

### Recommendation for now
Use **Momentum** as the neutral working name in system notes until the combat feel makes a stronger flavor obvious.

### Current caution / feedback note
There are now **mixed feelings** about the Momentum direction as a centerpiece.

That means the safest near-term move is:
- keep Momentum as a possible support system
- stop treating it as the next main design driver
- make sure weapon upgrades, mutations, and fusion loops are already fun without needing Momentum to justify them

If Momentum comes back later, it should amplify already-good weapon interactions rather than carry them.

## What Momentum should reward
Momentum should rise when the player keeps doing interesting things under pressure.

### Earn Momentum by
- staying airborne
- juggling enemies
- perfect dodges
- long combos
- hitting multiple enemies with one throw
- recalling the wrench through several enemies
- alternating melee and ranged attacks
- killing enemies quickly

### Lose Momentum by
- getting hit
- standing still too long
- waiting too long between offensive actions
- whiffing repeatedly / missing attacks too often

## What Momentum can do
Momentum should not only be a score meter.

It should act as a system hook.

### Possible uses
- unlock mutation thresholds during a run
- boost pull / combo / launch effects before boosting raw damage
- improve reward weighting toward expressive upgrades
- power temporary overdrive windows
- alter enemy-drop bursts or money / XP magnet behavior
- refresh movement options on stylish play

### Important caution
Do not let Momentum become mandatory busywork.

The player should feel invited to play stylishly, not punished for every cautious second.

## Alternate character routes
A later multi-character structure can stay weapon-flexible while still changing the path into power.

### Shared rule
All characters can eventually use every weapon.

The difference is how they get there.

### Character B — The Ranger
Starts with:
- spear
- longer dodge
- increased projectile velocity
- early ranged-upgrade weighting

Likely identity:
- reaches ranged and spacing tools earlier
- better at keeping Flow / Momentum alive through chaining movement and projectiles
- wants projectile, mobility, precision, and combo tags early

### Character C — The Brawler
Starts with:
- hammer
- ground-pound bonus
- armor
- knockback

Likely identity:
- reaches slam / crowd-control / armor loops earlier
- wants impact, stagger, ground, payoff, and survivability tags early
- more likely to build momentum through disruption and heavy confirm windows than clean spacing

### Current default character implication
The current baseline character can remain the all-rounder route.

That gives the future roster three understandable arcs:
- all-rounder / gadget baseline
- ranger / spacing route
- brawler / impact route

## Unlock journal / combat log direction
Eventually the player should have a way to inspect what exists and what they have unlocked.

### Journal goals
The journal should answer:
- what weapons exist?
- what upgrades exist?
- what tags exist?
- what has been unlocked so far?
- how was it unlocked?
- which character or route surfaced it first?

### Good first data shape
Each journalable entry should be able to store:
- id
- type
- name
- short description
- tags
- unlock state
- unlock source
- unlock conditions
- first-seen run metadata later if needed

### Unlock-source examples
- reached 50 total XP in one run
- defeated miniboss for the first time
- picked 3 `boomerang` upgrades in one run
- maintained Momentum tier 3 for N seconds
- completed a run with Character B

### Why this matters early
If unlock conditions are tracked from the beginning, the game can later explain discovery instead of forcing the player to remember obscure triggers.

## Upgrade philosophy checkpoints
Before adding any new upgrade, ask:
1. does it create a fresh decision in combat?
2. does it combine with at least one existing tag?
3. does it make a known move read differently?
4. could it mutate later?
5. would it still be interesting if the raw number gain were cut in half?

If the answer is no across the board, the upgrade probably needs a more interactive hook.

## Strong early implementation bias
As upgrades start landing for real, bias toward these categories before deep stat stacks:
- route-changing boomerang upgrades
- melee/ranged alternation rewards
- crowd-control / launch / gather interactions
- movement-refresh effects tied to good play
- momentum thresholds that unlock temporary behavior changes

## Near-future system questions
- should Momentum decay smoothly, by chunks, or by tier thresholds?
- should mutations be permanent once earned in a run, or active only while their conditions are met?
- should alternate characters bias rewards only, or also bias the global unlock pool?
- when should the journal show locked silhouettes versus explicit missing entries?
- which stack-heavy upgrades deserve diminishing returns first: fire rate, projectile count, pull strength, armor, or economy?

## Practical next step guidance
When the first true upgrade batch is implemented:
1. give every upgrade system-facing tags immediately
2. let at least one upgrade family stack past a normal cap
3. make at least one mutation come from tag overlap, not rarity alone
4. add a lightweight Momentum variable before making a full UI meter if needed
5. record unlock source strings from the first unlock onward so the future journal can explain itself
