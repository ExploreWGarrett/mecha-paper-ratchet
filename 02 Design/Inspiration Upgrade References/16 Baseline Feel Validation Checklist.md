# Baseline Feel Validation Checklist

This note exists because the readiness gate came back **no-go** for implementation.

The planning stack is ready.
The prototype feel is not yet sufficiently validated in live play.

Use this checklist before re-running the readiness gate.

---

## Goal
Prove that the current combat baseline is strong enough that adding the first real upgrade family will teach the right lesson.

That means validating:
- melee spacing
- lock-on readability
- boomerang throw/return feel
- thrown-state fallback balance
- Popper baseline identity
- pause/state reliability in real play

---

## Session setup checklist
- [ ] Use the current prototype build without adding new feature complexity first
- [ ] Keep the test goal focused on **baseline feel**, not content quantity
- [ ] Be ready to record specific observations in `04 Prototype/`
- [ ] Re-read `04 Prototype/Combat Prototype.md`
- [ ] Re-read `02 Design/Inspiration Upgrade References/15 Readiness Gate Assessment - 2026-07-17.md`

---

## 1. Lock-on + melee spacing
### Validate
- [ ] Is lock-on easy to trust when circling enemies?
- [ ] Does melee range feel readable enough that whiffs feel understandable?
- [ ] Can the player reposition and re-engage without the camera fighting them?
- [ ] Do widened hit arcs feel generous without becoming sloppy?

### Watch for failure
- [ ] lock-on target behavior feels jumpy or confusing
- [ ] melee hits feel disconnected from visible spacing
- [ ] close-range combat reads as mush instead of intentional spacing

### Record explicitly
- [ ] what feels good
- [ ] what feels wrong
- [ ] whether this is already fun enough to deepen

---

## 2. Boomerang throw / return feel
### Validate
- [ ] Does the initial throw feel intentional and readable?
- [ ] Does collision return happen at a timing that feels understandable?
- [ ] Does the fail-safe auto-return feel like protection rather than awkward correction?
- [ ] Is the return timing stable enough to build future setup/payoff systems on top of it?

### Watch for failure
- [ ] return feels abrupt or arbitrary
- [ ] geometry collisions make the weapon feel unreliable
- [ ] catch timing feels too muddy to support future upgrade windows

### Record explicitly
- [ ] when the return feels best
- [ ] where it feels awkward
- [ ] whether collision return and fail-safe timing need retuning before upgrades

---

## 3. Thrown-state fallback balance
### Validate
- [ ] Are fallback punch/spin options useful enough to avoid helplessness?
- [ ] Are fallback options still clearly weaker than full wrench control?
- [ ] Does the thrown state preserve tension instead of becoming a comfy alternate stance?

### Watch for failure
- [ ] fallback attacks feel too weak to be satisfying at all
- [ ] fallback attacks feel strong enough that wrench-out tension collapses
- [ ] the player starts preferring the thrown state for safety or uptime

### Record explicitly
- [ ] whether fallback is underpowered, balanced, or too safe
- [ ] whether thrown-state identity still feels like a tradeoff

---

## 4. Popper baseline identity
### Validate
- [ ] Does the Popper already feel like it wants a rhythm identity?
- [ ] Is projectile speed / centerline feel good enough to judge cadence upgrades honestly?
- [ ] Does armed stance complement melee rather than replace it?
- [ ] Is fallback melee penalty while armed strong enough to preserve melee-first identity?

### Watch for failure
- [ ] the Popper already dominates the loop before upgrades exist
- [ ] the Popper feels too bland to support cadence meaningfully
- [ ] projectile behavior is too awkward to separate baseline issues from upgrade issues

### Record explicitly
- [ ] what makes the Popper feel additive
- [ ] what makes it feel dominant or flat
- [ ] whether cadence work should wait for more baseline tuning

---

## 5. Pause / state reliability
### Validate
- [ ] Does Escape pause/resume feel dependable in repeated live use?
- [ ] Does level-clear / pause flow feel stable enough that future reward selection states will not sit on obviously shaky ground?

### Watch for failure
- [ ] pause/resume produces friction, confusion, or instability
- [ ] state flow feels too brittle to trust before progression systems deepen

### Record explicitly
- [ ] whether pause/resume feels solid
- [ ] whether any state-flow issues should block further feature work

---

## 6. Enemy pressure baseline
### Validate
- [ ] Are grunt, flyer, and miniboss pressure readable enough to judge player tools honestly?
- [ ] Does the flying ranger pressure without becoming annoying kite tax?
- [ ] Is the miniboss AOE readable enough that dodge/spacing lessons feel fair?

### Watch for failure
- [ ] enemy pressure is still too noisy or too soft to evaluate weapon feel well
- [ ] the current roster creates unfair reads that contaminate player-tool testing

### Record explicitly
- [ ] whether enemy pacing is good enough for player-feature judgment
- [ ] whether more enemy tuning must happen before upgrades are meaningful

---

## Session-close questions
At the end of the validation pass, answer these plainly:
- [ ] Is the baseline combat loop fun enough to deepen?
- [ ] Is the Popper close enough to its intended identity?
- [ ] Is boomerang timing stable enough to support future setup/payoff design?
- [ ] Is thrown-state fallback balanced enough to preserve wrench identity?
- [ ] Is pause/state flow solid enough for deeper reward systems later?

If any of those are still no, the readiness gate should stay **no-go**.

---

## Required doc sync after the session
- [ ] Update `04 Prototype/Combat Prototype.md`
- [ ] Update `06 Tasks/Next Actions.md`
- [ ] Create or update a short findings note in `04 Prototype/`
- [ ] Re-run `13 Pre-Implementation Readiness Gate`

---

## Bottom line
This session is not about proving that the game has enough ideas.
It is about proving that the current toybox feels strong enough that the next idea added will be judged fairly.