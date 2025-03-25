# NixOS Flake

## Overview

This repository organizes my NixOS configurations, home-manager setups, overlays, and custom packages into a structured Flake.

## Structure

### Root Files

- **`flake.nix`** – Entrypoint for hosts and home configurations.\
  Also provides a devshell for bootstrapping (`nix develop` or `nix-shell`).
- **`lib/`** – Utility functions to keep the Flake clean and modular.

### NixOS Configurations (`hosts/`)

Machine-specific configurations, accessible via `nixos-rebuild --flake`:

- **`common/`** – Shared configurations:
  - **`global/`** – Applied to all machines.
  - **`optional/`** – Opt-in features for specific machines.
- **Machines:**
  - **`home/`** – Desktop PC _(R5 3600X, 32GB RAM, RX 5700XT | Hyprland)_

### Home-Manager (`home/`)

Each subdirectory represents a "feature" that can be toggled in individual home-manager configurations, allowing per-machine customization.

### Additional Components

- **`modules/`** – Custom NixOS modules.
- **`overlay/`** – Patches and version overrides for packages, accessible via `nix build`.
- **`hydra.nix`** - Hydra configuration to build and test packages and NixOS configurations automatically.
- **`shell.nix`** – Defines a reproducible development environment for bootstrapping and tool setup.
- **`pkgs/`** – Custom packages, available through this Flake's overlay or via NUR.
- **`doc/`** – Miscellaneous documentation related to Nix.

---

This layout ensures modularity, reusability, and ease of maintenance across multiple machines. 🚀

## How to bootstrap

- `nixos-rebuild --flake .` To build system configurations
- `home-manager --flake .` To build user configurations
- `nix build` (or `shell` or `run`) To build and use packages
- `sops` To manage secrets

## Secret

For deployment secrets, I'm using the awesome `[sops-nix](https://github.com/Mic92/sops-nix)`.\
All secrets are encrypted with my personal **PGP key** (stored on a [YubiKey](https://www.yubico.com/)), as well as the relevant systems's SSH host keys.

## Misc

- `alejandra` – A formatting tool, across different system architectures. This ensures consistent code formatting across all platforms.

---

---

---

## Tooling and applications I use

### 🖥️ Daily Drivers (User Apps)

#### Desktop & System Utilities

- **Hyprland** + `swayidle` + `swaylock`
- **Waybar** – Status bar for Wayland

#### Terminal & Shell

- **Alacritty** – GPU-accelerated terminal emulator
- **Fish** – Smart and user-friendly shell
- **Helix** – Modern text editor

#### Web & Communication

- **Qutebrowser** – Minimal keyboard-driven browser
- **Neomutt** + `mbsync` – Email client
- \*\*Khal`+`khard`+`todoman`+`vdirsyncer` – Contacts, calendar, and tasks

#### Security & Networking

- **GPG** + `pass` – Password and encryption management
- **Tailscale** – Mesh VPN

#### Containers & Virtualization

- **Podman** – Rootless container management

#### Productivity & Misc

- **Zathura** – Lightweight PDF reader
- **Wofi** – Application launcher for Wayland
- **bat** + `fd` + `rg` – Modern alternatives to `cat`, `find`, and `grep`
- **KDE Connect** – Device integration
- **Sublime Music** – Local music player

---

### 🏠 Self-Hosted Services

- **Hydra** – Nix-based CI/CD
- **Navidrome** – Music streaming server
- **Deluge** – Torrent client
- **Prometheus** – Monitoring & alerting
- **Websites** – Hosting personal sites (e.g., [m7.rs](https://m7.rs))
- **Minecraft** – Game server
- **Headscale** – Self-hosted Tailscale coordination server

---

### ❄️ Nix Ecosystem

- **nix-colors** – Theming for Nix-based setups
- **sops-nix** – Secrets management with SOPS
- **impermanence** – Stateless NixOS system management
- **home-manager** – User-level package & config management
- **deploy-rs** – NixOS remote deployment
- **NixOS & Nix** – The foundation of my system
