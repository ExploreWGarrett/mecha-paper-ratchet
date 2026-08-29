---
title: Project Vision
project: Mecha Paper Ratchet
type: vision
status: active
tags:
  - '#mecha-paper-ratchet'
  - '#vision'
  - '#combat'
  - '#paper-comic'
---

# Mecha Paper Ratchet

## Project Summary

**Mecha Paper Ratchet** is a solo-developed 2.5D / 3D roguelite action game concept that combines:

- **Ratchet & Clank-style combat**
    
- **Paper Mario-inspired visuals**
    
- **Megabonk / Risk of Rain 2-style roguelike scaling**
    
- **Comic-book dialogue, item descriptions, and visual effects**
    
- **Simple but expressive solo-dev-friendly art constraints**
    

The goal is to create a game with fast, fun, lock-on ranged combat, acrobatic movement, weird weapons, procedural replayability, and a distinct paper-comic identity.

The game should feel ambitious in play but simplified in production.

---

# Core Pitch

A paper-comic third-person roguelite where flat 2D characters battle through chunky 3D arenas and modular dungeon rooms using lock-on strafing, flip jumps, hover falls, spin dodges, melee attacks, ground pounds, and ridiculous upgradeable ranged weapons.

Runs scale in intensity over time. Players earn temporary upgrades during each run and unlock long-term bonuses, weapons, characters, and content through continued play.

---

# Design Pillars

## 1. Combat First

The game should be built around a strong combat prototype before anything else.

The most important early goal:

> Make one flat paper character lock onto one enemy, strafe, jump, dodge projectiles, and shoot in a way that feels fun.

Everything else should grow from that.

Core combat mechanics:

- Lock-on targeting
    
- Strafe movement around target
    
- Ranged weapon combat
    
- Melee attack
    
- Ground pound
    
- Double jump
    
- Flip jump animation
    
- Hover fall
    
- Spin dodge
    
- Projectile dodging
    
- Destroyable objects
    
- Currency and upgrade drops
    

---

## 2. Simple but Distinct Visual Style

The game should use a simplified art style that supports solo development.

Visual direction:

- 3D world
    
- Simple low-poly environments
    
- Flat 2D paper-style character sprites
    
- Simple 2D or billboarded animations
    
- 3D or 3D-like projectiles
    
- Paper cutout / cardboard / comic-book vibe
    
- Chunky toybox-like arenas
    
- Big comic impact words like **BOOM**, **WHAM**, **CLANK**, **ZAP**, **BONK**
    

The art should be expressive, not realistic.

The target look:

> Flat animated paper cutout characters moving through chunky 3D toybox arenas with comic-book hit effects, goofy weapon names, and exaggerated projectile chaos.

---

## 3. Roguelike Replayability

The game should have short-to-medium runs with escalating difficulty, random upgrades, and long-term unlocks.

Run structure:

1. Choose character
    
2. Start with character’s starter weapon
    
3. Enter arena or dungeon room
    
4. Fight enemies
    
5. Break objects for currency, health, ammo, or scrap
    
6. Earn upgrade choices
    
7. Move to the next room or wave
    
8. Difficulty scales with time, room count, or wave count
    
9. Fight elites, bosses, or challenge rooms
    
10. Die or complete the run
    
11. Spend long-term rewards on unlocks or progression
    

---

# Target Inspirations

## Ratchet & Clank

Borrow:

- Lock-on combat feel
    
- Strafe movement
    
- Ranged weapon focus
    
- Double jumps
    
- Hovering / falling control
    
- Goofy weapon personality
    
- Fast readable action
    

Do not try to copy:

- Full 3D character production quality
    
- Huge cinematic campaign
    
- Large hand-built worlds
    

---

## Paper Mario

Borrow:

- Flat paper characters
    
- Simple but charming world design
    
- Stage-like environments
    
- Comic visual language
    
- Readable silhouettes
    
- Low-detail but high-personality art
    

Do not try to copy:

- Turn-based combat
    
- RPG menu-heavy structure
    

---

## Megabonk

Borrow:

- Goofy chaos
    
- Simple world geometry
    
- Fast upgrade-driven gameplay
    
- Enemy pressure
    
- Readability over realism
    

---

## Risk of Rain 2

Borrow:

- Scaling difficulty over time
    
- Randomized upgrades
    
