# Feature Pass Implementation Checklists

This note turns the pre-implementation packet into **practical checklists**.

Use these lists immediately before, during, and after each feature pass.
The goal is to prevent implementation drift.

---

## How to use this note
For each feature pass:
1. complete the **before build** checklist
2. complete the **build focus** checklist
3. complete the **doc sync** checklist
4. complete the **post-pass review** checklist
5. only move to the next feature if the pass still looks healthy

---

# Feature 1 — Wrench Close-Range Commitment Family

## Before build
- [ ] Re-read `03 Systems/Wrench Popper Upgrades and Fusion Planning.md`
- [ ] Re-read `03 Systems/Exploit Risk Grading for First Upgrade Families.md`
- [ ] Confirm the target package is still limited to:
  - third-hit mark application
  - spin pull / close-range grouping
  - catch-confirm into a stronger next melee hit
- [ ] Confirm recall detonation is still out of scope
- [ ] Confirm the goal is **more intentional close-range play**, not raw damage inflation

## Build focus
- [ ] Make the setup/payoff visible in normal play
- [ ] Keep enemy grouping readable in 3D space
- [ ] Keep the family centered on melee commitment
- [ ] Avoid turning catch-confirm into passive always-on value
- [ ] Avoid hidden chain math the player cannot parse

## Doc sync after implementation
- [ ] Update `04 Prototype/Combat Prototype.md` with what now exists
- [ ] Update `03 Systems/Wrench Popper Upgrades and Fusion Planning.md` with what was actually implemented versus only planned
- [ ] Update `06 Tasks/Next Actions.md` with completed work and new tuning follow-ups
- [ ] Update `03 Systems/Exploit Risk Grading for First Upgrade Families.md` if new abuse cases or guardrails were discovered

## Post-pass review questions
- [ ] Did this create a new close-range decision?
- [ ] Can the player feel when setup becomes payoff?
- [ ] Does grouping create satisfying pressure instead of unreadable clumping?
- [ ] Is melee still the source of the reward rather than a formality?
- [ ] Did any mark or catch loops become too cheap to repeat?

## Stop conditions
Stop before moving on if:
- [ ] the feature mostly behaves like a hidden damage buff
- [ ] the feature is hard to read in motion
- [ ] the safest loop is better than the committed loop
- [ ] exploit-risk questions are unresolved

---

# Feature 2 — Popper Cadence Family

## Before build
- [ ] Confirm Popper baseline tuning is in a good enough place to judge cadence honestly
- [ ] Re-read `03 Systems/Wrench Popper Upgrades and Fusion Planning.md`
- [ ] Re-read `03 Systems/Exploit Risk Grading for First Upgrade Families.md`
- [ ] Confirm the target package is still limited to:
  - every-Nth-shot payoff
  - brief pause -> stronger next shot
  - short cadence window that can later support alternation
- [ ] Confirm ricochet/split/echo escalation is still out of scope

## Build focus
- [ ] Make the rhythm visible enough that the player can feel it without UI overload
- [ ] Keep the Popper complementary to melee, not safer-and-better than melee
- [ ] Reward timing and shot discipline, not raw hold-fire uptime
- [ ] Keep the number of simultaneous cadence states low
- [ ] Avoid bonuses that silently become permanent DPS inflation

## Doc sync after implementation
- [ ] Update `04 Prototype/Combat Prototype.md`
- [ ] Update `03 Systems/Wrench Popper Upgrades and Fusion Planning.md`
- [ ] Update `06 Tasks/Next Actions.md`
- [ ] Update `03 Systems/Exploit Risk Grading for First Upgrade Families.md` if cadence interactions exposed new escalation paths

## Post-pass review questions
- [ ] Does the Popper now have a real timing identity?
- [ ] Is the stronger window readable while moving, dodging, and locking on?
- [ ] Does this encourage purposeful firing behavior?
- [ ] Is ranged stance still additive rather than dominant?
- [ ] Did cadence rewards start combining too cleanly with future support hooks?

## Stop conditions
Stop before moving on if:
- [ ] the player cannot tell when the cadence window matters
- [ ] uninterrupted firing is still obviously optimal
- [ ] ranged pressure now invalidates close-range commitment
- [ ] the family is mostly statistical rather than behavioral

---

# Feature 3 — Gun Kata / Alternation Fusion

## Before build
- [ ] Confirm Feature 1 and Feature 2 both feel real enough to interlock
- [ ] Re-read `03 Systems/Wrench Popper Upgrades and Fusion Planning.md`
- [ ] Re-read `03 Systems/Exploit Risk Grading for First Upgrade Families.md`
- [ ] Confirm the target package is still limited to:
  - shot opens melee confirm window
  - melee primes next shot
  - short alternation chain bonus with visible timing
- [ ] Confirm mark+recall explosion webs are still out of scope

## Build focus
- [ ] Make the fusion feel like one combat sentence, not two unrelated buffs
- [ ] Reward alternation, not awkward forced weapon swapping
- [ ] Keep timing windows short, visible, and authored
- [ ] Protect melee-first identity while still letting the Popper matter
- [ ] Avoid self-refresh loops where one side recreates the other too easily

## Doc sync after implementation
- [ ] Update `04 Prototype/Combat Prototype.md`
- [ ] Update `03 Systems/Wrench Popper Upgrades and Fusion Planning.md`
- [ ] Update `06 Tasks/Next Actions.md`
- [ ] Update `03 Systems/Exploit Risk Grading for First Upgrade Families.md` if alternation loops introduce new safety or refresh abuse

## Post-pass review questions
- [ ] Does alternation feel natural?
- [ ] Can the player explain the loop in one sentence?
- [ ] Does the fusion produce new choices instead of just more output?
- [ ] Does the ranged side still support rather than replace melee-first identity?
- [ ] Did the fusion introduce any cheap loop where the reward rebuilds its own setup too easily?

## Stop conditions
Stop before moving on if:
- [ ] the fusion feels disconnected
- [ ] the safest single-weapon route still beats alternation
- [ ] timing windows are too hidden or too fussy
- [ ] the fusion mainly increases numbers without changing behavior

---

## Shared pass-close checklist
Use this after every one of the three feature passes.

- [ ] The feature changed player behavior on purpose
- [ ] The new behavior is readable in motion
- [ ] The feature kept the project melee-first
- [ ] The feature can be described simply
- [ ] The feature did not create a new obvious exploit loop
- [ ] The updated docs match reality
- [ ] The next pass is still the right next pass

## If any item above fails
Do not force progress just because the sequence exists.
Pause, retune, and update the docs first.