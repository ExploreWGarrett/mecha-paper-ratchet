---
title: Combat Prototype
project: Mecha Paper Ratchet
type: prototype
status: active
tags:
  - '#mecha-paper-ratchet'
  - '#prototype'
  - '#combat'
  - '#playtest'
  - '#godot'
---

# Combat Prototype

## Goal
Build the smallest playable slice that can answer the only question that matters right now:

> Is the core movement + lock-on + melee loop fun?

## Current Prototype Direction
The first playable should be a **visually bare-bones circular arena** focused on movement feel and lock-on readability.

### Player baseline
- slim rectangular hitbox to emulate a flat paper character
- default melee weapon
- lock-on available by default
- movement/combat inspired by a fusion of **Ratchet & Clank** and **Jak and Daxter**

### Requested moveset for the first playable scaffold
- melee slash combo
- crouch attack that becomes a boomerang throw
- crouch jump that becomes a high jump
- crouch forward jump that becomes a long jump
- spin melee attack
- midair attack that becomes a ground pound
- crouch while moving forward enters a roll

### Currently implemented player baseline
- mouse camera + free cursor toggle
- lock-on strafe movement
- melee combo with widened early hit arcs for readability
- right-click spin attack
- crouch right-click wide spin attack
- `E` ability-slot boomerang throw aimed by true camera look direction
- boomerang now starts returning to the player immediately after hitting anything at the base level, instead of briefly sticking in world geometry
- boomerang return now uses a more physical homing pass with return-speed tuning and collision response instead of simply ghosting straight back toward the player
- while the boomerang is out, primary becomes a shorter-range weaker-but-faster punch and secondary becomes a reduced emergency spin instead of the full wrench kit
- double jump + feather fall
- one-use midair dodge on crouch
- ground pound with landing AOE impact
- fall-below-floor respawn with health penalty
- light camera shake on damage and ground-pound landing
- distinct hit-confirm and hurt sounds
- player health, temporary invincibility, XP attraction/collection, HUD text, and player health bar
- camera cycle on `N`: default, left shoulder, right shoulder, overhead, and explicitly labeled **First Person (Experimental)**
- Paper Popper reward at 50 earned XP with armed stance on primary/secondary and fallback melee on MMB / `V`
- destructible physics crates with separate money drops, random per-level placement, and stackable cluster patterns
- crates now react to player/enemy body shoves more naturally, with heavier movers pushing more and nearby/stacked crates contributing extra resistance
- live difficulty control in the pause menu with Normal as the new default and decimal tuning between preset bands
- default master volume now starts at 10% on boot so the prototype comes up much quieter by default
- player body now reads as a grounded extruded isosceles triangle from the top-down view instead of a taller wedge
- design planning has now pivoted away from treating Momentum as the immediate centerpiece and toward detailing wrench / Popper upgrade trees, mutations, direct fusions, support upgrades, and fusion-of-fusion capstones
- exploit-prevention planning now includes a standing anti-exploit review direction so future rewards, upgrades, and replay/state flows get checked for duplication, farming, and runaway stacking before deeper progression lands
- first wrench close-range commitment pass is now in the build as a toggleable/tunable package for evaluation only: the third combo hit can apply a visible wrench mark, spin attacks can pull enemies inward, and catching the boomerang can prime one stronger follow-up melee hit that can cash out a mark for extra damage
- spin pull now tests as a short-radius pre-hit vacuum window instead of only riding on already-landed direct hits, so upgraded versions can potentially drag nearby enemies into the same spin

### Latest live test read
- the **base boomerang throw/return feel** now seems close to the intended default and should stay the benchmark for the wrench throw
- the close-range commitment package does **not** currently read as good default behavior; for now it should be treated as upgrade-only content rather than baseline kit
- the mark is not visually clear enough yet in live play, even though extra damage is sometimes noticeable
- spin pull currently means the spin move can tug nearby enemies inward to keep them in close-range pressure; the idea itself is liked, but the current feel is wrong because it seems too tied to direct hit timing instead of acting like a fast nearby vacuum window
- Catch Confirm also does not read clearly enough yet; stronger UI/status feedback and clearer player/enemy visual indicators are wanted before judging it further
- crouch-triggered boomerang throw is creating input friction because crouch heavily limits movement and can be confused with dodge timing, so the throw may eventually move out of the default moveset and become upgrade-gated or remapped
- a separate future upgrade that pulls **crates** is liked and should stay distinct from the enemy-pull version
- boomerang throw may fit better as an ability-slot action on `E`, `Q`, or `F` rather than living on the crouch-attack input forever
- box/crate shove behavior feels complete enough for now and does not need immediate follow-up work

