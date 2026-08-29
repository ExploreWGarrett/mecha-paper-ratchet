# Wrench, Popper, Upgrades, Mutations, and Fusion Planning

## Why this note exists
The current prototype already has two real weapon identities:
- the **wrench / boomerang melee kit**
- the **Paper Popper pistol**

This note pivots planning toward how those two weapons can grow through:
- direct upgrades
- mutations of those upgrades
- fusion between wrench and Popper behaviors
- support upgrades that make those fusions stronger
- a second layer where fusion results themselves can mutate or fuse again

## Important planning pivot
There are currently **mixed feelings about the Momentum plan**.

That does not mean the idea is dead. It means Momentum should stop driving the next design pass until the weapon/upgrade language is clearer.

For now:
- treat Momentum as optional future glue, not the centerpiece
- prioritize upgrade trees and mutation logic that are fun even with **no Momentum system at all**
- only let Momentum come back later if it helps already-fun weapon interactions become more expressive

## Core rule to preserve
Before accepting any upgrade or mutation idea, ask:

> Does this create a new decision, setup, payoff, route, or timing question?

If the answer is no, it is probably just a stat bump and should either:
- stay low-rarity/common filler
- be merged into a more interesting upgrade
- or become part of a threshold mutation instead of a standalone pick

## Anti-exploit watchouts
Before implementing any future weapon upgrade, mutation, or fusion route, cross-check [[03 Systems/Anti-Exploit Review Checklist]].

Highest-risk failure modes for this note's ideas:
- **recall hit-count abuse** where one throw/return counts too many payout events on one target or cluster
- **mark -> cash-out -> re-mark loops** where a payoff accidentally rebuilds its own setup too easily
- **ricochet / split / echo multiplication** on the Popper side making projectile counts explode faster than the encounter can answer
- **thrown-state safety abuse** where fallback attacks plus boomerang uptime remove too much danger while preserving reward
- **fusion self-refresh** where one weapon primes the other and the other immediately recreates the first weapon's strongest condition

If a route looks exciting but suspicious, treat it as `Watch`, `High risk`, or `Run killer` using the checklist note before it graduates from planning to implementation.

## Baseline weapon identities

### Wrench / boomerang identity
Current strengths:
- close-range control
- returning-path setups
- melee/ranged hybrid feel
- expressive spacing and repositioning
- potential for mark, gather, launch, recall, and detonation loops

Current pressure point:
- while thrown, the player temporarily shifts into fallback attacks, which is already a natural foundation for upgrades that care about **armed / disarmed / recall timing**

### Paper Popper identity
Current strengths:
- reliable pressure at range
- cadence-based rhythm
- clean setup for mark, burst, pin, or combo-cashout rules
- easy bridge between safe poke and aggressive follow-up

Current pressure point:
- if left too simple, it risks becoming “just the gun” instead of a weapon with its own toy-like personality

## Upgrade buckets to use from day one
Every future upgrade should use tags the systems can read.

### Weapon tags
- `wrench`
- `boomerang`
- `pistol`
- `projectile`

### Function tags
- `mark`
- `detonate`
- `recall`
- `pierce`
- `split`
- `ricochet`
- `gather`
- `launch`
- `stagger`
- `combo`
- `cadence`
- `support`
- `fusion`

### Positional tags
- `close_range`
- `long_range`
- `air`
- `ground`
- `return_path`
- `flank`

### Style / risk tags
- `setup`
- `payoff`
- `precision`
- `aggressive`
- `control`

## Wrench upgrade families

### 1. Return-path family
These upgrades make the return lane matter.

Examples:
- **Catchwire Arc** — recall path lightly tugs enemies toward the returning wrench
- **Backspin Teeth** — returning hits deal more stagger than outbound hits
- **Slipstream Recall** — player gets a brief speed burst when catching the wrench
- **Thread the Needle** — each enemy pierced on recall slightly tightens the next melee follow-up window

#### Mutation directions
- multiple `recall + combo` tags mutate into **Recall Detonation**: marked enemies explode when the wrench passes back through them
- `recall + gather + air` mutates into **Hangtime Snare**: the wrench pauses briefly before dragging a small cluster through a line

### 2. Close-range commitment family
These upgrades reward staying in danger.

### Current redesign direction
- the **boomerang throw itself** is now drifting toward dedicated ability-slot behavior instead of staying married to crouch attack forever
- **spin pull** should be reworked toward a short-radius pre-hit vacuum that can pull nearby enemies into the spin window, especially after upgrades deepen it
- **crate pull** should remain separate from enemy pull so it can become its own utility/physics route rather than automatic collateral on every crowd-control spin

