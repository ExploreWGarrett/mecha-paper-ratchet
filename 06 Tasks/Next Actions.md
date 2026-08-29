---
title: Next Actions
project: Mecha Paper Ratchet
type: task
status: active
tags:
  - '#mecha-paper-ratchet'
  - '#tasks'
  - '#prototype'
  - '#documentation'
---

# Next Actions

## Immediate
- [x] Confirm Godot 4 as engine
- [x] Open this folder as its own Obsidian vault
- [x] Create the Godot project under `game/`
- [x] Build a tiny circular arena scene
- [x] Add a placeholder paper-style player object with a slim rectangular hitbox
- [x] Implement default lock-on
- [x] Implement melee slash combo
- [x] Implement crouch attack boomerang throw
- [x] Implement crouch jump high jump
- [x] Implement crouch forward jump long jump
- [x] Implement crouch-forward roll
- [x] Implement spin melee attack
- [x] Implement midair attack ground pound
- [x] Add crouch spin attack on secondary input
- [x] Make crouch boomerang throw aim by camera look direction
- [x] Make midair crouch function as a one-use air dodge
- [x] Add enemy stagger, melee attack, projectile attack, and XP drop
- [x] Add player health, temporary invincibility, XP attraction/collection, and HUD tracking
- [x] Add player and enemy health bars
- [x] Add ground-pound landing AOE and widen early melee hit coverage
- [x] Add a flying ranger enemy with lower health and a distinct XP reward
- [x] Expand the prototype to five alternating circle/square levels with increasing enemy variety
- [x] Add a first grunt-based miniboss with higher health and an AOE attack
- [x] Add fall respawn with health loss, projectile trails, and light impact camera shake
- [x] Add distinct hit-confirm / hurt sounds and higher-tier XP color feedback
- [x] Fix free-aim boomerang direction and add a working Escape pause/settings menu
- [x] Make outbound boomerang return immediately on enemy / wall / floor collision
- [x] Refactor enemy groundwork toward Idle / Chase / Attack / Stagger states plus future role tags
- [x] Add a lightweight player-upgrade resource scaffold and document future roster / upgrade considerations
- [x] Add a first Paper Popper weapon reward at 50 earned XP with stance swap, fallback melee keys, and multi-camera cycling
- [x] Add destructible physics crates with separate money drops and random stackable level clutter
- [x] Add live difficulty tuning in the pause menu with a Normal default and family-specific enemy scaling hooks
- [x] Add a boomerang fail-safe return plus weaker/faster thrown-state fallback attacks so the player is not stranded when the wrench is out
- [x] Shift the player silhouette toward a directional paper wedge with a wider but shallower hitbox
- [x] Capture mutation, Momentum, alternate-character, and unlock-journal direction in a dedicated systems note

## Documentation / Kickoff
- [ ] Edit [[01 Vision/Development Kickoff Questionnaire]] and leave rough answers or `default` where useful
- [ ] Review questionnaire answers before approving progression/lore direction
- [ ] Run the Questionnaire resolver prompt in [[06 Tasks/Agent Job Prompts]]
- [ ] Keep [[02 Design/Ideas/Side Notes - Callous and Grit]] separate until Callous energy and Grit meaning are clarified
- [ ] Keep [[04 Prototype/Prototype-Code Link Map]] current when script ownership changes

## Yearn for the Mines concept branch

- [ ] Review [[02 Design/Yearn for the Mines/04 Contestation and Decision Log]] before treating the direction as a project pivot
- [ ] Answer Section 9 of [[01 Vision/Development Kickoff Questionnaire]]
- [ ] Decide pivot vs spin-off vs prototype branch
- [ ] Test a first-person hands-first excavation loop before committing to mine architecture
- [ ] Define what “unvestable” means for Grit
- [ ] Decide whether child-labor lore is central, optional, or unsuitable
- [ ] Decide whether the temple ending challenges or rewards extraction
- [ ] Keep the existing Mecha Paper Ratchet action prototype intact until the project-level decision is explicit

