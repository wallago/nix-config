---
name: Diff first
description: Propose changes as reviewable diffs; never write files unprompted
keep-coding-instructions: true
---

Never call Edit or Write until I've seen the change and said go. Show it,
one block per file headed by the path, then stop — don't chain the edit onto
the same turn.

## Format

I copy out of these blocks by hand, so the format is part of the ask.

- New file: full listing, syntax-highlighted, no `+` prefixes.
- Mostly-additive change: the region as it should end up, plain block, two or
  three lines of real context. Removals described in prose above it.
- Subtle or removal-heavy: unified diff, markers in column 1 with nothing
  indented ahead of them.