### Current implementation status
The first pass of this family is now live in the prototype as a small, readable package:
- **Grease Pencil Edge** behavior: the third melee combo hit applies a visible wrench mark
- **Corner Fold** behavior: spin attacks pull nearby enemies inward to tighten close-range follow-up windows
- **Catch Confirm** behavior: catching the wrench primes one stronger next melee hit, and that hit consumes a wrench mark for extra payoff instead of enabling an endless refresh loop

### Current architecture note
- Player-side runtime ownership is now componentized so camera, settings, ability-slot, and combat-input behavior can be tuned without expanding the player monolith.
- Main-scene ownership is now also componentized: level spawning/lifecycle, debug toggles, and live settings are separate controllers, with `main.gd` acting as the run/menu coordinator.
- Keep future upgrade implementation inside these boundaries: new encounter/layout work should go through the level controller, live prototype toggles through the debug controller, and player-facing option changes through the settings controller.

Current intended read:
- combo into mark
- spin to keep enemies close enough to matter
- catch the wrench and spend the confirm on purpose

Current guardrails already built in:
- wrench marks are single-state rather than stack spam
- Catch Confirm stores only one ready state at a time
- Catch Confirm expires on a timer instead of stockpiling forever
- the confirm consumes itself on the next enemy melee hit

### Current implementation shape:
- these behaviors are now exposed as toggleable / tunable player-side settings rather than assumed permanent baseline rules
- mark application, mark duration, spin-pull strength, Catch Confirm duration, and Catch Confirm bonus values can all be disabled or retuned cleanly for testing
- this keeps the prototype aligned with the intended future structure where these behaviors can graduate into explicit upgrade rewards instead of staying always-on forever
- the boomerang / wrench throw input now sits on an **ability-slot assignment scaffold**:
  - first open slot fills in `E`, then `F`, then `Q`
  - the current wrench-throw ability can be manually reassigned in the pause/settings menu
  - later unlocks can reuse this same slot-assignment structure instead of needing another hardcoded input pass