### Current next-shape direction
- keep the current boomerang travel/return feel as the baseline target
- move boomerang throw input off crouch and onto a dedicated ability slot so movement and dodge inputs stop fighting it
- treat spin pull as an upgrade route that should work like a quick nearby vacuum window first and a hit-confirm rider second
- keep crate pull separate so it can become its own authored utility upgrade rather than collateral behavior on every enemy-pull spin

### Latest prototype pass
- boomerang return now has a **smarter blocked-return recovery**:
  - if a wall blocks the direct return line, it now tries an upward arc waypoint instead of just staying trapped on the far side
  - if that still fails for too long, a timeout fail-safe restores the weapon instead of leaving the player stuck disarmed
- the wrench throw now uses an **ability-slot assignment structure** instead of a one-off hardcoded key:
  - first unlocked ability auto-fills **E**
  - next open slots fill in **F**, then **Q**
  - the pause/settings menu can manually reassign the current wrench throw slot for feel testing
- because `Q` is now part of the ability-slot lane, **lock-on now lives on `R` and `Tab` for testing**, while armed-stance toggle moved to `T`
- lock-on targeting now prefers the enemy **closest to the player’s look direction**, not just the shortest distance from the player body
- lock-on targeting now uses the **camera’s actual look line / screen-center bias** rather than only the player-body forward guess, so shoulder-camera aiming and lock choice line up better
- the default third-person camera now sits **more over-the-shoulder and less far behind**, and the camera now looks farther ahead so the crosshair reads past the player instead of sitting on top of them
- follow-up camera pass: the default chase camera now sits **lower and a little less floaty**, keeps more of the player body in frame, and blends its look target back toward the player so aiming still reaches into combat space without feeling disconnected
- when the player is idle and unlocked, the character now starts turning back toward the camera-facing direction so the camera feels more like it is steering the player’s look instead of orbiting around a detached body
- free-camera Paper Popper shots now solve aim from the **screen-center crosshair ray** at fire time instead of only using a pitch/yaw approximation, so unlocked free-aim shots should land on the center point the player was aiming at rather than drifting high
- enemy spin pull is now **out of the default base moveset** and lives behind the existing debug toggle so the baseline spin stays cleaner unless you explicitly turn the pull behavior back on for testing
- the separate `~` debug board now starts with a much broader **non-basic mechanics surface**: double jump, high jump, long jump, feather fall, roll, air dodge, ground pound, wrench throw, lock-on, Paper Popper, weapon stance, wrench mark, enemy spin pull, crate pull, Catch Confirm, sky resistance, and camera shake can all be toggled independently while base movement, the normal jump, and the wrench melee baseline stay intact
- the debug overlay no longer dumps everything into one giant list: it now uses a **scrollable three-column layout** grouped by movement, combat, and world/feedback so the sandbox stays readable as more toggles are added
- the enemy-mark rider is now called out more explicitly in the debug surface as **Enemy Mark on Hit**
- startup audio now defaults to **10%**; first-person remains **Experimental** rather than production-ready, while the playable **Default/chase** camera stays the startup baseline
- first-person camera bug pass: entering **First Person (Experimental)** now snaps to a stable eye-height pose, clamps camera smoothing so frame spikes cannot lerp/extrapolate the camera upward, and uses raw yaw/pitch for the rendered first-person look direction instead of feeding through the previous camera crosshair ray
- menu mouse restoration pass: pause/settings/debug menus now actively keep the mouse visible while open, and player camera input ignores mouse recapture while the game tree is paused so clicking menu controls does not steal the cursor back into gameplay look mode
- the settings menu now includes a more believable first-pass prototype set that is actually live right now: **master volume**, **mouse sensitivity**, **camera FOV scale**, **difficulty scalar**, **camera position** (including **First Person (Experimental)**), **wrench throw slot**, **invert look Y**, **crosshair visibility**, and **camera shake**
- later settings worth revisiting once the toybox stabilizes: separate music/SFX buses, key rebinding, crouch toggle vs hold, lock-on preferences, reticle style/size, per-mode FOV tuning, shoulder-side preference, a redesigned first-person camera if it is still worth pursuing, and possibly aim-assist or projectile-leniency controls if Popper feel still needs help
- player runtime ownership is now split across cooperating scene components: `PlayerCameraController` owns camera modes/aim/shake, `PlayerSettingsController` owns live camera settings, `PlayerAbilityController` owns ability-slot state, and `PlayerCombatController` owns combat input routing; `player.gd` remains the movement/physics orchestrator while these boundaries are exercised before deeper camera tuning
- main-scene ownership is now split across cooperating scene components: `MainLevelController` owns the level catalog, arena switching, dynamic cleanup, enemy/crate spawning, and level-clear signaling; `MainDebugController` owns both debug toggle surfaces and debug-menu focus; `MainSettingsController` owns live settings controls, labels, controls-copy refresh, audio volume, camera setting dispatch, wrench-slot dispatch, and difficulty signaling; `main.gd` remains the run/menu orchestrator that coordinates these components
- `Tab` is now handled as a direct alternate lock-on toggle path in addition to `R`
- a new **separate** `~` mechanic debug menu now exists outside the pause menu and exposes a broader toggle surface for live sandbox testing
- there is now a first **sky-resistance barrier** pass above the arena: going high can still happen, but upward momentum gets damped and extra downward pull ramps up the farther beyond the soft ceiling the player travels
- Paper Popper aim tuning pass:
  - added a small screen-center crosshair for diagnosis
  - moved projectile spawn closer toward the center aim line to reduce parallax drift
  - pushed the default camera a bit **closer and higher**
  - nudged the visible pistol pose closer toward center while keeping it readable
