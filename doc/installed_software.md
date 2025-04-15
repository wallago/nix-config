# 💽 Installed Software

## 📦 System-wide Packages

### 🧩 Common 

#### 🔧 System Configuration

+ `system.stateVersion = config.system.nixos.release`\
▶️ version of NixOS
+ `nixpkgs`
    + `overlays = builtins.attrValues outputs.overlays`\
    ▶️ set overlays from outputs
    + `nixpkgs.config.allowUnfree = true`\
    ▶️ allow unfree packages
+ `nix`
    + `settings`
        + `trusted-users = ["root", "@wheel"]`\
        ▶️ trusted users for Nix
        + `auto-optimise-store = true`\
        ▶️ enable store optimization
        + `experimental-features = ["nix-command", "flakes", "ca-derivations"]`\
        ▶️ enable experimental features for Nix
        + `warn-dirty = false`\
        ▶️ disable dirty warnings
        + `system-features = ["kvm", "big-parallel", "nixos-test"]`\
        ▶️ enable system features
        + `flake-registry = ""`\
        ▶️ disable global flake registry
    + `gc`\
    ▶️ garbage Collection
        + `automatic = true`\
        ▶️ enable automatic garbage collection
        + `dates = "weekly"`\
        ▶️ set garbage collection date interval
        + `options = "--delete-older-than +10"`\
        ▶️ set garbage collection options to delete older than 10 days
    + `registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs`\
    ▶️ map each flake input as a registry
    + `nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs`\
    ▶️ set nixPath for each flake input
+ `flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs`\
▶️ filter inputs for flakes
+ `programs.nix-ld.enable = true`\
▶️ enable dynamic linking for Nix packages

#### ⚙️ Boot Configuration

+ `boot`
    + `kernelPackages = pkgs.linuxPackages_latest`\
    ▶️ override the Linux kernel used by NixOS
    + `consoleLogLevel = 4`\
    ▶️ kernel console `loglevel`
    + `loader.grub`
        + `enable = true`  
        ▶️ enable GNU GRUB boot loader
        + `efiSupport = true`\
        ▶️ GRUB should be built with EFI suppor
        + `efiInstallAsRemovable = true`\
        ▶️ invoke grub-install with `--removable`

#### 🐟 Fish Shell

+ `programs.fish` \
▶️ `fish` shell
    + `enable = true` \
    ▶️ configure fish as an interactive shell
    + `vendor`
        + `completions.enable = true`  
        ▶️ completion files provided by other packages
        + `config.enable = true`\
        ▶️ configuration snippets provided by other packages
        + `functions.enable = true`\
        ▶️ autoload fish functions provided by other packages

#### 🖋️ Fonts Configuration

+ `fonts.packages`\
▶️ font packages
    + `pkgs.noto-fonts-emoji`\
    ▶️ color emoji font

#### 👥 User and Group Management

+ `users.mutableUsers = false`\
▶️ contents of the user and group files will simply be replaced on system activation

#### 🏠 Home Manager

+ `home-manager`
    + `backupFileExtension = "backup"` \
    ▶️ set extension for backup files
    + `useGlobalPkgs = true`\
    ▶️ use the global package set defined in NixOS configuration

#### 🔐 Security Settings

+ `security.pam.loginLimits`\
▶️ file limit
    + `domain = @wheel`\
    ▶️ limit to users in the `wheel` group
    + `item = nofile`\
    ▶️ resource limit being set is the number of open files
    + `type = soft/hard`\
    ▶️ `soft` limit, which can be increased by the user up to the `hard` limit
    + `value = XXX`\
    ▶️ limit to XXX open files

#### 🌐 Network Management

+ `networking.networkmanager.enable`\
▶️ use NetworkManager to obtain an IP address and other configuration for all network interfaces

#### 🗂️ Persistence Configuration

+ `imports = [ inputs.impermanence.nixosModules.impermanence ]`\
▶️ import the impermanence module for persistence
+ `environment.persistence."/persistent"` \
▶️ define persistent directory
    + `files = [ "/etc/machine-id" ]`\
    ▶️ list of files to persist
    + `directories = [ "/var/lib/systemd", "/var/lib/nixos", "/var/log", "/srv" ]`\
    ▶️ list of directories to persist
+ `programs.fuse.userAllowOther = true`\
    ▶️ allow other users to access FUSE-mounted files
+ `system.activationScripts.persistent-dirs.text`\
▶️ script to ensure all home users directories exist and persist with correct permissions

### 🔌 Feat 

### 📐 Host Default

```
└──/hosts/${host}.nix
    ├── disko-configuration.nix  
    ├── hardware-configuration.nix  
    └── ssh_host_ed25519_key.pub -> root ssh pub key
```

## 👤 User-specific Software

### 🧩 Common 

### 🔌 Feat 

### 📐 User Default Arch

```
├──/nixos/users
│   └── ${user}.nix
│
└──/home/users/${user}
    ├── common.nix  
    └── ${host}
```

## 📦 System-wide Packages



### Common

- **Shell**: `fish`
- **Nix Tools**:
  - `nix-ld`

### Feat

#### Desktop

- **Window Server**: `wayland`
- **Window Manager**: `hyprland`

#### GPU

- **GPU**:
  - `nvidia` (choice one)

#### Code

- **Development Tools**:
  - `rust` (choice one)

## 👤 User-specific Software

### Common

<!--- **Editor**: `neovim`-->

- **Editor**: `helix`
- **Terminal Multiplexer**: `zellij`
- **Misc**:
  - `git`

### Feat

#### CLI

- **Shell**: `fish`
- **Nix Tools**:
  - `nixd`
  - `alejandra`
  - `nvd`
  - `nix-diff`
  - `nix-output-monitor`
  - `nh`
- **Misc**:
  - `bat`: Better cat
  - `fzf`: 
  - `eza`: Better ls
  - `ripgrep`: Better grep
  - `less`
  - `trashcan`
  - `bc`
  - `bottom`
  - `fd`
  - `httpie`
  - `jq`
  - `viddy`

#### Desktop

- **Terminal**: `ghostty`
- **Window Manager**: `hyprland`
- **Screen Locker**: `swaylock`
- **Notification**: `mako`
- **Bar**: `waybar`
- **Launcher**: `wofi`
- **Browser**: `firefox`

- **Screenshoot**: `grimblast`
- **Sound Server**: `pulseaudio`
- **Password Manager**:`browserpass`
- **Clipboard Manager**: `cliphist`
- **Misc**:
  `pass-wofi`
