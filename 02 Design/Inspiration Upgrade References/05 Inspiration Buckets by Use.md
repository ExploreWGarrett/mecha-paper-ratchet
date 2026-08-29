# Inspiration Buckets by Use

This note separates the inspiration pool by **how each title is most useful**.

That matters because not every game should be asked to do the same job.
Some are best for:
- upgrade-system structure
- weapon personality
- combat-feel pacing
- exploit-risk awareness

Trying to treat every reference as a full systems bible makes the pool noisier than it needs to be.

---

## 1. System references
These are the strongest references when the question is:
> how should upgrades, items, mutations, evolutions, or build-routing actually work?

### Primary system references

#### Risk of Rain 2
**Best for:**
- item stacking
- proc chains
- scaling from plain stat-ups into emergent builds
- seeing how “number up” turns into system interaction

**Use when asking:**
- how much raw stat growth is acceptable before it becomes interesting through interaction?
- how do simple items become build-defining when layered?

#### Noita
**Best for:**
- rule-rewriting combinations
- assembly logic
- synergy-first design
- understanding how one component changes the meaning of the rest

**Use when asking:**
- how do we make upgrades rewrite behavior instead of only raising output?
- how weird can build logic get before it stops reading clearly?

#### Gunfire Reborn
**Best for:**
- layered hero + weapon + scroll interactions
- curated but still expressive build-routing
- mixing character identity with item identity

**Use when asking:**
- how should character route and weapon route overlap?
- how much authored structure should sit under the build system?

#### Vampire Survivors
**Best for:**
- weapon/passive pairing
- evolutions
- unions
- readable recipe logic

**Use when asking:**
- which upgrade relationships should be explicit recipes?
- how do we keep upgrade choices simple but still chase-worthy?

#### Dead Cells
**Best for:**
- mutations
- affix logic
- a middle ground between direct scaling and build identity

**Use when asking:**
- how much build-shaping can happen without needing giant item pools?
- what is the cleanest bridge between weapon identity and support modifiers?

#### The Binding of Isaac: Rebirth
**Best for:**
- item-behavior rewrite thinking
- transformation logic
- high-variance combo identity

**Use when asking:**
- what happens when an item changes the whole read of your attack?
- how far can combinatorial weirdness go before it hurts clarity?

#### Hades
**Best for:**
- authored synergy
- curated upgrade lanes
- gods/boon style selective build routing

**Use when asking:**
- how much should the game steer the player toward coherent packages?
- how do you make synergy feel intentional instead of accidental?

#### Enter the Gungeon
**Best for:**
- weapon identity
- explicit synergy callouts
- item/weapon readability

**Use when asking:**
- how do you make items and weapons feel distinct even before they combo?
- how do you keep weirdness readable in the middle of action?

---

## 2. Weapon / personality references
These are the strongest references when the question is:
> how do we keep the game weird, toy-like, memorable, and visibly authored instead of flattening into abstract upgrade math?

### Primary weapon/personality references

#### Above Land: Rhapsody
**Best for:**
- bizarre weapon language
- authored 3D combat tone
- weird-object arsenal thinking
- keeping combat identity expressive before the systems are fully documented

**Why it sits here:**
Right now it is a stronger reference for **combat language and weapon absurdity** than for catalog-backed upgrade structure.

#### Enter the Gungeon
**Best for:**
- gun personality
- joke-concept weapons that still play cleanly
- readable absurdity

#### Mega Bonk
**Best for:**
- roster tone
- character/weapon naming energy
- arcade shell readability

**Why it sits here:**
Public source depth was lighter, so it currently works better as a tone/role reference than as a systems reference.

#### Stack Gun Heroes
**Best for:**
- mod-shopping / stacking prompt language
- order-sensitive customization vibe

**Why it sits here:**
It still feels more useful as a naming/prompt/reference source than as a fully trusted systems blueprint.

#### The Binding of Isaac: Rebirth
**Best for:**
- attack-read mutation
- instantly recognizable item personality
- strange but memorable build identity

#### Above all shared takeaway
When the question is **“what makes the weapon feel like a toybox object instead of a generic damage source?”**, these references matter more than raw balance spreadsheets.

---

## 3. Combat-feel / spatial references
These are the strongest references when the question is:
> how should 3D combat pressure, spacing, clarity, weapon flow, and movement interaction actually feel?