- `Q` is no longer safe as lock-on because it is part of the ability-slot lane, so lock-on now lives on `R` and `Tab` for feel testing while the armed-stance toggle moved to `T`
- lock-on target selection now biases toward the enemy **nearest the player’s current look direction**, instead of simply snapping to the closest body in the arena
- lock-on target selection now anchors off the **camera-centered look line** so over-the-shoulder framing and target choice agree more closely in live play
- boomerang return now tries a **blocked-path recovery arc** before conceding to a timeout fail-safe, so wall traps are less likely to leave the player disarmed
- the player now has a first **soft sky barrier** pass: vertical launches are still allowed, but upward speed gets damped and extra downward pull scales up once the player climbs beyond the configured ceiling band
- spin pull now begins from a nearby vacuum-window pass before the damage check so later upgrade depth can let the same spin catch enemies pulled inward fast enough
- standing spin now reads more like a shorter **sphere-ish** catch with better vertical coverage, while crouch spin reads more like a shorter **disc** across the floor with weaker vertical reach
- both spin variants now expose animated hit-volume previews so feel passes can compare their real space claims directly in motion
- crate pull now exists as a separate spin modifier hook with its own toggles, radius, strength, and yank tuning so it can stay isolated from enemy pull
- crate pull is currently enabled by default for testing and now scales by range so nearby crates are pulled harder than far crates
- crate collisions can now cash out into speed-scaled damage against other crates and enemies, and intact crate hits can apply a lighter speed-scaled knockback to the player
- readability support now includes right-side proc notices, a player state ring, and an enemy mark ring
- a `~`-driven **mechanic debug menu** now exists as a scaffold for live toggling of isolated combat rules while the prototype is still in heavy feel-debug mode
- that debug surface now lives as its **own overlay separate from pause**, and it currently exposes first-pass toggles for wrench throw, lock-on, Paper Popper, weapon stance, wrench mark, enemy spin pull, crate pull, Catch Confirm, sky resistance, and camera shake
- early Paper Popper feel tuning now also includes a small crosshair, center-biased projectile spawn, and a slightly closer/higher default third-person camera so aim/parallax can be judged more honestly
- the default chase camera is now pushed further toward an over-the-shoulder framing and looks farther ahead so the center crosshair sees into combat space instead of collapsing back onto the player silhouette
- follow-up camera tuning lowers that chase framing, keeps more of the player silhouette in view, and reduces the "flying around the player" feel by blending the aim focus back toward the player anchor
- while unlocked and idle, player facing now eases back toward the camera heading so the camera feels more like a look-direction controller instead of a detached orbit rig
- free-camera projectile aim now resolves from a **camera-center raycast target** and then corrects the spawned projectile back toward that exact crosshair point, while lock-on aim still travels directly toward the locked target
- enemy spin pull is no longer treated as part of the default wrench baseline; it now starts **off** and is meant to be re-enabled from the debug-toggle surface when you specifically want to test that rider
- the debug-toggle surface now treats nearly everything beyond **basic movement + base jump + base wrench melee** as fair game for sandbox isolation: jump variants, dodge/roll tools, ground pound, ranged/stance systems, proc riders, lock-on, sky resistance, and camera shake can all be flipped independently from the start
- the separate debug overlay is now reorganized into a **scrollable three-column board** with grouped movement / combat / world-feedback sections so the toggle surface can grow without becoming unusably tall
- the mark proc is now labeled more plainly as **Enemy Mark on Hit** in the debug surface
- settings/camera defaults now bias toward playability after repeated first-person feel checks failed: **10%** startup volume and **Default/chase camera** as the startup camera; **First Person (Experimental)** is available again as an explicit non-default mode so it can be repaired rather than silently disappearing
- the player runtime has now been split into cooperating scene components: `PlayerCameraController` owns camera modes/aim/shake, `PlayerSettingsController` owns live camera settings, `PlayerAbilityController` owns ability-slot assignment, and `PlayerCombatController` owns combat input routing; `player.gd` remains the movement/physics orchestrator and retains stable compatibility methods for `main.gd`, projectiles, and boomerang callbacks
- the pause/settings surface now carries a grounded first-pass options set that is fully live today rather than fake placeholders: master volume, mouse sensitivity, camera FOV scale, difficulty scalar, camera position, wrench-throw slot, invert look Y, crosshair visibility, and camera shake
- next settings candidates to log for later revision/addition: separate music vs SFX levels, input rebinding, crouch hold/toggle choice, lock-on behavior preferences, crosshair styling, shoulder-side default, first-person camera redesign, and any future Popper aim-assist / projectile-leniency controls if feel work still demands them

Latest playtest read:
- the user does **not** currently want mark application, spin pull, or Catch Confirm in the default wrench kit
- the base boomerang throw/return feel now seems like the part that should remain default
- mark readability is too weak right now; damage shifts are sometimes noticeable, but the state itself is not communicated clearly enough
- spin pull as a concept is liked, but the current version feels wrong; it should likely become a fast short-radius pull field rather than reading like it only matters on enemies already hit by the spin
- with enough upgrades, a stronger spin-pull route may be allowed to yank enemies in quickly enough that the same spin trigger can still connect
- a separate crate-pull upgrade path is desired instead of making the enemy-pull version also drag boxes by default
- Catch Confirm needs much clearer buff/state feedback on the player side before it can be judged properly as a real reward loop
- better right-side status notices plus stronger enemy/player visual markers are desired for future buff/debuff testing
- crouch-triggered boomerang throw may itself eventually become upgrade-gated or remapped into an ability slot (`E`, `Q`, or `F` were suggested), because it currently fights movement and can blur into dodge input

Examples:
- **Grease Pencil Edge** — third melee hit applies a mark
- **Panel Cracker** — heavy melee launches small enemies slightly
- **Corner Fold** — spin attacks pull enemies inward before the last hit
- **Catch Confirm** — catching the wrench empowers the next melee strike

#### Mutation directions
- `wrench + mark + payoff` mutates into **Cash-Out Slam**: ground pound consumes wrench marks for a burst
- `wrench + stagger + aggressive` mutates into **Paper Breaker**: staggered enemies chain a short shock hit to nearby targets

### 3. Thrown-state survival family
These upgrades make the disarmed window more interesting.

Examples:
- **Bareknuckle Backup** — thrown-state punch gains slightly better lunge
- **Emergency Sweep** — thrown-state spin briefly clears projectiles
- **Grip Memory** — catching the wrench reduces next throw cooldown
- **Desperation Rhythm** — alternating punch and recall speeds recovery

