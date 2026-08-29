# Destructibles and Currency

## Why this exists
Crates are the first world object that lets the player influence run resources outside enemy XP alone.

They should add optional route value, small physics chaos, and readable reward decisions without overwhelming the core combat toybox.

## Current prototype direction
### First destructible: crate
The first destructible object is a simple physics crate that:
- has collision and rigidbody behavior
- can be damaged by the player
- can be damaged by hard impacts with the world
- can be launched around the arena under certain hits
- drops **money**, not XP
- can be ignored if the player wants to stay on the combat lane

## Important rules
### Crates should not feel like guaranteed break-on-touch props
They need enough health that:
- a light collision is often just movement
- a hard collision can chip health
- repeated impacts or direct attacks are what usually break them

### Crates should stay stackable and readable
They should:
- stack cleanly in small towers, rows, squares, and awkward asymmetrical piles
- stay mostly calm until an actual impact or attack disturbs them
- not become perpetual physics soup from idle settling alone

### Destruction should always produce a visible reward
If a crate dies from non-player causes, its reward still lands on the floor as visible money pickups so the player can decide whether to go claim them.

### Current implementation scaffold
Crates now include a first-pass **body shove** response:
- player and enemy run-ins can wake and push crates even without direct attacks
- shove strength scales from mover speed and a light mass estimate
- nearby and stacked crates contribute extra resistance so isolated boxes slide more easily than braced piles

### Money loop
Crates now support a separate money pickup loop from XP.

Prototype assumptions:
- XP = combat progression / milestone unlock pacing
- Money = optional arena scavenging reward
- money persists across the current run until restart
- money is shown in the HUD next to health / XP / weapon / camera state

### Reward scaling direction
Crate value should scale with:
- level progression
- future money-efficiency upgrades
- possible destructible-specific bonuses later

Current scaffold keeps a player-side `get_money_drop_multiplier()` hook so upgrades can modify crate reward value later without rewriting the crate system.

## Spawn direction
Each level should spawn:
- a random number of crate clusters
- at random valid positions
- using a small set of stable stack patterns

### Good early cluster patterns
- single crate
- two-crate row
- short two-high stack
- two-base plus one-top pyramid
- offset stair step
- chunky four-crate square
- crooked three-crate lean

This should be enough to make the arena feel less sterile without becoming a procedural set-dressing system yet.

## Damage direction
### Player-caused damage
Crates should take direct damage from:
- melee
- boomerang
- pistol projectiles

Player hits should also be allowed to impart force so crates can:
- slide
- tumble
- get launched into walls / floors / enemies
- break later from environment impacts instead of always from the first attack

### Non-player damage
Crates should also lose health from meaningful collisions with:
- walls
- floor
- enemies
- other heavy moving bodies if later added

This gives the player a reason to care about where a crate goes, not just whether it breaks immediately.

## Why money is separate from XP
Keeping money separate preserves two different decisions:
- **fight for XP and survival**
- **detour for extra economy**

That matters because crates are meant to be optional value targets, not another color of enemy reward.

## Anti-exploit watchouts
Cross-check [[03 Systems/Anti-Exploit Review Checklist]] before expanding this system.

Highest-risk failure modes for crates/money right now:
- **safe farming** if crates can be broken or respawned with too little danger
- **bad exchange rates** if money scales into future weapon power faster than combat progression was meant to allow
- **reward duplication** through replay / restart / level-clear / pause transitions
- **physics loopholes** where crates can be repeatedly damaged, respawned, or re-triggered for payout in ways that do not cost the player enough time or risk
- **economy distortion** if crate detours become so efficient they overshadow enemy-clear rewards

Current design stance should stay:
- crates are optional value, not the main progression lane
- payout should be visible and readable, but not infinitely recyclable
- if later rerolls/scrapping/refunds touch money, the system should leak value rather than preserve it perfectly

## Future-compatible hooks worth preserving
### Other drop types later
Right now crates should only drop money, but the system should stay open to:
- healing
- ammo / charge equivalents if weapons need them later
- temporary buffs
- reroll shards / upgrade fragments
- weapon-tagged bonus pickups

### Destructible-specific upgrades later
Possible future upgrade hooks:
- more money from crates
- chance for bonus drop
- blast damage to nearby crates
- magnet pull for money pickups
- tougher thrown-crate impacts
- explosive or elemental crate variants

## Prototype boundaries
Not needed yet:
- a full shop
- permanent meta-currency
- multiple destructible families
- rare loot tables with many outcomes
- crate-specific UI beyond visible pickup feedback and HUD money total

## Near-term questions
- should crates ever damage enemies directly on a hard hit, or just act as movable blockers for now?
- how much money value is enough to tempt the player without overshadowing enemy clear rewards?
- should later destructibles share the same money loop or each own a different reward fantasy?
- should pickups remain manual walk-over rewards or gain light magnetism later?
