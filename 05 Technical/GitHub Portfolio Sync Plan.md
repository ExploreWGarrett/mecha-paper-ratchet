---
title: GitHub Portfolio Sync Plan
project: Mecha Paper Ratchet
type: technical
status: active
tags:
  - '#mecha-paper-ratchet'
  - '#github'
  - '#portfolio'
  - '#privacy'
---

# GitHub Portfolio Sync Plan

## Goal

Publish and maintain a GitHub repository containing the non-identifying Mecha Paper Ratchet prototype code, design notes, and technical notes as portfolio evidence.

## Current local status

- The project root is now a git repository on branch `main`.
- The Godot project subfolder is intentionally part of the root repository, not its own separate git repository.
- Git is installed.
- GitHub CLI (`gh`) is installed and authenticated for the first private sync.
- A root `.gitignore` now excludes generated/editor state, build/export output, logs, local workspace state, and common credential file patterns.
- A public-facing root `README.md` now summarizes the prototype, structure, verification status, and privacy boundary.
- A final clean Godot headless boot after publish-prep cleanup exited `0` with no startup warnings.
- The first portfolio-safe sync has been pushed to a private GitHub repository with `origin` tracking `main`.

## Proposed publish root

Use the current project root as the GitHub repository root:

```text
Mecha Paper Ratchet (GAME)/
```

This preserves the Obsidian documentation structure beside the Godot project code.

## Include by default

- `README.md`
- `.gitignore`
- `AGENTS.md`
- `00 Project Index.md`
- `01 Vision/`
- `02 Design/`
- `03 Systems/`
- `04 Prototype/`
- `05 Technical/`
- `06 Tasks/`
- `assets/README.md`
- `game/README.md`
- `game/mecha-paper-wrench/project.godot`
- `game/mecha-paper-wrench/scenes/`
- `game/mecha-paper-wrench/scripts/`
- `game/mecha-paper-wrench/assets/`
- `game/mecha-paper-wrench/data/`

## Exclude by default

- `.git/`
- `.obsidian/`
- `**/.godot/`
- `**/.import/`
- `**/android/`
- `**/export_presets.cfg`
- `**/exports/`
- `**/builds/`
- `**/*.tmp`
- `**/*.log`
- `.env` and `.env.*`
- credential/token/key-looking files
- OS/editor workspace files such as `.DS_Store`, `Thumbs.db`, `.vscode/`, `.idea/`

## Privacy audit result

Latest local scan after redaction found:

- sensitive filename hits: 0
- credential/secret pattern hits: 0
- personal email/path/name risk hits: 0
- current publish-candidate file count: 125

The scan reports file paths and risk categories only; it does not print secret values.

## Approval gate before external upload

Before any remote repository is created or anything is pushed:

1. Confirm the GitHub account/org and repository name.
2. Confirm visibility: public portfolio repo or private staging repo first.
3. Confirm whether `06 Tasks/Agent Job Prompts.md` should be public, since it is non-identifying but exposes internal AI-workflow prompts.
4. Authenticate `gh` or configure git credentials without exposing tokens in chat/logs.
5. Initialize git locally, stage the audited publish set, commit, create/set the remote, push, and read back the GitHub repo page/API state to verify.

## Recommended first publication path

1. Private GitHub repository created and pushed.
2. Review GitHub's rendered file list and README.
3. If acceptable, switch repository visibility to public for portfolio use.

## Sync procedure after first publication

For future syncs:

1. Run the privacy scan.
2. Review `git status` and `git diff`.
3. Commit only intentional changes.
4. Push to GitHub.
5. Verify the pushed commit on GitHub.
