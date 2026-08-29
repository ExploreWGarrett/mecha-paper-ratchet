# Implementation Alignment Review Packet

This note is the **single review packet** to use before moving into code.

It is here to reduce scatter.
Instead of bouncing across many planning notes, this packet gathers the parts that matter most for the final pre-implementation review:
- what the game is trying to be
- what feel we are aiming for
- what the next build is actually supposed to do
- what must stay true while building
- what should explicitly stay out
- what needs to be reviewed together before green-lighting code work

---

## 1. Project identity in one page

### The game we are making
A solo-dev-friendly action roguelite with:
- Ratchet & Clank-style combat energy
- Paper Mario-inspired flat-character readability
- weird comic weapons
- compact, testable prototype scope

### Current priority order
1. combat feel first
2. camera readability second
3. lock-on clarity third
4. scope control always

### Current milestone
Build a paper character in a simple 3D arena that can:
- lock onto one enemy
- strafe
- jump
- shoot
- dodge one projectile
- defeat the enemy

---

## 2. What must be true about the feel
These are the non-negotiable feel targets.

### Core feel targets
- movement should feel responsive enough that staying close is fun, not dutiful
- melee spacing should feel readable enough that hits and whiffs make sense
- lock-on should support pressure, not create camera confusion
- the boomerang should feel intentional and buildable, not arbitrary
- the Popper should feel additive to melee, not like the game quietly became gun-first
- enemy pressure should be readable enough to judge the player kit honestly

### Readability targets
- the player should understand why a hit landed or missed
- projectile behavior should stay legible in 3D space
- boomerang return behavior should be readable under motion pressure
- enemy retaliation windows should remain visible

### Tone targets
- weird object-weapon identity
- comic/paper exaggeration
- authored absurdity
- no generic anonymous gun-upgrade sludge

---

## 3. What the next implementation wave is actually for
The next build wave is **not** for breadth.
It is for proving the first real combat sentence.

That sentence is:
- commit with the wrench
- time the Popper
- alternate on purpose

### Therefore the first implementation wave is for:
1. **wrench close-range commitment**
2. **Popper cadence identity**
3. **Gun Kata / alternation fusion**

### It is not for:
- flashy proc soup
- capstone-first design
- economy-first progression
- giant mutation webs
- projectile multiplication spectacle

---

## 4. First build focus — what we are really looking for

### Feature 1 — Wrench close-range commitment
We are looking for:
- visible setup and payoff
- better reasons to stay close
- stronger melee identity without runaway math
- group control that is readable, not muddy

### Feature 2 — Popper cadence
We are looking for:
- timing identity
- rhythm-based reward
- ranged support that complements melee
- a weapon that feels authored, not generic

### Feature 3 — Alternation fusion
We are looking for:
- a real conversation between weapons
- short, understandable timing windows
- a loop the player can explain in one sentence
- mixed-weapon play that feels special, not forced

---

## 5. What must stay out for now
These are the most important early exclusions.

### Do not bring these into the first wave
- mark + recall detonation webs
- heavy ricochet / split / echo projectile webs
- strong thrown-state safety kits
- money-yield multipliers
- fusion-of-fusion capstones
- large mutation recipe webs

### Why they stay out
Because they are the easiest ways to:
- muddy weapon identity
- distort reward priorities
- collapse melee-first pressure
- make the game unreadable too early
- create exploit-prone multiplication before the baseline is proven

---

## 6. Review questions to align on before coding
Use these questions during the pre-code review.

### Combat baseline review
- Is melee spacing already fun enough to deepen?
- Is the boomerang readable enough to build around?
- Is thrown-state fallback still a weaker tradeoff rather than a safe dominant stance?
- Is the Popper already close enough to its intended role?

### Identity review
- Does the wrench still feel foundational?
- Does the Popper feel like a toy with character rather than a generic pistol?
- Does the project still sound like itself?

### Scope review
- Are we still building the smallest useful next layer?
- Has anything flashy crept back into the first wave?
- Are we still protecting readability over coolness?

### Anti-exploit review
- What is most likely to break first?
- Are we protecting against mark/cash-out self-refresh loops?
- Are we protecting against recall hit-count inflation?
- Are we protecting against safe-state dominance?

---

## 7. What success looks like before the first code pass
We are ready to start coding the first feature only if all of these feel true:
- the combat baseline is fun enough to deepen
- the Popper is close enough to cadence-tuning territory
- the next three features are still disciplined and small
- the planning stack still agrees on what comes first
- the anti-exploit watchpoints are understood
- the review criteria for each feature pass are already defined

---

## 8. Review order
If we want the shortest useful review path before code, do it in this order:
1. `04 Prototype/2026-07-18 Baseline Feel Validation Session.md`
2. `04 Prototype/Combat Prototype.md`
3. `02 Design/Inspiration Upgrade References/18 2026-07-18 Readiness Gate Re-Run.md`
4. this packet
5. `02 Design/Inspiration Upgrade References/14 First Implementation Session Brief.md`

That order starts from live evidence, then current reality, then gate decision, then design alignment, then implementation handoff.

---

## 9. Final framing
The goal is not to review forever.
The goal is to make sure that when implementation starts, we are:
- building the right thing
- chasing the right feel
- protecting the project’s identity
- and not sabotaging ourselves with premature complexity

## Short version
If this packet still reads true after the live-play validation session, the project should move into code.