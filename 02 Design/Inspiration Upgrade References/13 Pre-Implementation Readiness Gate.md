# Pre-Implementation Readiness Gate

This note is the final **go / no-go gate** before implementation starts.

Its purpose is simple:
Do not start building the next feature wave just because the planning stack feels complete.
Start only when the current prototype and documentation are aligned enough that implementation will teach the right lessons.

---

## Go / no-go rule
Implementation should begin only if:
- the baseline is playable enough to judge new features honestly
- the next three feature targets are still the right ones
- the exploit-risk watchpoints are understood well enough to avoid obvious self-sabotage
- the docs reflect reality closely enough that implementation will not be based on stale assumptions

If any of those fail, do more tuning or doc cleanup first.

---

## Readiness categories

### 1. Baseline feel readiness
Go only if:
- [ ] lock-on feels dependable enough in live play
- [ ] melee spacing feels good enough to deepen
- [ ] boomerang throw/return timing is readable enough to support follow-up systems
- [ ] thrown-state fallback still feels weaker than full wrench play
- [ ] the Popper is close enough to a rhythm weapon that cadence upgrades will sharpen it rather than rescue it

No-go if:
- [ ] the base loop still feels too soft to judge upgrades
- [ ] ranged stance is already crowding out melee before upgrades even exist
- [ ] boomerang state transitions are too awkward to build around confidently

---

### 2. Scope readiness
Go only if:
- [ ] the next three features are still limited to wrench commitment, Popper cadence, and alternation fusion
- [ ] recall-detonation webs are still delayed
- [ ] heavy projectile multiplication is still delayed
- [ ] money-scaling expansion is still delayed
- [ ] large mutation webs are still delayed

No-go if:
- [ ] implementation pressure is already trying to pull in flashy side systems
- [ ] the next build wave has silently expanded beyond what can be judged cleanly

---

### 3. Documentation readiness
Go only if these notes are in agreement:
- [ ] `04 Prototype/Combat Prototype.md`
- [ ] `03 Systems/Wrench Popper Upgrades and Fusion Planning.md`
- [ ] `03 Systems/Exploit Risk Grading for First Upgrade Families.md`
- [ ] `06 Tasks/Next Actions.md`
- [ ] `02 Design/Inspiration Upgrade References/11 Concrete Implementation Packet - Next 3 Features.md`
- [ ] `02 Design/Inspiration Upgrade References/12 Feature Pass Implementation Checklists.md`

No-go if:
- [ ] the prototype note and system note describe different priorities
- [ ] the risk grading note no longer matches the chosen first features
- [ ] the task list still points at an older design direction

---

### 4. Anti-exploit readiness
Go only if the team can state the current biggest dangers clearly:
- [ ] mark -> cash-out -> re-mark loops
- [ ] recall hit-count abuse
- [ ] cadence bonuses drifting into hidden permanent uptime
- [ ] alternation self-refresh loops
- [ ] reward/state-transition duplication issues
- [ ] crate farming and money pacing distortion

No-go if:
- [ ] no one can say what would most likely break first
- [ ] a risky route is being chosen mainly because it sounds exciting
- [ ] there is no plan to stop and regrade a route if implementation exposes new abuse

---

### 5. Verification readiness
Go only if the implementation plan includes practical verification questions, not just feature intent.

- [ ] each of the next three passes has explicit post-pass questions
- [ ] each pass has explicit stop conditions
- [ ] doc sync is required after each pass
- [ ] the team will judge behavior, readability, identity, and exploit pressure — not just whether the feature technically exists

No-go if:
- [ ] success is being defined only as “it compiles / runs”
- [ ] the next pass would proceed even if the previous pass became muddy or dominant

---

## Minimum green-light summary
Implementation is ready to begin when all of these are true:
- [ ] the baseline combat loop is fun enough to deepen
- [ ] the Popper is close enough to its intended identity
- [ ] the first three features are still disciplined and small
- [ ] the anti-exploit watchpoints are understood
- [ ] the planning docs agree with each other
- [ ] each feature pass has clear review questions and stop conditions

If all six are not true, the right move is still planning/tuning, not implementation.

---

## Recommended first go / no-go check order
When the project is about to switch from planning to build work, check readiness in this order:
1. `04 Prototype/Combat Prototype.md`
2. `06 Tasks/Next Actions.md`
3. `03 Systems/Wrench Popper Upgrades and Fusion Planning.md`
4. `03 Systems/Exploit Risk Grading for First Upgrade Families.md`
5. `02 Design/Inspiration Upgrade References/11 Concrete Implementation Packet - Next 3 Features.md`
6. `02 Design/Inspiration Upgrade References/12 Feature Pass Implementation Checklists.md`

That order starts from reality, then checks task direction, then checks the design and risk layer.

---

## Bottom line
The right time to implement is not when the planning stack is large.
It is when the planning stack is:
- aligned
- restrained
- readable
- honest about risk
- and still pointing at the same first three features.