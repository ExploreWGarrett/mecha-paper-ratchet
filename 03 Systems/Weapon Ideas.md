# Weapon Ideas

## Why this note exists
Track how ranged weapons should fit into the current movement/melee toybox without replacing what already makes the prototype fun.

## Current prototype decision
Weapons can overwrite the player's default **primary** and **secondary** inputs while still keeping the melee kit available.

### Current intended control model
- **LMB / attack** = active melee or active weapon primary depending on stance
- **RMB / secondary attack** = active melee secondary or active weapon secondary depending on stance
- **Tab** = toggle between full-time melee stance and active weapon stance
- **MMB** = fallback primary melee while a weapon stance is active
- **V** = fallback secondary melee while a weapon stance is active
- **N** = cycle camera views

### Important rule
When a weapon is equipped, the melee kit should still exist.

That does **not** mean melee remains equally strong on the most convenient buttons at all times.
The stance swap and fallback inputs are enough to preserve the full toybox without making every weapon just a free strict upgrade.

## Camera plan tied to weapons
Planned/now-supported prototype views:
- default chase camera
- left-shoulder offset
- right-shoulder offset
- overhead top-down
- first person

### Why this matters for weapons
Different weapons may feel best in different camera modes even if the game remains mainly over-the-shoulder.

Examples:
- pistol / SMG / burst sidearm -> over-the-shoulder default or left/right offset
- launcher / crowd-control gadget -> wider default or overhead readability
- precise marksman weapon -> occasional first-person or scoped secondary override

## Current first weapon
### Paper Popper
Prototype role:
- baseline automatic pistol
- somewhat slow fire rate
- no reload yet
- no ADS
- meant to prove that ranged loadouts can sit on top of the melee toybox without deleting it

### Paper Popper current behavior direction
- obtainable after **50 earned XP**
- pauses the game and opens a reusable reward / selection window
- can be equipped immediately or unlocked while staying on melee stance
- primary = steady automatic shot
- secondary = stronger precision shot without ADS
- fallback melee remains available on MMB / V when armed
- fallback melee should be somewhat reduced while armed so stance choice matters

## Future weapon families worth planning around

### Sidearms
- pistol
- burst pistol
- ricochet revolver
- spread stapler

### Gadget / comic weapons
- paper clip launcher
- stamp cannon
- fold-bomb thrower
- crease beam / ruler laser

### Movement-combo weapons
- grappling launcher
- tether gun
- pull mine / gravity toy
- dash-shot sidearm

### Charge / setup weapons
- rail marker
- delayed detonation launcher
- pinning nailgun
- trap-laying ink sprayer

## Weapon-specific upgrade model
Weapons should likely have their own upgrade pools in addition to shared run upgrades.

### Suggested split
#### Shared upgrades
Affect broad systems:
- mobility
- melee
- air game
- crowd control
- survivability
- XP / economy

#### Weapon-specific upgrades
Affect only a weapon family or even a single weapon:
- pistol fire rhythm
- projectile behavior
- crit windows
- ricochet rules
- mark / detonate behavior
- spread / pierce / chain / stick / split modifiers

## Tagging guidance for weapons from day one
Every weapon upgrade should be tagged for systems, not just presentation.

Example:

```yaml
id: paper_popper_double_feed
type: Upgrade
rarity: Uncommon
weapon: paper_popper

tags:
  - pistol
  - projectile
  - stacking
  - fire_rate
  - combo
```

This allows future reward logic to ask:
- does the run already lean projectile-heavy?
- does the player already have `pistol` or `stacking` tags?
- is there a combo offer unlocked because `gravity + projectile` already exists?

## Stacking / ordering upgrade considerations
You asked to look into **Stack Gun Heroes** for ideas around upgrade stacking and ordering.

### Research note
A quick live search this turn did **not** surface a reliable public source under that exact title, so this note treats it as a design prompt rather than verified external documentation.

### Still-useful design direction from that prompt
The phrase suggests a very good weapon-system idea:

> upgrades should not only stack numerically — their **order** and grouping can change behavior.

That is promising.

### Possible stacking models
#### 1. Linear stacking
Each copy simply improves a stat.
- +fire rate
- +projectile speed
- +magnet pull

Useful, but least surprising.

#### 2. Threshold stacking
Behavior changes at 2/3/5 stacks.
- 2 stacks -> projectile pierces one target
- 3 stacks -> every third shot splits
- 5 stacks -> kills refund a burst shot

#### 3. Ordered stacking
The order of upgrades matters.
- `split` then `pierce` -> each split round pierces
- `pierce` then `split` -> projectile splits only after first pass-through
- `mark` then `detonate` -> direct synergy unlock

#### 4. Slot-chain stacking
A weapon can have ordered modifier slots.
- barrel modifier
- round modifier
- impact modifier
- return modifier

This is likely too deep for the prototype **right now**, but it is a strong future differentiator.

#### 5. Recipe / fusion stacking
Certain tag clusters unlock special offers.
- `pistol + gravity + combo` -> pull-shot finisher
- `projectile + air + mobility` -> airborne dive barrage
- `wrench + pistol` -> gun-kata hybrid strike follow-ups

## Promising weapon upgrade examples
### Paper Popper examples
- **Carbon Copy Rounds** — every fourth bullet echoes behind the first
- **Foldback Slide** — sustained fire slightly tightens shot rhythm instead of loosening it
- **Margin Notes** — hitting the same target repeatedly writes marks, then a melee hit cashes them out
- **Paper Jam** — slower fire, but rounds briefly pin enemies in place
- **Comic Snap** — secondary shot hits harder and knocks small enemies into each other

## Best near-future weapon questions
- should each weapon replace both primary and secondary by default, or do some only replace one side?
- how many weapon-specific upgrades should exist before the pool gets diluted?
- when should first-person or ADS be allowed without making the whole game feel like a different genre?
- how much should armed fallback melee be reduced before it feels clumsy instead of meaningfully distinct?
- should weapon upgrade offers look at current camera preference or only combat tags?

## Practical next-step guidance
As new weapons are added, keep them honest against these rules:
1. they must add a new combat expression, not just longer range
2. they must still leave room for melee identity
3. their upgrades should have tags from day one
4. at least one future upgrade path should interact with another system outside the weapon itself
5. if a weapon wants ADS or first-person precision, that should be a special exception, not the default language of the whole game