- standing spin now behaves more like a **sphere-ish nearby catch** with better vertical reach and now shows a visible animated hit-volume preview while active
- crouch spin now behaves more like a **short flatter disc** for floor enemies and now shows a visible animated hit-volume preview while active so the two shapes can be compared directly in motion
- crate pull is now **enabled by default for testing**, still kept as a separate spin-modifier lane, and now scales by distance so nearby crates yank harder than far ones
- fast crates can now damage **other crates** and **enemies**, while intact crate hits can give the **player slight speed-scaled knockback**
- proc readability is stronger now through:
  - a right-side status notice label
  - a player state ring for boomerang-out / Catch Confirm feedback
  - an enemy mark ring for wrench-mark readability
  - the under-player ring stack is now clearly part of the current state-feedback family, though it still likely needs a later cleanup pass so each ring job reads more distinctly
  - the debug menu now includes first-pass toggles for: wrench throw, lock-on, Paper Popper, weapon stance, wrench mark, enemy spin pull, crate pull, Catch Confirm, sky resistance, and camera shake

### Enemy baseline
- one default ground grunt enemy
- one flying ranger enemy that keeps distance and shoots linearly at the player
- one first miniboss built from the grunt base
- valid lock-on targets across the roster
- short stagger on basic enemies
- XP rewards that vary by enemy type

### Currently implemented enemy baseline
- targetable grunt with stagger, melee, projectile pressure, and XP drop
- flying ranger with lower health, higher XP reward, and keep-away projectile pressure
- grunt-based miniboss with larger body, higher health, heavier XP reward, and an AOE attack
- shared enemy foundation is now moving toward explicit Idle / Chase / Attack / Stagger states
- family + role-tag metadata is being prepared so future shield / healer / summoner / sniper / tank variants can share one base more cleanly
- world-space enemy health bars
- level-clear handoff into simple splash/menu flow
- pause/settings menu on Escape with live volume, camera sensitivity, camera-shake, and difficulty controls plus a controls toggle
- difficulty now scales enemy tempo/pressure with decimal values while also widening family-specific behavior differences between grunt, flyer, and miniboss roles

### Player combat-state baseline
- current and max health tracking
- temporary invincibility after taking damage
- fall reset that respawns to the arena and removes a slice of health
- light camera-shake feedback on impact events
- XP attraction and collection
- readable HUD for health and XP

## Prototype 0.1 Scope
- one circular arena
- one square follow-up arena
- five short prototype levels alternating between those two arena layouts
- one player character
- grunt, flyer, and first miniboss enemy variants
- enemy base with explicit Idle / Chase / Attack / Stagger state flow
- lightweight player-upgrade resource scaffold for future reward choices
- reusable reward popup that can stall play for weapon / upgrade selections later
- first weapon scaffold: Paper Popper automatic pistol with fallback melee while armed
- first destructible economy scaffold: stackable crates with separate money rewards
- melee combo
- boomerang throw
- player health and enemy health scaffolding
- lock-on targeting
- strafe movement
- jump
- crouch / roll / high jump / long jump scaffold
- ground pound scaffold
- enemy melee + projectile attacks
- miniboss AOE attack
- enemy stagger reaction
- XP drop and pickup loop with varying rewards per enemy type
- player health / invincibility / HUD loop
- level-clear pause menu with replay / advance / restart hooks

## Success Criteria
The prototype is successful if:
- moving around the enemy feels readable and responsive
- lock-on is easy to understand
- melee spacing feels satisfying enough to repeat
- movement chaining starts to feel expressive
- defeating one enemy is enjoyable without progression systems

## Current Prototype Reality Check
Already true in the build right now:
- the player baseline is close to locked in for prototype purposes
- the enemy roster now covers a ground grunt, a flying ranger, and a first grunt-based miniboss
- health, damage, invincibility, projectile pressure, and XP collection are all part of the playable loop
- the prototype now runs as a five-level combat ladder alternating circle and square arenas before the first miniboss finish

