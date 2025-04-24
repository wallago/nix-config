# 💽 Installed Software

## 📦 System-wide Packages

### 🧩 Common 


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
