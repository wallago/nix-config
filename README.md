# ❄️ NixOs with Flake

## 📐 Project Architecture Idea

```
├── flake.nix
│
├── nixos -> system configuration
│   ├── common -> default params for all hosts
│   ├── feat -> optional features
│   └── users
│       └── ${user} -> specific params for ${user}
│
├── home -> user configuration
│   ├── common -> default params for all users
│   ├── feat -> optional features
│   └── users
│       └── ${user} -> specific params for ${user}
│           ├── common -> default params for ${user}
│           └── ${host} -> specific params for ${user} for ${host}
│
├── hosts
│   └── ${host} -> specific params for ${host}
│
├── overlays -> modify or extend the Nix package set
├── modules -> options for defines some params
│   ├── home -> specifc for home
│   └── nixos -> specifc for system
│
├── pkgs -> custom packages
└── hydra.nix -> filter valid packages
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

### ⚙️ Configuration in details

#### Nixos

[Configuration ➖ nixos/common](doc/nixos/common.md)\
[Configuration ➖ nixos/feat/gpu](doc/nixos/feat/gpu.md)\
[Configuration ➖ nixos/feat/desktop](doc/nixos/feat/desktop.md)

#### Home Manager

[Configuration ➖ home/common/](doc/home/common.md)

<!-- [Configuration ➖ home/feat/cli](doc/home/feat/cli.md)\ -->
<!-- [Configuration ➖ home/feat/nvim](doc/home/feat/nvim.md) -->
<!-- [Configuration ➖ home/feat/cli](doc/home/feat/desktop.md)\ -->

#### Misc

[Configuration ➖ overlays/](doc/overlays.md)\
[Configuration ➖ pkgs/](doc/pkgs.md)\
[Configuration ➖ modules/home/](doc/modules.md)

### 👥 Hosts & Users in details

[Hosts ➖ hosts/](doc/hosts.md)\
[Users ➖ home/users/ x nixos/users/](doc/users.md)

## 📥 Inputs

This section explains the inputs used in our NixOS flake configuration.

### 📦 Core Nix Ecosystem

- **nixpkgs**: The primary package collection, using the unstable channel for the latest packages.
- **systems**: Standard system architectures for cross-compilation.

### 🧩 System Components

- **nix-colors**: Color scheme management.
- **impermanence**: Impermanence.

### 👤 User Environment Management

- **home-manager**: User-level configurations.

### 💾 Storage Management

- **disko**: Declarative disk partitioning.

### 🔐 Security

- **sops-nix**: Secrets management with SOPS.

### 🔌 Third-Party Packages

- **firefox-addons**: Firefox extensions repository.
- **rust-overlay**: Rust overlay for better Management.

### 🎨 Own Packages

- **themes**: Themes (Wallpaper / Color scheme)

## 🔐 Secrets

For deployment secrets. I'm using the awesome [`sops-nix`](https://github.com/Mic92/sops-nix).\
All secrets are encrypted with my personal PGP key (stored on a [`YubiKey`](https://www.yubico.com/), as well as the relevant systems's SSH host keys.

> [!NOTE]
> Don't forget to init the Yubikey

By default secrets are owned by `root:root`.\
By default secrets are stored into `/run/secrets.d` and `/run/secrets-for-users.d`.

> [!TIP]
> Find the keygrip: Use `gpg --with-keygrip --list-secret-keys <key-id>`

> [!TIP]
> To generate a GPG public key: Use `gpg --armor --export commandant.cousteau1997@gmail.com > home/pgp.asc`

### 📄 Add secrets file

To create the file with the sops config, type:

```shell
nix develop
sops path/to/secrets.yaml
```

It can be checked by typing:

```shell
cat path/to/secrets.yaml
```

## 💾 Impermanence

Choose what files and directories you want to keep between reboots - the rest are thrown away.\
The persistent storage can be found at `${config.persistPath}`.

`directories`: All directories you want to bind mount to persistent storage.

- `/var/lib/systemd`
- `/var/lib/nixos`
- `/var/log`
- `/srv`
- `/home/${user}/Documents`
- `/home/${user}/Downloads`
- `/home/${user}/Pictures`
- `/home/${user}/Videos`
- `/home/${user}/.local/bin`
- `/home/${user}/.local/share/nix`: trusted settings and repl history

`files`: All files you want to link or bind to persistent storage.

- `/etc/machine-id`
- `/etc/ssh/ssh_host_ed25519_key`
- `/etc/ssh/ssh_host_ed25519_key.pub`

> [!NOTE]
> The users option defines a set of submodules which correspond to the users’ names.
> The directories and files options of each submodule work like their root counterparts, but the paths are automatically prefixed with with the user’s home directory.