- Run-based power growth
    
- Increasing enemy pressure
    
- Character identity through abilities and starter kits
    

---

# Player Character Design

## Character Body

The character should have two layers:

### Visual Body

- 2D animated sprite
    
- Paper cutout style
    
- Always readable from the gameplay camera
    
- Can use simple frame animation or sprite swapping
    

### Collision Body

- Slim cylinder, capsule, or rectangular hitbox
    
- Designed to make dodging projectiles skill-based
    
- Narrow enough that movement and positioning matter
    

---

# Unique Dodge / Spin Mechanic

One key identity feature:

> The player has a slim body shape and can use a spin move to dodge through projectile patterns.

Possible spin dodge behavior:

- Temporarily narrows the hitbox
    
- Rotates the vulnerable profile
    
- Gives a brief dodge window
    
- Deflects weak projectiles
    
- Charges a counterattack when near-missing bullets
    
- Triggers character-specific effects
    

This mechanic can help the game feel different from other roguelikes.

---

# Core Player Moveset

Base movement:

- Walk / run
    
- Lock-on strafe
    
- Jump
    
- Double jump
    
- Flip jump animation
    
- Hover fall
    
- Spin dodge
    
- Dash or evasive burst, optional
    
- Ground pound
    

Base combat:

- Primary ranged weapon
    
- Melee attack
    
- Ground pound attack
    
- Lock-on shooting
    
- Free aim or soft aim, optional
    
- Weapon swapping, later
    
- Ability cooldowns, later
    

---

# Player State List

Possible player states:

- Idle
    
- Run
    
- Lock-on strafe
    
- Jump
    
- Double jump
    
- Hover fall
    
- Spin dodge
    
- Shoot
    
- Melee
    
- Ground pound
    
- Hit stun
    
- Death
    
- Upgrade selection
    
- Room transition
    

---

# Weapons

Weapons should be ranged, weird, readable, and upgradeable.

The game’s personality should come through the weapons.

## Starter Weapon Examples

### Rivet Popper

Basic fast projectile weapon.

### Staple Sprayer

Short-range shotgun burst.

### Glue Globber

Fires slow blobs that damage and slow enemies.

### Cardboard Cutter

Boomerang-style slicing projectile.

### Punchline Cannon

Delayed explosive projectile with comic impact text.

### Ink Hose

Short-range stream weapon.

### Rubber Band Repeater

Bouncy ricochet projectile weapon.

### Confetti Mortar

Arcing explosive area weapon.

### Panel Breaker

Piercing beam shaped like a comic panel.

---

# Upgrade System

The game should have two types of progression:

1. **Run upgrades**
    
2. **Long-term unlocks**
    

---

## Run Upgrades

These are earned during a run and reset after death.

Possible upgrade examples:

- Increased projectile speed
    
- Increased fire rate
    
- More damage
    
- More melee range
    
- More jump height
    
- Longer hover fall
    
- Shorter spin dodge cooldown
    
- Spin dodge creates sparks
    
- Ground pound creates shockwave
    
- Melee causes knockback
    
- Bullets ricochet
    
- Bullets split
    
- Bullets pierce
    
- Shots explode on impact
    
- Shots leave ink puddles
    
- Currency magnet
    
- Destroyables drop more scrap
    
- Lock-on shots chain to nearby enemies
    
- Near-miss dodges build bonus damage
    
- Low health increases fire rate
    
- Ground pound launches enemies upward
    
- Hovering increases accuracy
    

---

## Long-Term Progression

Long-term progression should mostly unlock new options instead of giving too much raw power.

Good long-term rewards:

- New characters
    
- New starter weapons
    
- New upgrade cards
    
- New enemy types
    
- New room types
    
- New comic issues / chapters
    
- New cosmetics
    
- New difficulty modifiers
    
- New challenge modes
    

Use permanent stat upgrades carefully. Too many permanent bonuses can make early runs boring.

---

# Characters

Each character should share the same base controller but differ through:

- Starter weapon
    
- Melee style
    
- Ground pound effect
    
- Spin dodge effect
    
- Passive trait
    
- Visual theme
    
- Personality / comic voice
    

---

## Example Character: Scrap Kid

Starter weapon: **Rivet Popper**

Passive:

- Destroyables drop extra scrap
    

Melee:

- Wrench swing
    

