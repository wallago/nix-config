# Nix Config

Build a Nixos config.

## Conventions

- **Dendritic / flake-parts layout.** `flake.nix` calls
  `flake-parts.lib.mkFlake` with `import-tree ./modules`, so **every `.nix`
  file under `modules/` is auto-imported** as a flake-parts module. There are
  no manual `imports` lists — to add a module, drop a file in the tree.
- **Layout under `modules/`:**
  - `base/` — option _declarations_ (the `preferences.*` namespace) + core defaults.
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

## Rules

Standalone rules live in `.claude/rules/` and are imported here — only files
reachable from `CLAUDE.md` get loaded, so a new rule needs a line below.

@.claude/rules/propose-before-writing.md
@.claude/rules/no-repo-mutation.md
@.claude/rules/no-hanging-commands.md
@.claude/rules/prevent-looping-fail.md

@.claude/rules/nix.md

@.claude/rules/release.md

## Commands

`just` is the entry point, not the raw toolchain. `just --list` for the rest.

- `just check` — fast type-check, no binary
- `just test` — test suite
- `just fmt` — format sources in place
- `just lint` — lint with warnings denied
- `just ci` — the full local gate; run this before pushing

<!-- TODO — anything above that is wrong here, and any command that exists only
     in this repo: seeding, fixtures, a dev server, a hardware target. -->

## Constraints

- `typos` runs over the source. Add a real term to `typos.toml` rather than
  rewording around it.

- Commit messages must be Conventional Commits; `committed` checks them in CI.

- Links in Markdown are checked in CI. A placeholder URL fails the build.

Do not open, print, summarize, or pass to any tool the contents of:

- `.env`, `.env.*`, `*.env`
- `secrets/`, `secrets.nix`, `secrets.yaml`, anything `sops`-encrypted
- `*.key`, `*.pem`, `*.p12`, `id_rsa*`, `*.crt`, credential / token files
- `~/.cargo/credentials*`, `~/.aws/`, `~/.ssh/`, `~/.config/` credential files
- `.netrc`, `.npmrc` (auth lines), CI secret files

If a task seems to need a secret, tell me what's needed and let me handle it.
Never echo environment variables (`env`, `printenv`, `echo $VAR`) — assume
they may contain credentials.

## Verifying a change

`just ci-light` is the gate. Green means green.

<!-- TODO — what the gate *cannot* catch here, and how it gets checked instead.
     Be specific. "The binary is a full-screen TUI so it can't be driven
     headlessly — UI changes get verified by reading, by `cargo check`, and by
     asking me to run it" is the useful kind. Never claim a change works
     without saying how it was checked. -->
