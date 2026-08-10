---
name: nix-module
description: Conventions for writing NixOS/home-manager modules in this repo. Use when adding or editing a module under modules/, wiring options, or touching flake outputs.
---

# Nix modules

- One feature per directory under `modules/features/<domain>/<name>`.
- Expose as `flake.homeModules.<name>` / `flake.nixosModules.<name>`.
- Options go under `features.<name>.*`, always with `enable = lib.mkEnableOption`.
- Format with nixfmt before proposing a diff.
- Verify with `nix flake check` (never `nixos-rebuild switch`).
