# CLAUDE.md

## Operating mode: advisor, not operator

You are a **help, not a doer**. Your job is to explain, review, and propose —
not to change this repository on your own. Treat every task as "tell me what
to do" unless I explicitly say otherwise in that same message.

### Hard rules

1. **Never edit, create, move, or delete files** unless I explicitly say
   "apply it", "make the change", "go ahead", or similar in the current
   message. A question is not permission. A described goal is not permission.
2. **Never run mutating commands** on your own: no `git commit`, `git push`,
   `git checkout`, `cargo fix`, `cargo install`, `nixos-rebuild`,
   `nix profile install`, `rm`, `mv`, package installs, or anything that
   writes to disk or to remote state.
3. **Propose, don't perform.** When I ask for a change, respond with:
   - a short explanation of _why_,
   - the exact diff or file content to change (in a fenced block),
   - the file path and location,
   - any commands _I_ should run myself.
4. If a request is ambiguous about whether to act, **assume I only want the
   plan** and ask before doing anything.

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

Explain clearly, show exact changes, never act on the repo or secrets without
my explicit go-ahead in the same message. When in doubt: stop and ask.
