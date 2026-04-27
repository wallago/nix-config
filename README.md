# nix-config

Personal NixOS / home-manager configuration, structured as a [`flake-parts`](https://flake.parts) flake using the [dendritic pattern](https://github.com/mirkolenz/flocken) — every concern lives in its own module file, auto-imported via [`import-tree`](https://github.com/vic/import-tree).

This repo defines:

- The full configuration of every machine I run
- A WireGuard mesh that lets them talk to each other regardless of where I am
- Reverse-proxied services exposed publicly through my ISP router
- Reusable home-manager modules and packaging wrappers
- Secrets management via [sops-nix](https://github.com/Mic92/sops-nix)
- Disk layout via [disko](https://github.com/nix-community/disko) and Secure Boot via [lanzaboote](https://github.com/nix-community/lanzaboote)

## Network topology

```mermaid
---
title: Network Topology
---
flowchart LR
  INTERNET(("Internet"))

  subgraph ISP_LAN["ISP LAN - 192.168.1.0/24"]
    BOX("Box Ethernet (provider)<br/>192.168.1.1")
  end

  subgraph HOME_LAN["Home LAN - 192.168.10.0/24"]
    direction TB
    ROUTER("Teltonika RUTX11<br/>WAN: 192.168.1.143<br/>LAN: 192.168.10.1")
    SERVER["coral (server)<br/>192.168.10.150<br/>wg0: 10.100.0.1"]
    DESK["sponge (desktop)<br/>192.168.10.241<br/>wg0: 10.100.0.3"]
    SERVER --- ROUTER
    DESK --- ROUTER
  end

  LAP["squid (laptop, roaming)<br/>wg0: 10.100.0.2"]

  %% Physical / IP path
  INTERNET <--> BOX
  BOX <--> ROUTER

  %% Port-forward chain: public HTTP(S) -> RUTX -> coral
  INTERNET <-. "HTTP/HTTPS<br/>TCP 80, 443" .-> BOX
  BOX <-. "HTTP/HTTPS<br/>TCP 51080, 51443" .-> ROUTER
  ROUTER <-. "HTTP/HTTPS<br/>TCP 80, 443" .-> SERVER

  %% WireGuard hub-and-spoke, terminated on coral
  SERVER <-. "WireGuard<br/>UDP 51820" .-> DESK
  SERVER <-. "WireGuard<br/>UDP 51820" .-> LAP

  classDef peer fill:#EEEDFE,stroke:#534AB7,color:#26215C;
  classDef infra fill:#E1F5EE,stroke:#0F6E56,color:#04342C;
  classDef net fill:#F1EFE8,stroke:#5F5E5A,color:#2C2C2A;
  class SERVER,DESK,LAP peer;
  class ROUTER,BOX infra;
  class INTERNET net;
```

The setup is double-NATed behind the ISP-provided Box (`192.168.1.0/24`).\
The Teltonika RUTX11 acts as the actual home router, carving out `192.168.10.0/24` for my own gear.

Public HTTP/HTTPS reaches the home LAN through a port-forward chain: the Box accepts `:80`/`:443`, forwards to the RUTX11 on non-standard ports `:51080`/`:51443` (because the Box reserves the standard ports for itself), which the RUTX11 then forwards to coral on standard `:80`/`:443`.

WireGuard terminates on **coral**, not on the router. UDP `51820` is forwarded down the same chain.

## Services

```mermaid
---
title: Services
---
flowchart LR
  EXT(("External traffic<br/>via RUTX11"))
  WGNET(("WireGuard peers<br/>10.100.0.0/24"))

  subgraph CORAL["coral (192.168.10.150)"]
    direction TB
    NGINX["nginx<br/>reverse proxy<br/>:80, :443"]
    WG["WireGuard server<br/>:51820/udp"]

    subgraph APPS["Application services"]
      direction TB
      OBSIDIAN["Obsidian LiveSync<br/>(CouchDB)<br/>:5984"]
      GRAFANA["Grafana<br/>:3000"]
      VAULTWARDEN["Vaultwarden<br/>:8000"]
    end
  end

  EXT -. "TCP 80, 443" .-> NGINX
  WGNET -. "UDP 51820" .-> WG

  NGINX -. "obsidian.example.com" .-> OBSIDIAN
  NGINX -. "grafana.example.com" .-> GRAFANA
  NGINX -. "vault.example.com" .-> VAULTWARDEN

  classDef edge fill:#FAEEDA,stroke:#854F0B,color:#412402;
  classDef app fill:#EEEDFE,stroke:#534AB7,color:#26215C;
  classDef ext fill:#F1EFE8,stroke:#5F5E5A,color:#2C2C2A;
  class NGINX,WG edge;
  class OBSIDIAN,GRAFANA,VAULTWARDEN app;
  class EXT,WGNET ext;
```

## Hosts

| Host       | Role                          | Address (LAN)    | WireGuard    |
| ---------- | ----------------------------- | ---------------- | ------------ |
| **coral**  | Server, reverse proxy, WG hub | `192.168.10.150` | `10.100.0.1` |
| **sponge** | Desktop (niri, daily driver)  | `192.168.10.241` | `10.100.0.3` |
| **squid**  | Laptop (roaming)              | —                | `10.100.0.2` |

Each host has a corresponding `nixosConfigurations.<name>` exposed by the flake, built from a host-specific module plus shared modules.

## Repository layout

The flake is dendritic — `flake.nix` does almost nothing, and every output is defined inside `modules/` as a small flake-parts module.\
`import-tree` walks the directory and feeds every `.nix` file into `mkFlake`.

```
.
├── flake.nix              # mkFlake + import-tree, nothing else
├── flake.lock
├── modules/
│   ├── core/              # systems list, flake-parts imports (home-manager, etc.)
│   ├── hosts/             # one file per host: coral.nix, sponge.nix, squid.nix
│   ├── hardware/          # disko + hardware-configuration per host
│   ├── nixos/             # reusable NixOS modules (users, locale, ssh, ...)
│   ├── home/              # reusable home-manager modules
│   ├── services/          # service modules (nginx, wireguard, vaultwarden, ...)
│   ├── features/          # opt-in feature bundles (desktop, dev, gaming, ...)
│   ├── packages/          # custom packages and wrappers (e.g. niri)
│   └── secrets/           # sops-nix wiring (encrypted blobs live in secrets/)
└── README.md
```

## Common tasks

### Build and switch a machine

On the target host:

```bash
sudo nixos-rebuild switch --flake .#<hostname>
```

### Test a host config in a VM (no risk to the real machine)

```bash
nixos-rebuild build-vm --flake .#<hostname>
./result/bin/run-<hostname>-vm
```

### Update inputs

```bash
nix flake update
```

Or update a single input:

```bash
nix flake lock --update-input nixpkgs
```

### Edit a secret

```bash
sops modules/secrets/<file>.yaml
```

### Add a new host

1. Create `modules/hosts/<name>.nix` with `flake.nixosConfigurations.<name>`.
2. Create `modules/hardware/<name>.nix` with the hardware module.
3. If it joins the WireGuard mesh, add a peer entry under `modules/services/wireguard/`.
4. `nix flake check` to validate.

## Conventions

- **One concern per file.** A file should answer "if I want to change X, do I open this file?" with a clear yes or no.
- **Reusable modules go under `flake.nixosModules` / `flake.homeModules`**, not directly into a host. Hosts compose modules; they don't define logic.
- **Hardware lives in its own module** so VMs and test rigs can `disabledModules = [ self.nixosModules.<host>Hardware ]` to drop it.
- **No secrets in plaintext, ever.** sops-nix is the only path. The repo is public-safe.

## License

Personal config — feel free to copy patterns; no warranty implied.