Ground pound:

- Metal shockwave
    

Spin dodge:

- Sparks fly off the character and damage nearby enemies
    

Personality:

- Scrappy inventor, overconfident, talks to broken machines
    

---

## Example Character: Ink Witch

Starter weapon: **Ink Blaster**

Passive:

- Projectiles leave damaging ink puddles
    

Melee:

- Brush swipe
    

Ground pound:

- Ink splash
    

Spin dodge:

- Turns into a smear of ink briefly
    

Personality:

- Dramatic, artsy, sarcastic
    

---

## Example Character: Cardboard Knight

Starter weapon: **Folded Lance Launcher**

Passive:

- Stronger melee and knockback
    

Melee:

- Folded sword slash
    

Ground pound:

- Paper quake cone
    

Spin dodge:

- Folds sideways to avoid damage
    

Personality:

- Noble, ridiculous, takes everything too seriously
    

---

## Example Character: Battery Gremlin

Starter weapon: **Arc Zapper**

Passive:

- Gains bonus damage after dodging projectiles
    

Melee:

- Electric claw swipe
    

Ground pound:

- Electric burst
    

Spin dodge:

- Leaves a short lightning trail
    

Personality:

- Hyperactive, unstable, probably chewing wires
    

---

# Enemies

Start with simple enemy behaviors.

## Enemy Types

### Chaser

Runs toward the player and attacks in melee.

### Shooter

Keeps distance and fires basic projectiles.

### Lobber

Throws arcing projectiles.

### Shield Enemy

Blocks attacks from the front.

### Exploder

Runs toward the player and detonates.

### Flying Pest

Small flying enemy that harasses the player.

### Turret

Stationary ranged enemy.

### Elite Variant

Stronger version of a normal enemy with extra health, damage, or special attacks.

---

## Enemy Theme Ideas

- Crumpled paper goblins
    
- Binder clip bugs
    
- Ink blobs
    
- Staple spiders
    
- Cardboard brutes
    
- Rubber stamp turrets
    
- Paper shredder mini-boss
    
- Sticky note bats
    
- Tape roll rollers
    
- Correction fluid slimes
    
- Scissor knights
    

---

# Map Design

The game can support two major map styles.

---

## Arena Mode

This should be the first prototype mode.

Arena mode is simpler because the player stays in one space while waves spawn.

Arena elements:

- One open combat room
    
- Enemy spawn points
    
- Destroyable objects
    
- A few obstacles
    
- Currency drops
    
- Upgrade choice after clearing waves
    
- Difficulty increases each wave
    

First arena goal:

> Survive 10 enemies, pick 1 of 3 upgrades, then fight a harder wave.

---

## Dungeon Mode

Dungeon mode should come later.

Use procedural assembly, not fully procedural generation.

The best solo-dev method:

- Hand-build room chunks
    
- Give each room entrance and exit points
    
- Randomly connect compatible rooms
    
- Add enemy spawn points
    
- Add destroyable spawn points
    
- Add reward rooms
    
- Add challenge rooms
    
- Add shop rooms
    
- Add boss rooms
    
- Scale enemy budget by time, difficulty, or room count
    

This keeps the game replayable while avoiding the complexity of fully generated levels.

---

# Room Types

Possible room types:

- Combat room
    
- Treasure room
    
- Upgrade room
    
- Shop room
    
- Challenge room
    
- Elite room
    
- Boss room
    
- Rest room
    
- Hazard room
    
- Mini-game room
    
- Secret room
    

---

# Destroyables

Destroyables should be part of the economy and combat flow.

Examples:

- Cardboard boxes
    
- Paper crates
    
- Ink jars
    
- Scrap piles
    
- Coin stacks
    
- Barrels
    
- Tape rolls
    
- Prop machines
    
- Stage lights
    
- Comic signs
    

Drops:

- Currency
    
- Health
    
- Ammo or energy
    
- Temporary buffs
    
- Scrap
    
- Rare upgrade fragments
    

---

# Currency

Possible currency names:

- Scrap
    
- Clips
    
- Bolts
    
- Doodles
    
- Ink
    
- Punchlines
    
- Panels
    
- Tokens
    
- Shreds
    

Best simple option:

> Scrap

Scrap can be earned from enemies, destroyables, challenge rooms, and bosses.

---

