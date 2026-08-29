# Enemy and Upgrade Foundations

## Why this note exists
This tracks the structural prep work behind the current prototype so future enemy types and player upgrades can land without rewriting the combat core from scratch.

## Enemy state foundation
The shared enemy base is now being treated as a simple four-state machine:

1. **Idle**
   - no player in range
   - patrol / hold space / hover in place
2. **Chase**
   - player detected
   - move toward ideal attack spacing
   - for flying enemies, this can include keep-away or orbit movement
3. **Attack**
   - melee windup
   - projectile fire
   - AOE windup / resolve
4. **Stagger**
   - temporary interruption after taking damage
   - movement damped
   - current attack cancelled

This is intentionally small. It is enough to support readable combat behavior now while leaving room for richer variants later.

## Shared enemy base considerations
The base enemy script now benefits from treating an enemy as a mix of:
- **family** — grunt / flyer / miniboss / future archetype id
- **role tags** — e.g. `ground`, `flying`, `ranged`, `tank`, `support`, `boss`
- **state** — Idle / Chase / Attack / Stagger
- **range preferences** — pursue, preferred, retreat, melee, projectile, AOE
- **reward info** — XP amount and XP orb count

This should make it easier to compose future enemies without forking the whole behavior stack each time.

## Future enemy types to design against
These are not fully implemented yet, but the base should stay compatible with them:

### Shield enemy
- protects nearby allies
- wants a support radius and ally query
- may bias toward body-blocking or forward-facing defense

### Flying enemy
- already partially represented by the current ranger
- wants preferred range, retreat range, orbit behavior, hover tuning

### Healer
- looks for damaged allies
- wants support range, heal cadence, target-priority rules

### Suicide bomber
- wants aggressive chase plus death burst or self-destruct range
- may use shorter attack windup but high readability telegraph

### Summoner
- wants summon limit, summon cooldown, and spawn anchor points
- likely should spend time in Attack state while channeling

### Turret
- mostly Idle/Attack with little or no Chase
- can still reuse the same attack-state framework

### Sniper
- wants long projectile range, narrow cadence, and stronger retreat logic
- may prefer huge spacing and low mobility

### Tank
- wants higher health, slower move speed, shorter stagger, heavier melee or AOE pressure

## Player upgrade structure
A lightweight upgrade resource scaffold is a good fit for this prototype direction.

Current preferred shape:

- **Name**
- **Description**
- **Icon**
- **Tier**
- **Weight**
- **Tags**
- **Max Stacks**
- **Conditions**
- **Apply()**

### Why this shape works
- `Tier` supports early rarity/power grouping.
- `Weight` supports weighted random selection later.
- `Tags` let upgrades talk to systems like `boomerang`, `melee`, `mobility`, `air`, `spin`, `health`, `xp`.
- `Max Stacks` keeps simple upgrades stackable without special-case logic.
- `Conditions` gives a place to gate upgrades by context, tags, states, or milestone unlocks.
- `Apply()` keeps effect logic attached to the upgrade definition.

## Suggested upgrade tags for this prototype
- `melee`
- `boomerang`
- `spin`
- `ground_pound`
- `mobility`
- `air`
- `health`
- `xp`
- `crit`
- `cooldown`
- `aoe`

## Next implementation ideas
- make boomerang upgrades alter throw distance, rebound count, or return speed
- make spin upgrades widen hit radius or add pull-in / knockback
- make movement upgrades modify long jump, roll, air dodge, or feather fall
- make enemy role tags feed spawn rules so later levels can bias toward support mixes instead of only raw counts
- make a future run reward screen draw from weighted `PlayerUpgrade` resources
