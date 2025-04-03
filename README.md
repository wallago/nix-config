# Flake

## Inputs

This section explains the inputs used in our NixOS flake configuration.

### Core Nix Ecosystem

- **nixpkgs**: The primary package collection, using the unstable channel for the latest packages.
- **systems**: Standard system architectures for cross-compilation.

### System Components

- **hardware**: Hardware-specific configurations.
  <!--- **impermanence**: Ephemeral storage management.-->
  <!--- **nix-colors**: Color scheme management.-->

### User Environment Management

- **home-manager**: User-level configurations.

### Security

<!--- **sops-nix**: Secrets management with SOPS.-->

### Storage Management

- **disko**: Declarative disk partitioning.

### Third-Party Packages

<!--- **firefox-addons**: Firefox extensions repository.-->

## NixOS system configuration

- **shusui**
  - Hardware
    | Component | Details |
    | ---------------------- | ------------------------------------------------------------------------------------------------------------------------ |
    | **Power Supply (PSU)** | Corsair RMX Series, RM750x, 750W, 80+ Gold Certified |
    | **CPU** | Intel Core i7-10700K, 8 Cores @ 3.80GHz |
    | **GPU** | MSI Gaming GeForce RTX 2060 Super |
    | **Motherboard (MB)** | MSI MPG Z490 Gaming Carbon WiFi |
    | **RAM (Total: 32GB)** | - 2× Corsair Vengeance LPX 16GB (2×8GB) DDR4 2400MHz CL14 <br> - 2× Corsair Vengeance LPX 16GB (2×8GB) DDR4 3200MHz CL16 |
    | **Case** | Corsair 5000D |
    | **Cooling** | Corsair iCUE H100i RGB PRO XT Liquid CPU Cooler |
  - Users
    - **yc**

## Home Manager configuration

- **yc**

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
+ All around the hardware/system configurations should be in NixOs.
    ```cli
    nixos-rebuild switch --flake .#${host} 
    ```
+ All around the user experience should be in Home-Manager.
    ```cli
    home-manager switch --flake ${user}#${host} 
    ```

The behavior for someone who used NixOs, if it reload only Home-Manager with a user inside his config, don't should see a difference (cause NixOs only change Hardware stuff).