# Tone and Writing Style

The writing should have a comic-book vibe.

Descriptions and dialogue should be:

- Funny
    
- Punchy
    
- Slightly ridiculous
    
- Short
    
- Characterful
    
- Easy to read during gameplay
    

Example item description style:

> **Staple Sprayer**  
> Office supplies were never meant to be this personal.

> **Glue Globber**  
> Slows enemies, ruins carpets, and makes everyone uncomfortable.

> **Rivet Popper**  
> A reliable little blaster for people who think safety goggles are optional.

> **Cardboard Cutter**  
> Folds enemies like bad instructions.

---

# UI Style

The UI should feel like a comic book.

Ideas:

- Speech bubbles
    
- Upgrade cards
    
- Comic panel borders
    
- Halftone textures
    
- Impact words
    
- Big readable icons
    
- Paper tabs
    
- Torn cardboard menus
    
- Hand-drawn arrows
    
- Exaggerated damage numbers
    

Upgrade selection could look like choosing between comic panels or trading cards.

---

# Camera

Possible camera style:

- Third-person follow camera
    
- Slightly elevated angle
    
- Lock-on camera behavior during combat
    
- Camera keeps target and player readable
    
- Avoid overly cinematic camera movement
    
- Prioritize gameplay clarity
    

Camera must make projectile dodging readable.

---

# Technical Direction

Recommended engine options:

## Godot 4

Good reasons to use Godot:

- Strong for solo development
    
- Good 2D / 3D hybrid support
    
- Lightweight
    
- Fast iteration
    
- Simple scripting
    
- Good for prototype-heavy development
    

## Unity

Good reasons to use Unity:

- More third-person controller examples
    
- More asset store tools
    
- More tutorials
    
- Stronger 3D ecosystem
    

Current likely choice:

> Godot 4 is probably the best starting point unless Unity becomes necessary.

---

# Development Strategy

Do not start by making the whole game.

Start with a combat toybox.

---

## Prototype 0.1 — Combat Toybox

Goal:

> One arena, one player, one enemy, one weapon, basic lock-on combat.

Features:

- Basic 3D arena
    
- Flat paper player sprite
    
- Player movement
    
- Lock-on targeting
    
- Strafe movement
    
- Shooting
    
- One enemy
    
- Enemy health
    
- Player health
    
- Simple projectile
    
- Enemy death
    

---

## Prototype 0.2 — Movement Kit

Add:

- Double jump
    
- Flip jump
    
- Hover fall
    
- Spin dodge
    
- Melee attack
    
- Ground pound
    

Goal:

> Movement and combat should start feeling fun before adding roguelike systems.

---

## Prototype 0.3 — Basic Run Loop

Add:

- Enemy waves
    
- Currency drops
    
- Destroyables
    
- Upgrade choice after wave
    
- Difficulty increase per wave
    

Goal:

> Kill enemies, collect scrap, pick upgrades, survive harder waves.

---

## Prototype 0.4 — Enemy Variety

Add:

- Chaser enemy
    
- Shooter enemy
    
- Lobber enemy
    
- Exploder enemy
    
- Simple elite variant
    

Goal:

> Create variety through enemy behavior, not complex art.

---

## Prototype 0.5 — Weapon Variety

Add:

- 3 to 5 weapons
    
- Weapon pickups or unlocks
    
- Basic weapon upgrade effects
    

Goal:

> Make weapons feel funny, different, and useful.

---

## Prototype 0.6 — Room Progression

Add:

- Room transitions
    
- Reward rooms
    
- Shop room
    
- Challenge room
    
- Boss or elite room
    

Goal:

> Move from wave survival to run structure.

---

## Prototype 0.7 — Procedural Room Assembly

Add:

- Modular rooms
    
- Random room order
    
- Entrance / exit matching
    
- Spawn point rules
    
- Difficulty budget
    

Goal:

> Make runs feel different without building fully procedural worlds.

---

## Prototype 0.8 — Long-Term Unlocks

Add:

- Unlock new characters
    
- Unlock new weapons
    
- Unlock new upgrade cards
    
- Unlock new enemy types
    
- Basic meta currency
    

Goal:

> Give players a reason to keep playing.

---

## Prototype 0.9 — Style Pass

Add:

- Comic UI
    
- Dialogue bubbles
    
- Item descriptions
    