### Primary combat-feel references

#### Returnal
**Best for:**
- high-pressure 3D projectile readability
- fast movement + threat density
- weapon traits in motion

#### Risk of Rain 2
**Best for:**
- readable chaos in open 3D combat spaces
- enemy pressure scaling
- item-driven combat escalation without losing broad legibility

#### Gunfire Reborn
**Best for:**
- shooter movement/combat pacing
- hero/weapon flow under pressure
- readable layered combat states

#### Roboquest
**Best for:**
- fast 3D gun-build pacing
- class/gun immediacy
- readable shooter aggression

#### Above Land: Rhapsody
**Best for:**
- unusual combat verbs in 3D
- chaos with visible identity
- mixing absurd tools with readable confrontation

#### Hades
**Best for:**
- tempo and authored encounter feel
- clear action flow even when upgrades add complexity

### Why this bucket matters for your project
Your game is not only building an upgrade spreadsheet.
It is trying to build:
- lock-on clarity
- melee/ranged alternation
- boomerang path readability
- weird but readable weapon behavior in 3D

So these references should often outrank deeper 2D item-combo references when the question is about **feel in space**.

---

## 4. Exploit-risk references
These are the strongest references when the question is:
> where are we most likely to accidentally break economy, upgrades, pacing, or state flow?

### Primary exploit-risk references

#### Risk of Rain 2
**Best for watching:**
- proc escalation
- runaway stacking
- “simple” items becoming multiplicative webs

#### Noita
**Best for watching:**
- rule-rewrite interactions
- unexpected self-feeding combinations
- emergent system abuse from seemingly fair pieces

#### Vampire Survivors
**Best for watching:**
- evolution pacing
- passive/weapon pair optimization
- route collapse if one recipe path dominates too hard

#### The Binding of Isaac: Rebirth
**Best for watching:**
- transformation overlap
- combo explosion
- attack behavior rewrites that invalidate intended challenge

#### Gunfire Reborn
**Best for watching:**
- hero-skill + scroll + weapon multiplication
- build routes that erase intended combat pressure

#### Returnal
**Best for watching:**
- 3D pressure readability constraints
- safety routes that preserve output while removing danger

#### SpiffingBrit exploit-awareness pass
This is not one game, but it now functions as a meta-reference bucket for:
- reward duplication
- bad exchange rates
- safe farming loops
- state-transition abuse
- self-refreshing setup/payoff loops

### Why this bucket matters now
This is the bucket to consult before implementing:
- mark + recall detonations
- projectile split/ricochet escalation
- money scaling
- replay/restart reward flows
- thrown-state safety routes

---

## Fast lookup: which bucket should answer which question?

### If the question is...
**“How should upgrades combine?”**
- Risk of Rain 2
- Noita
- Gunfire Reborn
- Dead Cells
- Hades

**“How do we keep weapons weird and memorable?”**
- Above Land: Rhapsody
- Enter the Gungeon
- Mega Bonk
- Stack Gun Heroes
- Isaac

**“How should 3D combat read and feel?”**
- Returnal
- Risk of Rain 2
- Gunfire Reborn
- Roboquest
- Above Land: Rhapsody

**“What are we most likely to break?”**
- exploit-awareness notes
- Risk of Rain 2
- Noita
- Gunfire Reborn
- Isaac

---

## Current recommendation for Mecha Paper Ratchet
If we want the pool to stay useful instead of muddy, use it like this:

### For first-pass upgrade structure
Lead with:
- Risk of Rain 2
- Gunfire Reborn
- Hades
- Dead Cells

### For weird weapon identity
Lead with:
- Above Land: Rhapsody
- Enter the Gungeon
- Isaac
- Mega Bonk as a lighter tone/reference source

### For 3D combat readability
Lead with:
- Returnal
- Risk of Rain 2
- Gunfire Reborn
- Roboquest
- Above Land: Rhapsody

### For anti-exploit caution
Lead with:
- the exploit-awareness notes already in this vault
- Risk of Rain 2
- Noita
- Gunfire Reborn

## Bottom line
The inspiration pool becomes much easier to use once each title has a job.

Right now, **Above Land: Rhapsody** is most valuable as:
- a **weapon/personality reference**
- a **combat-language reference**
- a **3D weirdness/readability reference**

It is **not yet** one of the strongest upgrade-systems authorities in the pool, and that is fine.