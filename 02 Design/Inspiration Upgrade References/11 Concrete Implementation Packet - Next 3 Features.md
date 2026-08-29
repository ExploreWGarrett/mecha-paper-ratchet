# Concrete Implementation Packet — Next 3 Gameplay Features

This note turns the ranked next-build sequence into a **ready-to-build packet** for the next three real gameplay feature passes.

The goal is not to describe everything that might happen later.
The goal is to make the next implementation stretch cleaner by defining:
- exactly which features come next
- what each feature is supposed to accomplish
- which docs should be updated alongside it
- which verification questions should be answered before moving on

---

## Scope of this packet
This packet covers the first three implementation-facing feature passes after live-feel validation/tuning work:

1. **First wrench close-range commitment family**
2. **First Popper cadence family**
3. **First Gun Kata / alternation fusion**

It assumes that baseline feel validation and Popper baseline tuning are either already completed or treated as prerequisites for starting these feature passes.

---

## Prerequisite checkpoint before feature work
Before building Feature 1, confirm these questions in live play:
- does melee spacing feel good enough to deepen?
- does boomerang throw/return timing feel readable enough to support follow-up systems?
- does the Popper feel close enough to a rhythm weapon that upgrades will sharpen it instead of compensating for it?

If the answer to any of those is still “not really,” tune the baseline before starting feature implementation.

---

# Feature 1 — First Wrench Close-Range Commitment Family

## Why this is first
This is the strongest first implementation family because it:
- reinforces melee-first identity
- creates visible decisions
- avoids the most dangerous early proc/recall webs
- teaches the player the game’s preferred risk posture: commit, confirm, cash out

## Target fantasy
The player should feel that staying close and timing the wrench well creates a better payoff than passively kiting.

## Recommended first package
Build a small first family around:
- **third-hit mark application**
- **spin pull / close-range grouping**
- **catch-confirm into a stronger next melee hit**

Do **not** build the larger recall/detonation web yet.

## Desired behavior outcomes
After this pass, the player should be able to say:
- “my wrench combo sets something up”
- “my spin helps group enemies for a follow-up” 
- “catching the wrench can matter to my next melee decision”

## What docs should be updated alongside it
- `03 Systems/Wrench Popper Upgrades and Fusion Planning.md`
- `04 Prototype/Combat Prototype.md`
- `06 Tasks/Next Actions.md`
- optionally `03 Systems/Exploit Risk Grading for First Upgrade Families.md` if new guardrails are discovered

## Verification questions after implementation
- does this family make close-range play more intentional rather than just stronger?
- can the player clearly feel the setup and payoff windows?
- does the family remain readable in a crowded fight?
- do grouped enemies create exciting pressure, or just visual confusion?
- did any new exploit risk appear around repeated mark generation or catch-confirm loops?

## Failure signs
Stop and reassess if:
- the upgrade mainly behaves like invisible damage inflation
- it pushes players toward passive waiting rather than active commitment
- it creates too much crowd lock with too little risk
- it makes the catch state mandatory in an awkward way instead of rewarding skillful use

---

# Feature 2 — First Popper Cadence Family

## Why this is second
The Popper needs its own authored identity before it can be trusted as half of a fusion route.
A cadence family is the safest way to give it shape without turning it into a dominant safe gun.

## Target fantasy
The Popper should feel like a rhythm/set-up weapon, not just a generic ranged fallback.

## Recommended first package
Build a small first family around:
- **every-Nth-shot payoff**
- **brief pause -> stronger next shot**
- **a short cadence window that can later support alternation**

Keep it visible and low-branching.
Do **not** jump straight to ricochet/split/echo complexity.

## Desired behavior outcomes
After this pass, the player should be able to say:
- “the gun has a rhythm”
- “pausing or timing my shots matters”
- “the Popper feels different from just holding fire forever”