#### Mutation directions
- `throw_state + recall + aggressive` mutates into **Hot Return**: catching the wrench emits a close shock ring
- `throw_state + projectile_clear` mutates into **Vacuum Catch**: emergency spin draws nearby bullets inward before deleting them

## Paper Popper upgrade families

### 1. Cadence family
These upgrades change rhythm, not just DPS.

Examples:
- **Foldback Slide** — sustained fire tightens cadence into a cleaner stream
- **Offbeat Burst** — every fourth shot becomes a stronger rhythm shot
- **Margin Tap** — pausing briefly primes the next shot
- **Paper Metronome** — alternating primary and secondary boosts accuracy/impact

#### Mutation directions
- stacked `cadence + precision` mutates into **Staccato Engine**: perfect rhythm chains spawn echo shots
- `cadence + combo + melee` mutates into **Gun Kata Margin**: melee resets a stronger follow-up shot window

### 2. Mark / payoff family
These upgrades make the Popper a setup weapon.

Examples:
- **Margin Notes** — repeat hits write marks on a target
- **Index Tabs** — secondary shot cashes out marks for knockback or burst
- **Sticky Caption** — enemies tagged by Popper take stronger recall-path effects
- **Proofreader** — marked enemies reveal a weak point effect for precise follow-up

#### Mutation directions
- `pistol + mark + detonate` mutates into **Redline Burst**: full-mark enemies burst in a small cone
- `mark + precision + payoff` mutates into **Editor’s Cut**: cash-out shot splits toward nearby marked enemies

### 3. Utility projectile family
These upgrades make the Popper less generic.

Examples:
- **Paper Jam** — slower shots briefly pin enemies
- **Carbon Copy** — every few bullets echo behind the first
- **Ruler Skip** — shots ricochet once at shallow angles
- **Staple Trail** — bullets leave a short damaging seam in the air

#### Mutation directions
- `projectile + ricochet + split` mutates into **Doodle Swarm**: ricochets split after first impact
- `pin + melee + combo` mutates into **Bullet Board**: pinned enemies take bonus wrench follow-up effects

## Direct wrench + Popper fusion concept
This should not just mean “use both at once.”
It should mean the two weapons begin rewriting each other’s rules.

## Fusion archetypes

### Fusion A: Mark and Recall
Popper marks targets. Wrench recall cashes them out.

Core loop:
1. Popper tags or stacks marks at range
2. player throws wrench through the group
3. recall path detonates or re-reads the marks
4. melee cleanup confirms the survivors

Support upgrades:
- mark duration
- mark spread on kill
- recall width
- faster catch recovery
- payout effects on marked recall hits

Mutation ideas:
- **Annotated Return** — each recalled mark adds one extra micro-hit on the way back
- **Red Pen Orbit** — marked enemies briefly orbit the wrench’s return line before bursting

### Fusion B: Pin and Smash
Popper controls space; wrench cashes out clustered or pinned targets.

Core loop:
1. Popper pins, slows, or funnels enemies
2. wrench or spin gathers / launches
3. ground pound or heavy melee cashes out the setup

Support upgrades:
- pin duration
- launch strength
- slam radius
- stagger bonus vs pinned enemies

Mutation ideas:
- **Bullet Board Break** — melee on pinned enemies causes a short line explosion through the cluster
- **Pinned Recall** — recalled wrench drags pinned targets farther than normal

### Fusion C: Gun Kata Alternation
Alternating between Popper and wrench becomes the mechanic.

Core loop:
1. ranged hit opens a confirm window
2. melee hit buffs the next shot
3. alternating keeps the chain alive

Support upgrades:
- swap-speed incentives
- shot-after-melee bonuses
- melee-after-shot bonuses
- chain reset protection for short delays

Mutation ideas:
- **Panel Rhythm** — alternating weapon types spawns bonus slice trails
- **Backbeat Catch** — catching the wrench instantly primes an empowered pistol burst

### Fusion D: Boomerang Sidearm Orbit
The pistol becomes stronger specifically while the wrench is out.

Core loop:
1. throw wrench
2. use Popper during the disarmed window
3. recall for payoff

Support upgrades:
- thrown-state pistol bonuses
- recall speed
- pistol bonuses against wrench-tagged enemies
- auto-reload/overheat-style recovery tied to catches

Mutation ideas:
- **Orbit Fire** — pistol shots curve slightly toward enemies near the wrench path
- **Catch Reload** — catching the wrench reloads or empowers the next Popper volley

