# Flake

## Project Architecture Idea

```
├── flake.nix
├── nixos
│   ├── common // default value for all hosts
│   └── users
│       └── ${user}
├── home
│   ├── common // default value for all users
│   └── ${user}
│       └── ${host}
├── hosts
│   └── ${host
└── overlays // modify or extend the Nix package set
```

The idea:\
Make a difference between NixOs and Home-Manage !

- All around the hardware/system configurations should be in NixOs.
  ```cli
  nixos-rebuild switch --flake .#${host}
  ```
- All around the user experience should be in Home-Manager.
  ```cli
  home-manager switch --flake ${user}#${host}
  ```

The behavior for someone who used NixOs, if it reload only Home-Manager with a user inside his config, don't should see a difference (cause NixOs only change Hardware stuff).

## Inputs

This section explains the inputs used in our NixOS flake configuration.

### Implemented

#### Core Nix Ecosystem

- **nixpkgs**: The primary package collection, using the unstable channel for the latest packages.
- **systems**: Standard system architectures for cross-compilation.

### User Environment Management

- **home-manager**: User-level configurations.

### Storage Management

- **disko**: Declarative disk partitioning.

#### Third-Party Packages

- **rust-overlay**: Rust overlay for better Management.

### Not Implemented

#### Security

- **sops-nix**: Secrets management with SOPS.

#### System Components

- **hardware**: Hardware-specific configurations.
- **impermanence**: Ephemeral storage management.
- **nix-colors**: Color scheme management.

#### Third-Party Packages

- **firefox-addons**: Firefox extensions repository.

#### Own Packages

- **themes**: Themes

## Overlay

- Rust