## What docs should be updated alongside it
- `03 Systems/Wrench Popper Upgrades and Fusion Planning.md`
- `04 Prototype/Combat Prototype.md`
- `06 Tasks/Next Actions.md`
- optionally `03 Systems/Exploit Risk Grading for First Upgrade Families.md` if cadence windows expose new escalation issues

## Verification questions after implementation
- does the Popper now feel like a weapon with timing identity?
- do the cadence windows read clearly under movement pressure?
- does the family encourage purposeful rhythm instead of generic uptime?
- does ranged play still feel complementary to melee rather than dominant over it?
- are any cadence bonuses drifting toward permanent hidden DPS inflation?

## Failure signs
Stop and reassess if:
- the optimal behavior is just uninterrupted safe firing
- the player cannot tell when the stronger window is active
- the Popper becomes too rewarding compared to close-range commitment
- the system only changes numbers, not the player’s firing behavior

---

# Feature 3 — First Gun Kata / Alternation Fusion

## Why this is third
This is the first mixed-weapon identity test.
It should come only after both weapon families feel real enough to interlock.

## Target fantasy
The player should feel rewarded for intentionally alternating between melee and ranged actions.
This should become the first truly recognizable “sentence” the combat system speaks.

## Recommended first package
Build a simple fusion around:
- **shot opens melee confirm window**
- **melee primes next shot**
- **short alternation chain bonus with visible timing**

Keep it short-windowed, authored, and easy to explain.

## Desired behavior outcomes
After this pass, the player should be able to say:
- “shooting sets up my wrench”
- “my wrench sets up my next shot”
- “alternating feels better than camping one mode”

## What docs should be updated alongside it
- `03 Systems/Wrench Popper Upgrades and Fusion Planning.md`
- `04 Prototype/Combat Prototype.md`
- `06 Tasks/Next Actions.md`
- `03 Systems/Exploit Risk Grading for First Upgrade Families.md` if the fusion exposes new chain-safety or refresh-loop questions

## Verification questions after implementation
- does alternation feel natural or forced?
- can the player understand the loop without reading a wall of explanation?
- does the fusion create a real weapon conversation instead of two unrelated bonuses?
- does the ranged side still support melee-first identity instead of overshadowing it?
- do alternation windows create expression without opening low-risk reward loops?

## Failure signs
Stop and reassess if:
- the fusion feels like two disconnected buffs instead of one combat sentence
- the safest ranged behavior still beats alternating
- the timing windows are too hidden to read in motion
- the fusion mostly increases output without changing choices

---

## Shared documentation rule for all three features
For each feature pass, update:
1. the main system note (`03 Systems/...`)
2. the prototype state note (`04 Prototype/Combat Prototype.md`)
3. the task tracker (`06 Tasks/Next Actions.md`)
4. exploit-risk notes if the implementation reveals a new class of failure

That keeps planning and reality aligned as the toybox becomes more specific.

---

## Shared verification rule for all three features
After each feature pass, answer these before moving to the next one:
- did this make the player do something new on purpose?
- is that new behavior readable in motion?
- did the feature strengthen melee-first identity?
- did the feature stay understandable without a huge explanation burden?
- did it create any new duplication, safety-loop, or multiplication risk?

If the answer is “no” to the first three or “yes” to the last one without a good gate, the next feature should wait.

---

## What this packet intentionally excludes
This packet does **not** include:
- mark + recall detonation webs
- heavy projectile split/ricochet/echo webs
- strong thrown-state safety kits
- money-yield multiplier upgrades
- fusion-of-fusion capstones

Those belong later, after the first three features prove the project’s identity more clearly.

---

## Simplest next-step summary
If implementation starts soon, the next three feature passes should be:

1. **wrench close-range commitment**
2. **Popper cadence identity**
3. **Gun Kata alternation fusion**

Each one should be followed by:
- doc updates
- focused playtest questions
- exploit-risk review

## Bottom line
The best next build is not the flashiest route.
It is the route that makes the game’s core sentence clearer:

- commit with the wrench
- time the Popper
- alternate on purpose

If those three become fun and readable, the rest of the progression layer has something real to build on.