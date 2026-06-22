---
1. Turn sections into real [group(...)] attributes (the structural fix)

Since 1.27, just has a [group('name')] attribute. just --list then prints actual grouped headers instead of a flat list — your # ── sections become navigable. This is the single biggest discoverability win and needs no extra tooling.

Add the attribute above each recipe. Example for a few:

# ── Build ─────────────────────────────────────────────────────
# Evaluate a host's config without building (fast feedback)
[group('build')]
eval HOST=host:
    nix eval --raw {{flake}}#nixosConfigurations.{{HOST}}.config.system.build.toplevel.drvPath

# Build a host's system closure (no activation)
[group('build')]
build HOST=host:
    nh os build {{flake}} --hostname {{HOST}}

Then just --list shows:

[build]
    build HOST=host    # Build a host's system closure (no activation)
    diff  HOST=host    # Show what would change without building
    eval  HOST=host    # Evaluate a host's config without building
[apply]
    boot   HOST=host   # ...
    switch HOST=host   # ...

You can keep your # ── divider comments too — they coexist fine. Group names map cleanly to what you already have: dev, build, apply, vm, inputs, secrets, gc, inspect, hygiene, misc.

---
2. just --choose — interactive fuzzy picker (the "I forgot" fix)

This is the direct cure for forgetting. just --choose pipes all recipes into fzf (which you have) and runs whatever you select. Type a fragment of a name or its doc comment and hit enter. Give it a short alias so it's muscle-memory:

# Fuzzy-pick a recipe interactively
[group('dev')]
pick:
    @{{just_executable()}} --choose

Now just pick (or bind j to just --choose in fish) gets you a searchable menu any time you blank. Pair it with --choose's preview if you want — it shows the recipe body before you commit.

---
3. Fish tab-completion for recipe names

You're on fish. just ships completions that tab-complete recipe names and their arguments (including host names). Drop this into your fish config so just <Tab> lists recipes:

# ~/.config/fish/completions/just.fish  (or sourced from config.fish)
just --completions fish | source

In your Nix setup that's better expressed declaratively — e.g. via programs.fish.interactiveShellInit or a generated completions file. Tell me to and I'll show the exact module diff for wherever your fish config lives.

---
Minor cleanups I noticed while reading

These aren't about forgetting, but they hurt the --list output you rely on:

- Missing doc comments (so they show blank in --list): option, secret-without-yk, install. Add a # line above each.
- update-dry has no blank line before it — its # Show what would update comment is glued to update-input, so just --list may misattribute the doc. Add a blank line above the comment.
- install is under a # to rm marker and shadows the built-in host variable name with a parameter also called host — works, but confusing. Worth a rename to host-install or moving it to a clear group.

---
My recommendation

Do 1 + 2 + 3 together — they're complementary: groups make the list readable, --choose makes it searchable, completions make it fast. Group attributes are the meat; the other two are a few lines each.

Want me to generate the full updated justfile with [group(...)] on every recipe and the pick recipe added, plus the fish-completions module diff for your config? I'll show it as a diff for you to apply — say the word and I'll write it out.

