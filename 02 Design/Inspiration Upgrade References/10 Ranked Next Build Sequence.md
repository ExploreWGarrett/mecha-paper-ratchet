# Ranked Next-Build Sequence

This note takes the shortlist and turns it into an actual recommended build order for the next gameplay implementation wave.

It is not a giant roadmap.
It is the **next disciplined sequence**.

The point is to answer:
> what should we build next, in what order, and why that order instead of another one?

---

## Ranking logic used
A task ranks higher when it:
- reinforces the current melee-first toybox
- improves feel before adding complexity
- supports future upgrade structure without overcommitting to risky systems
- has manageable exploit risk
- creates useful information for the next task in line

---

## Recommended next-build order

### 1. Live-feel validation pass on the current baseline
**What this means:**
- playtest lock-on + melee spacing + movement chaining
- record what feels good and what still feels wrong
- verify that the current baseline is strong enough to deserve deeper upgrade work

**Why this is first:**
The project doctrine already says combat feel comes before progression cleverness.
If the base loop is still soft, any upgrade pass will muddy the signal.

**Main questions to answer here:**
- is melee spacing satisfying enough to deepen?
- is boomerang throw/return timing readable enough to support upgrades?
- is the Popper already close enough in feel to become a real rhythm weapon?

**Why it must happen before implementation-heavy upgrade work:**
Because it determines whether the next systems should sharpen the current loop or whether the current loop itself still needs mechanical correction first.

---

### 2. Tune the Popper baseline before adding Popper upgrades
**What this means:**
- tune cadence
- tune projectile speed / centerline feel
- tune fallback-melee penalty while armed
- tune reward timing around the Paper Popper unlock

**Why this is second:**
The cadence family is one of the safest first upgrade lanes, but only if the baseline Popper already reads clearly as a rhythm tool instead of a generic safe gun.

**What this unlocks later:**
- meaningful cadence upgrades
- meaningful alternation fusion
- cleaner read on whether ranged pressure is complementing melee or replacing it

**Why not skip straight to upgrades:**
Because bad baseline weapon feel plus upgrades creates false conclusions about the upgrade family itself.

---

### 3. Implement the first wrench close-range commitment family
**What this means:**
Build the safest first wrench family, centered on melee commitment rather than return-path proc math.

**Best first candidates inside the family:**
- third-hit mark application
- spin pull / close-range grouping
- catch-confirm into stronger next melee hit
- grounded cash-out that requires real commitment

**Why this is third:**
This is the strongest first “real content” family because it:
- reinforces melee-first identity
- creates visible decisions
- carries lower risk than recall-heavy routes
- gives the player something immediately expressive without opening giant systems risk

**What this should teach us:**
- whether melee commitment is fun enough to become the backbone of deeper builds
- whether grouped close-range payoffs read well in motion

---

### 4. Implement the first Popper cadence family
**What this means:**
Add the first real cadence/rhythm upgrade family only after the Popper baseline is tuned.

**Best first candidates:**
- every-Nth-shot payoff
- brief pause -> stronger next shot
- alternation-ready cadence window

**Why this is fourth:**
This is the ranged-side partner to the first wrench family.
It builds ranged identity without letting the game become “gun first, wrench second.”

**What this should teach us:**
- whether the Popper can feel authored and expressive instead of merely useful
- whether the player reads rhythm windows clearly under pressure

---

### 5. Implement the first Gun Kata / alternation fusion
**What this means:**
Build the safest first cross-weapon route:
- shot opens melee confirm
- melee primes next shot
- short chain bonus for alternating cleanly

**Why this is fifth:**
It depends on both previous families being real enough to interlock.
This is the first time the game should say:
> use both weapons on purpose, not just because both exist.

**Why this is a strong first fusion:**
- safer than mark+recall webs
- readable
- expressive
- strongly aligned with project identity

**What this should teach us:**
- whether the game’s mixed-weapon sentence actually feels special in play
- whether alternation is a real pillar or just an attractive planning concept

---

### 6. Tune and lock the base crate economy lane
**What this means:**
- tune crate value
- tune cluster density
- verify route temptation
- verify replay/restart reward safety
- make sure crates are worth detouring for without distorting combat pacing

**Why this is sixth instead of earlier:**
The base economy already exists and does not need conceptual expansion first.
What it needs is containment and calibration after the core combat-identity pass becomes clearer.

**What this should teach us:**
- whether the economy is correctly secondary
- whether crate value supports room routing without hijacking the run

---

### 7. Add one first mutation to the wrench family
**What this means:**
Take the proven first wrench family and add one mutation that changes the behavior read.

**Good first mutation shape:**
- changes close-range cash-out behavior
- changes timing or confirmation logic
- visibly changes the attack loop instead of just scaling it

**Why this is seventh:**
Mutation should come after a family proves it is fun in base form.
Otherwise mutation is just covering up uncertainty.

**What this should teach us:**
- whether mutations in this game read clearly enough to matter
- whether a behavior rewrite is easier to understand on the wrench side first

---

### 8. Add one first mutation to the cadence family
**What this means:**
Give the Popper one readable mutation that changes rhythm-state behavior rather than only output.

**Good first mutation shape:**
- changes cadence pattern
- changes timing reward window
- changes shot rhythm identity in a visible way

**Why this is eighth:**
It lets the ranged route prove it can mutate without immediately exploding into ricochet/split noise.

**What this should teach us:**
- whether rhythm-state mutations are legible enough to become a real lane
- whether the Popper remains a setup/alternation tool after mutation

---

## Strong “not yet” sequence warnings
Even after these 8 steps, still avoid moving too early into:
- mark + recall detonation webs
- strong thrown-state safety kits
- projectile split/ricochet/echo escalation
- money-yield multipliers
- fusion-of-fusion capstones

These should remain later-layer tests, not part of the first disciplined build sequence.

---

## Why this order is healthier than the tempting alternatives

### Tempting but wrong next step: build the flashy fusion first
Why not:
- it hides whether either base family is actually good
- it creates false excitement from system overlap instead of solid weapon identity

### Tempting but wrong next step: build mark+recall first
Why not:
- highest current identity temptation
- also the easiest way to dominate the whole design too early
- highest risk of turning the game into proc logic before the baseline is proven

### Tempting but wrong next step: build money upgrades early
Why not:
- easiest way to distort reward priorities
- adds economy pull before combat structure is settled

### Tempting but wrong next step: build a giant mutation web
Why not:
- too many moving parts before the first two weapon families are understood
- high chance of scope sprawl

---

## The best condensed next-build answer
If the next few real implementation tasks need to be said very simply, they are:

1. validate the current combat baseline in live play
2. tune the Popper baseline
3. build first wrench commitment upgrades
4. build first Popper cadence upgrades
5. build first alternation fusion
6. tune/contain crate economy
7. add one wrench mutation
8. add one Popper mutation

## Bottom line
The strongest next build wave is the one that:
- proves the base loop
- sharpens both weapons separately
- then teaches them to talk to each other
- and only after that starts asking the game to support mutation depth

That sequence is slower than jumping to capstones,
but it is much more likely to produce a real foundation instead of attractive confusion.