## Soon After
- [ ] Test lock-on + melee spacing + movement chaining
- [ ] Record what feels fun and what feels wrong
- [ ] Keep prototype findings in `04 Prototype/`
- [ ] Review `02 Design/Standout Combat and Upgrade Synergy Ideas` and `03 Systems/Mutations Momentum and Unlock Journal` before the next major mechanics pass
- [ ] Decide which upgrade tags must exist from day one so future combo offers and enemy counters are easy to add
- [ ] Decide which weapon-specific tags and stacking rules belong to every weapon upgrade pool from day one
- [ ] Decide which first wrench and Popper upgrade families should be implementation targets rather than only design notes
- [ ] Decide which first mutation recipes should be implementation targets rather than only design notes
- [ ] Decide whether wrench+Popper fusions should appear as explicit rewards, emergent tag results, or both
- [ ] Decide which support-upgrade families should exist mainly to stabilize setups, payoffs, and fusion chains
- [ ] Decide which fusion-of-fusion capstones are exciting enough to justify being real run-defining chase outcomes
- [ ] Revisit whether Momentum should start hidden, minimal, or absent entirely until the weapon-fusion language is proven fun
- [ ] Tune Paper Popper cadence, fallback melee penalty, and reward timing until the armed stance feels additive rather than dominant
- [ ] Tune whether the new top-down triangle read is clear enough in motion or needs a sharper point / broader base
- [ ] Decide whether the 30% default master volume should stay fixed or become a saved user setting later
- [ ] Decide whether first-person stays novelty-only or becomes a deliberate mode for a few precision weapons
- [ ] Verify Escape pause/resume feels dependable in live play, not just structurally wired
- [ ] Tune boomerang collision-return timing so it feels intentional instead of abrupt
- [x] Fix returning boomerang collision so the wrench can hit things on the way back instead of only ghosting home
- [x] Make the base boomerang begin returning immediately after any hit instead of sticking first
- [x] Add first-pass crate body-shove response with mover-mass scaling and local stack resistance
- [ ] Tune Normal / Hard / Brutal anchor points until the decimal difficulty slider feels useful instead of arbitrary
- [ ] Tune enemy melee windup/readability until it feels fair from all angles
- [ ] Tune the flying ranger's keep-away distance so it pressures without kiting too hard
- [ ] Tune miniboss AOE windup, size, and recovery until it feels readable and dodgeable
- [ ] Verify the widened player hit arcs feel generous without becoming sloppy
- [ ] Add stronger feedback for ground-pound landing impact
- [ ] Test whether the five-level ladder and enemy ramp feel good enough to keep
- [ ] Tune the between-level menu flow so it can grow into a future real menu shell
- [ ] Evaluate midair boomerang behavior and whether it needs its own move variant
- [ ] Evaluate whether the secondary spin attack should gain extra midair effects
- [ ] Revisit whether midair crouch should remain a one-use air dodge or evolve into a distinct air-crouch state
- [ ] Tune grunt, flyer, and miniboss cadence into a reusable enemy roster package
- [ ] Decide when to split future enemy roles like shield / healer / bomber / summoner / turret / sniper / tank into dedicated scenes versus exported variants
- [ ] Decide whether XP should remain simple currency/feedback or imply a later level-up loop
- [ ] Tune crate value, health, and stack density so crates are worth detouring for without stealing focus from combat
- [ ] Decide whether money upgrades should start with yield, pickup radius, bonus drops, or thrown-crate impact first
- [ ] Decide whether hard-impact crates should start hurting enemies before or after the first difficulty tuning pass settles
- [ ] Create and start using a lightweight anti-exploit review pass for every new reward, upgrade, mutation, fusion, and replay/state-flow system
- [ ] Review reward popup, replay/restart, and unlock flows for duplication/state-transition abuse before deeper progression systems land
- [ ] Stress-test likely future exploit zones early: crate farming, recall hit-count loops, mark cash-out loops, and high-stack projectile multiplication
- [ ] Use `03 Systems/Exploit Risk Grading for First Upgrade Families` to choose the safest first implementation targets among wrench, Popper, fusion, and crate-economy routes
- [ ] Use `02 Design/Inspiration Upgrade References/13 Pre-Implementation Readiness Gate` before switching from planning into gameplay implementation
- [ ] Use `02 Design/Inspiration Upgrade References/12 Feature Pass Implementation Checklists` during each of the first three feature passes
- [ ] Start the first implementation session from `02 Design/Inspiration Upgrade References/14 First Implementation Session Brief`
- [ ] Use `02 Design/Inspiration Upgrade References/16 Baseline Feel Validation Checklist` before re-running the readiness gate
- [ ] Run the next live-play tuning session from `02 Design/Inspiration Upgrade References/17 Baseline Feel Validation Session Brief`
- [ ] Record the next live-play tuning session in `04 Prototype/Baseline Feel Validation Findings Template.md`
- [ ] Fill in `04 Prototype/2026-07-18 Baseline Feel Validation Session.md` during the next live-play tuning pass
- [ ] After baseline tuning notes are updated, re-check `02 Design/Inspiration Upgrade References/15 Readiness Gate Assessment - 2026-07-17`
- [ ] Record the next official gate re-check in `02 Design/Inspiration Upgrade References/18 2026-07-18 Readiness Gate Re-Run.md`
- [ ] Use `02 Design/Inspiration Upgrade References/19 Implementation Alignment Review Packet.md` as the final pre-code review packet
- [ ] If the gate flips to GO, begin from `02 Design/Inspiration Upgrade References/20 Implementation Kickoff Brief.md`
- [x] Implement the first wrench close-range commitment pass: third-hit wrench mark, spin pull, and one-shot Catch Confirm follow-up
- [x] Refactor the first wrench close-range commitment pass into toggleable / tunable behavior flags so it can be tested as baseline tech or future upgrade content
- [x] Add stronger temporary-state feedback for wrench testing: right-side status notices plus clearer player/enemy visuals for marks, confirms, buffs, and debuffs
- [x] Prototype boomerang throw on an ability slot (`E`) instead of tying it to crouch attack
- [x] If boomerang throw moves to an ability slot, decide whether other future weapon abilities should reserve neighboring slots from day one
- [ ] Reframe the first wrench close-range commitment pass as upgrade-only content for now unless later feedback proves parts deserve baseline promotion
- [ ] Live-tune the first wrench close-range commitment pass for mark readability, pull strength, and Catch Confirm clarity only as upgrade candidates, not assumed baseline kit
- [x] Add blocked-boomerang return recovery so wall traps do not leave the player permanently disarmed; keep a timeout fail-safe behind it
- [x] Add a first popper-aim readability pass: center-ish spawn blend, small crosshair, closer/higher default camera, and a less-offset pistol pose
- [x] Let lock-on live on both `R` and `Tab` for a temporary feel test, and move armed-stance toggle off Tab to avoid overlap
- [x] Change lock-on target choice so it prefers what the player is looking at, not just the nearest enemy to the player capsule
- [x] Add a first soft sky-resistance barrier so big launches can still happen without letting vertical escape turn into floaty nonsense
- [x] Start a `~` mechanic-debug menu scaffold with toggleable combat rules so future feel tests can isolate combinations quickly
- [x] Move the `~` mechanic-debug surface out of the pause menu and broaden it into a separate first-pass combat toggle board
- [x] Reframe the default chase camera so the crosshair sees beyond the player instead of sitting on top of the silhouette
- [x] Add a direct `Tab` lock-on toggle path and align lock target choice more tightly with the camera-centered look line
- [x] Lower the chase camera, keep more of the player visible, and make idle facing feel more camera-driven instead of orbit-detached
- [x] Make free-camera Paper Popper shots travel through the crosshair center instead of drifting high above the aim point
- [x] Pull enemy spin behavior out of the default spin baseline and leave it as a dedicated debug-toggle rider
- [x] Make nearly every non-basic movement/combat mechanic toggleable from the start so interactions can be isolated before deciding what deserves baseline status
- [x] Rebuild the oversized debug overlay into a grouped scrollable layout, expose enemy mark more explicitly there, lower startup volume to 10%, and make camera settings live for feel testing
- [x] Roll the default camera back to the playable chase/default view after first-person proved unplayably bad; keep first-person selectable as an explicit experimental mode instead of using it as the startup baseline
- [x] Fix the experimental first-person camera drift/control regression by snapping into eye height, clamping camera smoothing, and driving first-person view from raw yaw/pitch mouse look instead of the previous camera crosshair ray
- [x] Restore mouse function while menus are open by making `main.gd` actively own visible menu mouse mode and blocking player-camera mouse recapture while paused
- [x] Split player runtime ownership into cooperating camera, settings, ability, and combat-controller scripts while preserving stable player APIs for the main scene and projectile callbacks; restore First Person as an explicitly labeled experimental mode
- [x] Split main-scene ownership into cooperating level, settings, and debug-controller scripts while preserving `main.gd` as the run/menu orchestrator
- [x] Fill the settings menu with only the common options the prototype can truly support right now, and log later candidate settings for future revision in Obsidian
- [ ] Revisit later settings additions after more feel passes: separate music/SFX volume, input rebinding, crosshair styling, crouch hold/toggle, lock-on preferences, shoulder-side default, first-person polish/tuning, and any Popper aim-assist / projectile-leniency options still needed
- [ ] Revisit whether default standing-spin crate shove should stay pure push, or later branch cleanly into a stronger inward crash-upgrade lane without muddying the baseline read
- [x] Rebuild spin pull as a short-radius pull window that can drag nearby enemies into the same spin hit when upgraded enough, instead of only reading as a direct-hit rider
- [x] Decide whether `E` stays the right boomerang ability slot or whether `Q` / `F` would read better once more abilities exist
- [x] Plan a separate crate-pull upgrade path instead of bundling crate movement into the enemy-pull spin package
- [x] Let the player cycle the current wrench throw key between `E`, `Q`, and `F` while the broader ability-slot structure is still unsettled
- [x] Replace the one-off key cycle with a first-pass slot-assignment scaffold: auto-fill `E`, then `F`, then `Q`, while still allowing manual wrench-throw reassignment in the pause/settings menu
- [x] Split spin feel so standing spin catches higher/closer while crouch spin reaches farther across the floor
- [x] Add temporary animated standing-sphere and crouch-disc spin hitbox previews so live feel passes can compare range/shape directly
- [x] Enable crate pull by default for testing, add range falloff to the pull, and let high-speed crates damage crates/enemies while lightly knocking back the player on intact hits
- [x] Remove the recurring headless verifier leak warning by cleaning up temporary verification resources properly before exit
- [ ] Decide whether the first wrench pass should next deepen through ground-pound cash-out, stronger stagger identity, or broader mark readability feedback
- [ ] Treat crate/box shove behavior as good enough for now unless a later combat/system need reopens it
- [ ] Expand the mechanic-debug menu beyond the first combat toggles so more prototype systems can be isolated independently as they come online
- [ ] Decide which additional non-basic systems should be promoted into the debug board next (boomerang recovery mode, projectile collision leniency, state rings, crate collision damage, Popper cadence, etc.)
- [ ] Decide whether the under-player state rings should split into clearer separate jobs (stance ring vs weapon-out ring vs buff/proc ring) instead of continuing to overlap
- [ ] If the wrench pass still reads well in motion, begin the first Popper cadence family next

## Rules For Now
- [x] Do not add meta progression yet
- [x] Do not add multiple characters yet
- [x] Do not add procedural generation yet
- [x] Do not add large art tasks yet
