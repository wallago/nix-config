# ❄️ NixOs with Flake

## 📐 Project Architecture Idea

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

## 📥 Inputs

This section explains the inputs used in our NixOS flake configuration.

### 📦 Core Nix Ecosystem

- **nixpkgs**: The primary package collection, using the unstable channel for the latest packages.
- **systems**: Standard system architectures for cross-compilation.

### 🧩 System Components

- **nix-colors**: Color scheme management.

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

## 🔧 Overlay

- `rust`
- `minicava`

## 🔐 Secrets

For deployment secrets. I'm using the awesome [`sops-nix`](https://github.com/Mic92/sops-nix).\
All secrets are encrypted with my personal PGP key (stored on a [`YubiKey`](https://www.yubico.com/), as well as the relevant systems's SSH host keys.

> [!NOTE]
> Don't forget to init the Yubikey

By default secrets are owned by `root:root`.\
By default secrets are stored into `/run/secrets.d` and `/run/secrets-for-users.d`.

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

## 🌀 for new host -- maybe to rm (more to understand)

### Generate a key for yourself

You can generate these host keys with:
```sh
age-keygen
```
Otherwise, you can convert an existing SSH key into an age public key:
```sh
nix-shell -p ssh-to-age --run "ssh-to-age < ~/.ssh/id_ed25519.pub"
```

### How to find the GPG fingerprint of a key 
Invoke this command and look for your key:
```sh
$ gpg --list-secret-keys
/tmp/tmp.JA07D1aVRD/pubring.kbx
-------------------------------
sec   rsa2048 1970-01-01 [SCE]
      9F89C5F69A10281A835014B09C3DC61F752087EF
uid           [ unknown] root <root@localhost>
```

### Create a sops file

After configuring `.sops.yaml`, you can open a new file with sops.\
An example secret file `secrets.yaml` might be:
```yaml
# Files must always have a string value
example-key: example-value
# Nesting the key results in the creation of directories.
# These directories will be owned by root:keys and have permissions 0751.
myservice:
  my_subdir:
    my_secret: password1
```
And to encrypt it you should type:
```sh
nix develop
sops -e -i secrets.yaml
```
