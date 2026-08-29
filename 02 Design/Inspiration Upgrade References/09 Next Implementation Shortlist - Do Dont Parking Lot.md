# Next Implementation Shortlist — Do / Don’t / Parking Lot

This note translates the design commandments, authority map, and exploit-risk grading into a practical shortlist for what the next real gameplay systems should and should not be.

The goal is to make the next implementation wave tighter.
Not just “what could be cool,” but:
- what should be built first
- what should be avoided for now
- what should stay parked until the game earns it

---

## Core filter used here
A next-step system is a strong candidate only if it does most of these:
- strengthens the current combat toybox
- preserves melee-first identity
- reads clearly in 3D space
- creates decisions rather than only multiplication
- carries manageable exploit risk
- fits the current prototype scope

---

## DO first
These are the best next implementation lanes.

### 1. Wrench close-range commitment family
**Build first:** yes
**Why:**
- matches melee-first identity
- creates visible risk/reward decisions
- graded safer than recall-heavy routes
- supports authored weapon personality instead of abstract proc soup

**Best first subtypes:**
- third-hit mark application
- spin pull / close-range grouping
- catch-confirm into a stronger next melee hit
- grounded cash-out that requires real commitment

**Why this is strong:**
It reinforces what the player is already doing instead of asking the game to survive a giant systems leap.

---

### 2. Popper cadence family
**Build first:** yes
**Why:**
- keeps the Popper as a rhythm/set-up tool rather than a generic safe gun
- graded as a manageable `Watch` instead of `High risk`
- supports alternation and timing
- strengthens ranged identity without displacing melee

**Best first subtypes:**
- every-Nth-shot payoff
- short pause -> next-shot benefit
- alternating input -> brief accuracy/impact window

**Why this is strong:**
It makes the Popper feel like a weapon with personality while staying readable and gateable.

---

### 3. Gun Kata / alternation fusion
**Build first:** yes
**Why:**
- one of the safest first fusion routes
- aligns directly with the melee+ranged identity you want
- rewards expressive play instead of passive stacking
- creates a describable loop the player can feel immediately

**Best first subtypes:**
- shot opens melee confirm window
- melee primes next Popper burst
- short alternation chain bonus with visible timing

**Why this is strong:**
It teaches the game’s mixed-weapon identity without opening the most dangerous proc/mark loops first.

---

### 4. Base crate economy tuning
**Build first:** yes, but only as tuning and containment
**Why:**
- economy already exists in prototype form
- needs tuning before expansion
- supports route value without becoming a major structural detour

**Best first subtypes:**
- crate value tuning
- stack density tuning
- pickup readability / route temptation tuning
- replay/restart reward-safety validation

**Why this is strong:**
It keeps the side-lane healthy before adding stronger money logic.

---

### 5. One readable first mutation per safe family
**Build first:** yes, but late in this first wave
**Why:**
- mutations should exist, but only after one clean family works
- mutation should rewrite behavior, not just inflate output

**Best first subtype examples:**
- a wrench close-range mutation that changes the cash-out read
- a cadence mutation that creates a distinct rhythm state

**Rule:**
No broad mutation web yet.
One clean mutation per proven family is enough.

---

## DON’T build yet
These are the routes most likely to distort the project if they land too early.

### 1. Mark + recall detonation webs
**Build now:** no
**Why not:**
- strongest current `Run killer` / high-escalation lane
- combines multi-hit pathing, stacked setup, and cross-weapon payoff too early
- likely to dominate the whole build language before the foundation is proven

**What to avoid specifically:**
- mark detonation on every recall pass
- recalled marks rewriting themselves
- support pieces that widen event count too fast

---

### 2. Heavy ricochet / split / echo projectile webs
**Build now:** no
**Why not:**
- high exploit risk
- high readability risk
- likely to turn the Popper into noise before its core identity is solid

**What to avoid specifically:**
- split inheriting split
- echo shots inheriting every proc
- ricochet + trail + mark all live at once in early builds

---

### 3. Strong thrown-state safety kits
**Build now:** no
**Why not:**
- directly threatens melee-first and thrown-state tension
- can turn the safest state into the strongest state
- high chance of quietly replacing the intended weapon identity

**What to avoid specifically:**
- broad projectile vacuum clears
- near-full safety during wrench-out play
- strong catch refunds that erase vulnerability

---

### 4. Money-yield multipliers as a first economy expansion
**Build now:** no
**Why not:**
- high exchange-rate risk
- likely to make crate routing too attractive too quickly
- easy way to accidentally make economy more important than combat

**What to avoid specifically:**
- raw crate-yield upgrades first
- early chain-reaction money spikes
- stacking payout bonuses before the base lane is tuned

---

### 5. Fusion-of-fusion capstones
**Build now:** no
**Why not:**
- too expensive for the current stage
- too likely to mask weak base families
- better as late validation of proven routes than as early aspiration implementation

---

## PARKING LOT
These are not bad ideas.
They just should wait until the project proves the earlier layer first.

### 1. Return-path family as a major pillar
**Why parked:**
- identity-rich
- dangerous if introduced too soon
- should arrive after close-range wrench play is already satisfying and controlled

### 2. Mark / payoff Popper family
**Why parked:**
- likely very important later
- currently too easy to become the center of everything
- better after cadence/alternation are established first

### 3. Pin-and-smash crowd-control fusion routes
**Why parked:**
- promising identity
- can become enemy-agency collapse too quickly
- better once baseline enemy behavior is more tuned

### 4. Crate chain-reaction spectacle systems
**Why parked:**
- could be fun later
- currently too likely to distort reward value and room flow

### 5. Large mutation recipe web
**Why parked:**
- better after one or two mutation lanes are proven readable
- too easy to create design sprawl now

---

## Recommended first implementation wave
If the next real gameplay content pass should stay disciplined, the wave should look like this:

### Wave 1A — safest identity-building additions
1. one **close-range wrench family**
2. one **cadence Popper family**
3. one **Gun Kata alternation fusion**
4. crate-value / density / safety tuning

### Wave 1B — only after 1A feels good
5. one **mutation** for the wrench family
6. one **mutation** for the cadence family
7. one extra support piece that sharpens alternation or catch timing

### Wave 1C — only after 1B is proven
8. first limited mark/payoff experiment
9. first limited return-path payoff experiment
10. only then revisit larger fusion webs

---

## Simple yes/no questions for future proposals
When a new idea comes up, ask:

### Build now if...
- does it reinforce melee-first identity?
- does it create a visible decision?
- does it read clearly in motion?
- can it be explained in one sentence?
- is its exploit risk manageable with simple gates?

### Delay if...
- does it multiply several systems at once?
- does it make the safe state stronger than the risky state?
- does it threaten to dominate all other upgrade routes?
- does it depend on a deeper economy/progression shell to feel justified?
- does it need lots of exception logic to stay fair?

---

## Current best answer to “what should we actually build next?”
Build toward:
- **close-range wrench commitment**
- **cadence-based Popper rhythm**
- **alternation fusion**
- **economy tuning, not economy expansion**

Avoid for now:
- **mark+recall explosions as a main lane**
- **projectile multiplication webs**
- **strong thrown-state safety**
- **money yield scaling**
- **fusion-of-fusion capstones**

## Bottom line
The game is most likely to get stronger if the next systems are:
- expressive
- readable
- melee-supportive
- rhythm-based
- tightly scoped

It is most likely to get muddier if the next systems are:
- multiplicative
- auto-scaling
- safe-state dominant
- economy-warping
- capstone-first instead of foundation-first