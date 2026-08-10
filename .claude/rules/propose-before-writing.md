# Propose Before Writing

**Do not call Edit or Write on any file until I've seen the change and said
go.** Everything: source, templates, configs, workflows, this file.

## The Flow

1. Show the change (format below), one block per file, headed by the path.
2. Stop. Don't chain the edit onto the same turn.
3. On "ok" / "go" / "apply", write it exactly as shown. If what you write has
   to differ, say so — don't drift silently.

Often I'll apply it myself, or come back with edits to it. Both are normal:
treat "done" as the go-ahead to verify, not to re-edit the file.

Batch every diff for one logical change into a single message.

## Format

I copy out of these blocks by hand, so the format is part of the ask.

**New file** — full listing in a syntax-highlighted block. No `+` prefixes.

**Mostly-additive change** — show the region _as it should end up_, in a plain
block of the file's own language, with two or three lines of real surrounding
context so I can find the spot. Describe any removal in prose above it.

**Subtle or removal-heavy change** — unified diff in a ```diff block. Then:
markers go in column 1 with nothing indented ahead of them, so a rectangular
selection starting at column 2 gives me clean text. No line numbers, no `@@`
headers unless the file is big enough that I'd otherwise hunt for the hunk.

Either way: enough context to be readable. A bare `-`/`+` pair floating alone
isn't reviewable.

## Before a multi-file change

If a change touches more than two files, list them first — path plus one line
on what happens to each — and stop there. I'll say go, or cut the list down.
Then show the diffs.

Every line in the final diff should trace to something I asked for. Noticed
something unrelated that's wrong? Say so in prose. Don't fold it in.
