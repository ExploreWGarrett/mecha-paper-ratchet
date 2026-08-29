# Baseline Feel Validation Session Brief

This is the immediate next-session brief after the readiness gate returned **no-go**.

## Session purpose
Do **not** build new upgrade features yet.

Use this session to answer one question:
> Is the current combat baseline good enough to deepen, or does it still need another round of tuning first?

---

## What this session is for
Focus only on:
- lock-on + melee spacing
- boomerang throw/return feel
- thrown-state fallback balance
- Popper baseline identity
- pause/state reliability
- whether current enemy pressure is good enough to judge the player kit

---

## What this session is not for
Do **not** use this session to start:
- wrench upgrade family implementation
- Popper cadence feature implementation
- Gun Kata fusion implementation
- projectile multiplication experiments
- recall detonation experiments
- money-scaling additions

If that starts happening, the session has drifted off purpose.

---

## Desired outcome
By the end of the session, we should be able to say one of two things clearly:

### Outcome A — GO SOON
- the baseline loop is fun enough to deepen
- the Popper is close enough to its intended role
- boomerang and thrown-state timing are stable enough to build around
- the readiness gate should be re-run soon

### Outcome B — TUNE FIRST
- the loop still has unresolved feel problems
- the Popper still needs baseline shaping
- boomerang/thrown-state behavior is not stable enough yet
- another tuning pass should happen before implementation

---

## Must-answer questions
- does melee spacing already feel satisfying?
- does lock-on support pressure cleanly?
- does the boomerang return feel intentional?
- is thrown-state fallback still a weaker tradeoff instead of a dominant comfort state?
- does the Popper feel additive instead of replacing melee?
- does pause/state flow feel dependable enough for deeper systems later?

---

## Required outputs after the session
- updated `04 Prototype/Combat Prototype.md`
- updated `06 Tasks/Next Actions.md`
- a completed `04 Prototype/Baseline Feel Validation Findings Template.md`
- a re-run of `13 Pre-Implementation Readiness Gate` once the findings are written

---

## One-sentence reminder
The point of this session is to protect the next implementation wave from being built on top of unresolved baseline feel problems.