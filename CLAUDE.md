# CLAUDE.md

## Operating mode: explain first, then act

You may edit files to carry out a task, but you must **always explain _why_
first** and **always leave me the option to do the work myself** if I prefer.
Never touch remote state or run mutating commands on your own.

### Hard rules

1. **You may edit, create, move, or delete files** to carry out a task I've
   asked for, but only after a short explanation of _why_, and always offer to
   let me apply it myself instead. If I say something like "I'll do it", "let
   me do it", "just show me", or "propose only", then **don't edit** — hand me
   the diff and stop. A question is not a request to act: if I'm only asking,
   explain and propose, don't edit.
2. **Never run mutating commands** on your own: no `git commit`, `git push`,
   `git checkout`, `cargo fix`, `cargo install`, `nixos-rebuild`,
   `nix profile install`, `rm`, `mv`, package installs, or anything that
   writes to disk or to remote state. (Editing files with your tools is
   allowed per rule 1; running shell commands that mutate is not.)
3. **Always explain before you act.** Whether you edit or just propose, give:
   - a short explanation of _why_,
   - what you changed (or the exact diff / file content, in a fenced block),
   - the file path and location,
   - any commands _I_ should run myself.
4. If a request is ambiguous about whether to act, **assume I only want the
   plan** and ask before editing anything.

### Read-only by default

Read-only commands are fine without asking: `nix flake check`,
`nixos-rebuild dry-build`, `nix eval`, `just check-dry`, `just eval <host>`,
`just diff <host>` (dry-activate), `just hosts`, `just info`, `git status`,
`git diff`, `git log`, `ls`, `cat` (non-secret files).

If you think a mutating action is genuinely necessary, **describe it and stop** —
let me decide.

## Secrets and sensitive files: do not read

Do not open, print, summarize, or pass to any tool the contents of:

- `.env`, `.env.*`, `*.env`
- `secrets/`, `secrets.nix`, `secrets.yaml`, anything `sops`-encrypted
- `*.key`, `*.pem`, `*.p12`, `id_rsa*`, `*.crt`, credential / token files
- `~/.cargo/credentials*`, `~/.aws/`, `~/.ssh/`, `~/.config/` credential files
- `.netrc`, `.npmrc` (auth lines), CI secret files

If a task seems to need a secret, tell me what's needed and let me handle it.
Never echo environment variables (`env`, `printenv`, `echo $VAR`) — assume
they may contain credentials.

## Code review style

- Point at the smallest correct change; don't rewrite whole files when a few
  lines suffice.
- Flag risky changes (unsafe blocks, system-level Nix changes, anything
  touching auth or networking) explicitly.
- Prefer showing a unified diff so I can apply it myself.
- If you're unsure, say so rather than guessing.

## Project context

Build a Nixos config.

### Nix config project

- Validate with `nix flake check` / `nixos-rebuild dry-build` — never
  `switch` or `boot`.
- Don't restructure flake inputs, modules, or the host layout unprovoked.
- Treat hardware config, bootloader, and disk/filesystem modules as
  high-risk: propose, never apply.
- Keep changes declarative and minimal; show the diff for the relevant
  module.

## Conventions

- **Dendritic / flake-parts layout.** `flake.nix` calls
  `flake-parts.lib.mkFlake` with `import-tree ./modules`, so **every `.nix`
  file under `modules/` is auto-imported** as a flake-parts module. There are
  no manual `imports` lists — to add a module, drop a file in the tree.
- **Layout under `modules/`:**
  - `base/` — option *declarations* (the `preferences.*` namespace) + core defaults.
  - `features/` — cross-host features (desktop, shell, networking, ai, …), toggled via `preferences.*`.
  - `hosts/<name>/` — per-host `configuration.nix`, `hardware.nix`, `disko.nix`, `secrets.nix`. Hosts: `coral`, `sponge`, `squid`.
  - `users/`, `secrets/`, and `parts.nix` (systems + formatter).
- **Options namespace.** Config is driven by a custom `preferences.*` option set
  declared in `modules/base/` (e.g. `config.preferences.user.name`); features and
  hosts set these rather than wiring NixOS options directly.
- Disko handles disk layout, with btrfs subvolumes and impermanence.
- Sops-encrypted secrets live in `modules/secrets/` and `modules/hosts/<name>/secrets.nix`.
- **`justfile` is the workflow entry point** (run `just` to list). Read-only:
  `just check-dry`, `just eval <host>`, `just diff <host>`, `just hosts`.
  Mutating (you run these): `just check`/`just fmt` (formats files),
  `just switch|boot|test <host>`, `just update`.

## Summary

Explain clearly and show exact changes. You may edit files to do the work, but
always explain _why_ first and always leave me the option to apply it myself.
Never run mutating commands or touch secrets on your own. When in doubt: stop
and ask.
