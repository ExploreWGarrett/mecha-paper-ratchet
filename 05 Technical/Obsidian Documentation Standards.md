---
title: Obsidian Documentation Standards
project: Mecha Paper Ratchet
type: technical-standard
status: active
tags:
  - '#mecha-paper-ratchet'
  - '#documentation'
  - '#obsidian'
  - '#godot'
  - '#workflow'
---

# Obsidian Documentation Standards

## Purpose

Keep design, research, code, agent work, and playtest evidence navigable in one Obsidian vault. Notes are the source of truth for project decisions; code in `game/` is the implementation source of truth.

## Required note frontmatter

Every new project note should begin with YAML frontmatter containing:

```yaml
---
title: Note title
project: Mecha Paper Ratchet
type: design | research | lore | idea | task | technical | playtest
status: seed | draft | active | parked | superseded
tags:
  - '#mecha-paper-ratchet'
  - '#<area>'
---
```

Use lowercase kebab-case tags. Add one or more area tags such as `#combat`, `#progression`, `#lore`, `#steam`, `#godot`, `#agent-prompt`, `#playtest`, or `#idea`.

## Linking standards

- Link every new note from its nearest hub and from the project index when it is a major decision.
- Link design notes to the implementation surface with an inline path such as `game/mecha-paper-wrench/scripts/player_upgrade.gd`.
- Link implementation-adjacent notes to the relevant design note, task note, and verification note.
- Prefer stable note names and Obsidian double-bracket links; avoid links that only work through a local heading alias.
- Use a display-text alias when a long path makes a paragraph hard to read.

## Evidence labels

Use these labels inside research and planning notes:

- **Source-backed** — directly observed in an official document, existing project note, or verified build.
- **Project decision** — explicitly chosen for Mecha Paper Ratchet.
- **Working interpretation** — a design recommendation derived from the evidence.
- **Open question** — not resolved; do not implement as if settled.
- **User side note** — supplied by the user and kept separate from agent research.

## Code and documentation relationship

For each meaningful gameplay system, keep these links nearby:

1. design intent note
2. system/data note
3. implementation path(s) under `game/`
4. task or agent prompt
5. playtest/verification note

Do not copy whole scripts into design notes. Record public responsibilities, exported tuning values, signals, and scene/script paths instead.

## Status discipline

- `seed`: captured, not shaped.
- `draft`: shaped enough for review, not approved.
- `active`: current working direction.
- `parked`: intentionally deferred, still visible.
- `superseded`: retained for history, no longer authoritative.

## Current documentation hubs

- [[00 Project Index]]
- [[01 Vision/Project Vision]]
- [[01 Vision/Development Kickoff Questionnaire]]
- [[02 Design/Progression and Meta Loop Plan]]
- [[02 Design/Lore and World Plan]]
- [[02 Design/Research - Godot 4.7 and Steam Shipping]]
- [[02 Design/Ideas/Side Notes - Callous and Grit]]
- [[06 Tasks/Agent Job Prompts]]
- [[06 Tasks/Next Actions]]