## Current alignment review focus
Before moving into the first real upgrade implementation pass, the project should align on these points:
- the current combat sentence should still be: **commit with the wrench, time the Popper, alternate on purpose**
- the first implementation target should still be **wrench close-range commitment**, not recall-detonation spectacle
- the current baseline review should still focus on melee spacing, boomerang return feel, thrown-state fallback balance, Popper identity, and pause/state reliability
- the project should still prefer readable 3D combat and melee-first identity over flashy multiplication systems

If those statements stop feeling true, re-check `02 Design/Inspiration Upgrade References/19 Implementation Alignment Review Packet.md` before coding.

Still needs tuning:
- add clearer status/buff UI for temporary wrench states, ideally including right-side screen notices plus stronger player/enemy effect markers
- decide whether crouch-triggered boomerang throw should stay in the base moveset, move to a different input, or become upgrade-gated later
- prototype an alternate spin-pull implementation that checks a short-radius pull window quickly enough for enemies to get dragged into the same spin hit when upgraded hard enough
- keep crate-pull as a separate upgrade path rather than bundling it into the enemy-pull version
- tune whether wrench marks stay readable enough in crowds without becoming visual noise if/when they return as upgrade content
- tune whether spin pull strength creates good close-range pressure without turning into low-risk crowd sludge if/when it stays as an upgrade
- tune whether Catch Confirm payoff feels rewarding enough to notice without becoming the only correct post-return choice if/when it stays as an upgrade
- confirm Escape pause now feels reliable in real play
- tune how long the boomerang should stay caught in world geometry before the fail-safe return feels best
- tune whether the thrown-state punch/spin fallback is weak enough to preserve wrench identity but still usable under pressure
- tune Paper Popper cadence, projectile speed, centerline feel, and fallback-melee penalty so ranged stance complements melee instead of replacing it
- decide which camera mode should be the default for armed play and whether first person should stay novelty-only or support specific precision weapons
- tune Normal / Hard / Brutal pacing until the decimal difficulty slider has good anchor points
- enemy melee pacing and readability
- flyer keep-away distance and projectile cadence
- miniboss AOE windup readability and fairness
- hit reliability from awkward side angles
- ground-pound impact readability and consistency
- whether the five-level ladder feels good enough to grow into a real run/menu shell
- whether XP should stay as simple pickup feedback or evolve into a deeper loop
- how much money value crates should offer before they start distorting combat pacing
- whether crates should eventually damage enemies on hard impact or stay as economy-first physics clutter
- how much the current enemy base really needs beyond Idle / Chase / Attack / Stagger before more archetypes land

## Anti-exploit review reminder
Before implementing deeper progression systems, cross-check [[03 Systems/Anti-Exploit Review Checklist]].

Highest-risk near-term prototype areas:
- reward popup duplication during pause / replay / restart transitions
- crate money farming or low-risk destructible value loops
- future wrench/Popper upgrade chains multiplying too cleanly through recall hits, projectile echoes, or mark cash-outs
- safety loops where spacing, lock-on, dodge, or thrown-state fallback keeps reward high while retaliation drops too low

## Ad-hoc verification
- `Godot_v4.7-stable_win64_console.exe --headless --path 'game/mecha-paper-wrench' --script '<temp>/tmp_wrench_commitment_verifier.gd'` -> `WRENCH_COMMITMENT_VERIFIER: PASS`
- `Godot_v4.7-stable_win64_console.exe --headless --path 'game/mecha-paper-wrench' --quit` -> exited `0`

## Not In Scope Yet
- multiple characters
- procedural room generation
- permanent progression
- many weapons
- complex menus
- narrative systems
- full run structure

## Questions This Prototype Should Answer
- how closely should lock-on movement mimic Ratchet versus Jak?
- how committed should crouch-combo movement be versus immediate responsiveness?
- should the spin attack be mobility-focused, crowd-control-focused, or both?
- how exaggerated should the long jump and high jump feel?
- how should the boomerang evolve when used in midair?
- should the secondary spin attack gain extra effects or altered behavior in midair?
- should crouch in midair stay a dodge forever, or become its own air-state later?
- how aggressive should the grunt, flyer, and miniboss feel relative to each other?
- how much keep-away behavior feels fun versus annoying on the flying ranger?
- how readable does the miniboss AOE tell need to be before it feels fair?
- should XP stay as a simple pickup magnet or immediately imply leveling later?
- which tag combos are strong enough to define the game's identity rather than merely add content?
- which enemy-role combinations create readable pressure puzzles instead of noisy overlap?
- what paper/comic-specific interaction could become the game's signature wow-factor mechanic?

## Deliverables
- a controllable player in a toybox arena
- a five-level combat ladder alternating circle and square layouts
- grunt, flyer, and first miniboss encounters
- a short note evaluating what feels good and what does not