## Complementary support upgrades
These are not weapon-locked, but they make the fusion builds better.

### Shared support families
- **Tag Extender** — mark, pin, or recall debuffs last longer
- **Setup Insurance** — setup effects lose less value if the player is interrupted
- **Cash-Out Lens** — payoffs deal more stagger/radius, not just damage
- **Mobility Thread** — stylish movement improves fusion consistency
- **Chain Keeper** — short grace period before setup stacks expire

### Good generic mutations
- `support + setup + payoff` -> **Sequence Lock**: if setup and payoff happen in the right order, the next cycle is enhanced
- `support + recall + cadence` -> **Loop Closure**: catch timing tightens the next pistol rhythm state

## Fusion of upgrades
This is the next layer above simple synergies.
A fusion should appear when upgrade clusters imply a new combined rule.

### Examples
- `Margin Notes` + `Catchwire Arc` -> **Footnote Snare**
  - recalled wrench pulls marked enemies together before mark detonation

- `Paper Jam` + `Panel Cracker` -> **Pinned Breaker**
  - pinned enemies launched by wrench collisions burst into short shrapnel lines

- `Foldback Slide` + `Catch Confirm` -> **Return Rhythm**
  - catching the wrench temporarily upgrades Popper cadence state

- `Sticky Caption` + `Backspin Teeth` -> **Proof of Impact**
  - returning hits against pistol-tagged enemies cause stronger stagger and splash marks

## Fusion of fusions
This is the “layer out” you asked for.
These should be rare and special, because they can define entire runs.

### Rule for fusion-of-fusion design
A fusion-of-fusion should not merely stack two perks together.
It should create a **new loop identity** the player can describe.

### Candidate fusion-of-fusion identities

#### 1. Editor’s Boomerang
Built from:
- Mark and Recall fusion
- Gun Kata Alternation fusion

Run identity:
- pistol writes and organizes targets
- wrench recall edits the whole group at once
- alternating keeps the “page” live

Possible behavior:
- every recall-through on marked enemies stores “edits”
- next Popper secondary cashes those edits out as chained precision bursts

#### 2. Pinwheel Execution
Built from:
- Pin and Smash fusion
- Boomerang Sidearm Orbit fusion

Run identity:
- throw wrench
- use Popper to lock enemies into the wrench zone
- recall and slam during a compressed control window

Possible behavior:
- pinned enemies near the wrench path become tethered to the return lane
- return and ground pound together create a large payoff burst

#### 3. Comic Blender
Built from:
- Gun Kata Alternation fusion
- Return-path mutation family
- utility projectile mutations

Run identity:
- constant alternation, ricochet setup, return-lane slicing, and crowd churn

Possible behavior:
- alternating weapon types builds a short overdrive state
- during that state, recall path, bullets, and spin hits all inherit limited chain behavior

## Practical structure recommendation
For the real game later, the cleanest model is probably:

### Layer 1 — normal upgrades
Simple, readable, stackable, tagged.

### Layer 2 — mutations
Unlocked by thresholds, pairings, or stack counts within one weapon family.

### Layer 3 — fusions
Unlocked by crossing meaningful tags between wrench and Popper, or between a weapon family and a support family.

### Layer 4 — fusion-of-fusion states
Rare run-defining capstones that only appear when the player has already built a strong identity.

## Strong early implementation bias
When these systems begin implementation for real, bias toward:
1. one clean wrench setup/payoff family
2. one clean Popper mark/payoff family
3. one direct wrench+Popper fusion
4. one neutral support family that helps both
5. one mutation per family before inventing many new weapons

## Best first candidates to prototype later
If only a few should be tested first, these are the strongest:

### First wrench family to test
- recall / return-path / mark detonation

### First Popper family to test
- cadence / mark / cash-out

### First direct fusion to test
- Popper marks -> wrench recall detonates

### First support family to test
- chain duration / setup insurance / catch-confirm bonuses

### First fusion-of-fusion to test
- mark+recall plus gun-kata alternation

## Open questions
- how visible should upgrade recipes be to the player?
- should mutations be permanent for the run once earned, or conditionally active?
- should fusions appear as explicit rewards, or silently emerge from tag combinations?
- how many layers can exist before the system becomes unreadable?
- should the Popper remain the safer setup weapon, or should some wrench branches become the setup side instead?
- how much should thrown-state fallback attacks participate in wrench/Popper fusion logic?
- when a fusion-of-fusion appears, should it replace lower rules or sit on top of them?