- Impact words
    
- Better VFX
    
- Sound effects
    
- Music direction
    

Goal:

> Make the game feel like itself.

---

# First Build Goal

The first real development milestone should be extremely focused:

> A paper character in a simple 3D arena can lock onto an enemy, strafe, jump, shoot, dodge one projectile, and defeat the enemy.

If that feels fun, continue.

If that does not feel fun, fix that before adding upgrades, maps, or progression.

---

# Prototype Direction Update

Current playable direction:

- Start with a visually bare-bones circular arena.
- Default character uses a very slim rectangular hitbox to preserve a paper-sprite feel.
- Default starting combat is melee-first rather than ranged-first.
- Movement and combat should intentionally fuse inspirations from **Ratchet & Clank** and **Jak and Daxter**.
- First moveset target includes:
  - melee slash combo
  - crouch attack boomerang throw
  - crouch jump high jump
  - crouch forward jump long jump
  - spin melee attack
  - midair attack ground pound
  - crouch-forward roll
- First enemy should support default lock-on and simple back-and-forth movement.

---

# Major Risks

## Scope Creep

Biggest danger:

Trying to build too much at once.

Avoid starting with:

- Multiple characters
    
- Full procedural dungeons
    
- Dozens of weapons
    
- Boss fights
    
- Permanent progression
    
- Dialogue systems
    
- Large maps
    
- Complex art pipeline
    

Build the core first.

---

## Combat Feel

The whole game depends on combat feel.

Priority order:

1. Movement
    
2. Camera
    
3. Lock-on
    
4. Shooting
    
5. Dodging
    
6. Enemy attacks
    
7. Hit feedback
    
8. Upgrades
    

---

## Visual Readability

The art style must not interfere with gameplay.

Make sure:

- Projectiles are readable
    
- Enemies are readable
    
- Player hitbox feels fair
    
- Lock-on target is obvious
    
- Damage feedback is clear
    
- The camera does not hide threats
    

---

# Open Questions

## Game Feel

- Should the game be closer to third-person shooter or arena action platformer?
    
- Should shooting require aim, lock-on, or both?
    
- Should lock-on be hard lock, soft lock, or toggle lock?
    
- Should spin dodge give invulnerability, hitbox narrowing, deflection, or all three?
    

## Visual Design

- Should characters always face the camera like paper sprites?
    
- Should sprites rotate in 3D space like Paper Mario characters?
    
- Should enemies also be paper sprites?
    
- Should projectiles be 3D meshes, billboard sprites, or both?
    

## Progression

- How much permanent progression is healthy?
    
- Should long-term progression unlock content instead of raw stats?
    
- Should runs be 10 minutes, 20 minutes, or longer?
    
- Should difficulty scale by time, rooms cleared, or player upgrades?
    

## Map Design

- Should the first version be arena-only?
    
- Should dungeon rooms be connected linearly or branching?
    
- Should the player choose the next room type?
    
- Should rooms be handcrafted modules assembled procedurally?
    

---

# Immediate Next Steps

1. Choose engine: Godot 4 or Unity.
    
2. Create a tiny test arena.
    
3. Create a flat placeholder player sprite.
    
4. Add a simple 3D collision body.
    
5. Add basic movement.
    
6. Add camera follow.
    
7. Add lock-on target selection.
    
8. Add strafing around target.
    
9. Add one enemy.
    
10. Add one projectile weapon.
    
11. Add one enemy projectile attack.
    
12. Test whether dodging and shooting feel fun.
    

---

# Current Project Mantra

> Combat first.  
> Paper style for simplicity.  
> Weird weapons for personality.  
> Procedural assembly, not procedural chaos.  
> Build one fun room before building a whole game.

---

# Related Notes To Create Later

- [[Combat Prototype]]
    
- [[Player Controller]]
    
- [[Lock-On System]]
    
- [[Spin Dodge Mechanic]]
    
- [[Weapon Ideas]]
    
- [[Enemy Ideas]]
    
- [[Upgrade System]]
    
- [[Character Concepts]]
    
- [[Room Generation]]
    
- [[Arena Mode]]
    
- [[Dungeon Mode]]
    
- [[Comic Writing Style]]
    
- [[Visual Style Guide]]
    
- [[Godot Project Setup]]
    
- [[Prototype Roadmap]]