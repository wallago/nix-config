# nix-config

NixOS flake using flake-parts and the dendritic module pattern.

## Conventions

- Modules live in `modules/`, with `features/` for cross-host concerns and
  `hosts/<name>/` for host-specific config.
- The username is parameterized via `config.preferences.user.name`.
- Disko handles disk layout, with btrfs subvolumes and impermanence.
- Sops-encrypted secrets live in `modules/secrets/` and `modules/hosts/*/secrets.nix`.
  Do not attempt to read or edit these directly.

## Workflow

- `just check` runs `nix flake check`.
- `just vm` builds and boots the VM variant.
- `just rebuild` switches the live system.
