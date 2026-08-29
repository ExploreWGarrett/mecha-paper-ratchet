# First Implementation Session Brief

This note is the short handoff for the **first actual implementation session**.

It is meant to answer:
- what are we building first?
- what are we explicitly not building yet?
- what must stay true while we build?
- what docs must stay in sync as soon as reality changes?

---

## Build first
The first implementation session should stay focused on:
1. **wrench close-range commitment family**
2. **not** recall/detonation webs

The first concrete package should stay close to:
- third-hit mark application
- spin pull / close-range grouping
- catch-confirm into stronger next melee hit

This is the cleanest first test of whether the game’s melee-first promise is actually fun when extended.

---

## Do not build yet
Even if they sound tempting during implementation, leave these out of the first session:
- mark + recall detonation webs
- heavy ricochet / split / echo projectile behavior
- strong thrown-state safety kits
- money-yield multipliers
- fusion-of-fusion capstones
- broad mutation recipe webs

If one of those starts sneaking back in, scope has already drifted.

---

## What must stay true during implementation
- melee-first identity stays intact
- 3D readability beats theoretical coolness
- setup/payoff must be visible
- the feature should change player behavior, not just numbers
- anti-exploit discipline is part of the design pass, not follow-up cleanup

---

## Questions the first implementation session must answer
- does close-range commitment feel better with this first family?
- can the player read the setup and payoff under pressure?
- does grouping improve combat decisions without creating noisy piles?
- does catch-confirm feel rewarding without becoming mandatory or cheap?
- does the feature expose any new repeated-loop abuse?

---

## Immediate doc sync after the session
Update these before calling the pass complete:
- `04 Prototype/Combat Prototype.md`
- `03 Systems/Wrench Popper Upgrades and Fusion Planning.md`
- `06 Tasks/Next Actions.md`
- `03 Systems/Exploit Risk Grading for First Upgrade Families.md` if new risk findings appeared

If the docs are not updated, the planning chain becomes stale immediately.

---

## If the first pass goes well
Only then move to:
1. Popper cadence family
2. Gun Kata / alternation fusion

Do not jump past cadence straight to flashy fusion or projectile multiplication.

---

## If the first pass goes badly
If the first pass becomes muddy, unreadable, or too safe:
- stop
- retune the feature
- update the docs with what failed
- re-evaluate whether the package is still the right first family

Do **not** paper over weak feel with more upgrade complexity.

---

## Short version
The first implementation session exists to prove one thing:

> committed close-range wrench play becomes more expressive without becoming messy, dominant, or easy to abuse.

If that works, the rest of the planned sequence has a real foundation.
If it does not, the planning should adjust before more systems get stacked on top.