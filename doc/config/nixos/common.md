# 🔧 System Configuration

### 🔹 Variables / Functions

- `flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs`\
  ▶️ filter inputs for flakes

---

- `system.stateVersion = config.system.nixos.release`\
  ▶️ version of NixOS
- `nixpkgs`
  - `overlays = builtins.attrValues outputs.overlays`\
    ▶️ set overlays from outputs
  - `nixpkgs.config.allowUnfree = true`\
    ▶️ allow unfree packages
- `nix`
  - `settings`
    - `trusted-users = ["root", "@wheel"]`\
      ▶️ trusted users for Nix
    - `auto-optimise-store = true`\
      ▶️ enable store optimization
    - `experimental-features = ["nix-command", "flakes", "ca-derivations"]`\
      ▶️ enable experimental features for Nix
    - `warn-dirty = false`\
      ▶️ disable dirty warnings
    - `system-features = ["kvm", "big-parallel", "nixos-test"]`\
      ▶️ enable system features
    - `flake-registry = ""`\
      ▶️ disable global flake registry
  - `gc`\
    ▶️ garbage Collection + `automatic = true`\
     ▶️ enable automatic garbage collection + `dates = "weekly"`\
     ▶️ set garbage collection date interval + `options = "--delete-older-than +10"`\
     ▶️ set garbage collection options to delete older than 10 days
  - `registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs`\
    ▶️ map each flake input as a registry
  - `nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs`\
    ▶️ set nixPath for each flake input
- `programs.nix-ld.enable = true`\
  ▶️ enable dynamic linking for Nix packages

# ⚙️ Boot Configuration

- `boot`
  - `kernelPackages = pkgs.linuxPackages_latest`\
    ▶️ override the Linux kernel used by NixOS
  - `consoleLogLevel = 4`\
    ▶️ kernel console logging verbosity
  - `loader.grub`
    - `enable = true`  
      ▶️ enable GNU GRUB boot loader
    - `efiSupport = true`\
      ▶️ GRUB should be built with EFI support
    - `efiInstallAsRemovable = true`\
      ▶️ invoke grub-install with `--removable`
  - `initrd.systemd.enable = true`\
    ▶️ use `systemd` in the initrd (initial RAM disk) stage instead of the default init system  
    ▶️ improves early boot diagnostics, consistency, and service management  
    ▶️ enables features like early systemd journal logging and better integration with the main systemd boot process

# 🐟 Fish Shell

- `programs.fish` \
  ▶️ `fish` shell + `enable = true` \
   ▶️ configure fish as an interactive shell + `vendor` + `completions.enable = true`  
   ▶️ completion files provided by other packages + `config.enable = true`\
   ▶️ configuration snippets provided by other packages + `functions.enable = true`\
   ▶️ autoload fish functions provided by other packages

# 👥 User and Group Management

- `users.mutableUsers = false`\
  ▶️ contents of the user and group files will simply be replaced on system activation

# 🏠 Home Manager

- `home-manager`
  - `backupFileExtension = "backup"` \
    ▶️ set extension for backup files
  - `useGlobalPkgs = true`\
    ▶️ use the global package set defined in NixOS configuration

# 🔐 Security Settings

- `security.pam.loginLimits`\
  ▶️ file limit + `domain = @wheel`\
   ▶️ limit to users in the `wheel` group + `item = nofile`\
   ▶️ resource limit being set is the number of open files + `type = soft/hard`\
   ▶️ `soft` limit, which can be increased by the user up to the `hard` limit + `value = XXX`\
   ▶️ limit to XXX open files

# 🌐 Network Management

- `networking.networkmanager.enable`\
  ▶️ use NetworkManager to obtain an IP address and other configuration for all network interfaces

# 🗂️ Persistence Configuration

### 📥 Imports

- `imports = [ inputs.impermanence.nixosModules.impermanence ]`\
  ▶️ import the impermanence module for persistence

---

- `environment.persistence."/persist"` \
  ▶️ define persistent directory + `files = [ "/etc/machine-id" ]`\
   ▶️ list of files to persist + `directories = [ "/var/lib/systemd", "/var/lib/nixos", "/var/log", "/srv" ]`\
   ▶️ list of directories to persist
- `programs.fuse.userAllowOther = true`\
   ▶️ allow other users to access FUSE-mounted files
- `system.activationScripts.persistent-dirs.text`\
  ▶️ script to ensure all home users directories exist and persist with correct permissions

# 🔐 Secrets Management with SOPS

### 🔹 Variables / Functions

- `keys = builtins.filter isEd25519 config.services.openssh.hostKeys`\
  ▶️ list of SSH host ed25519 keys available in the system

### 📥 Imports

- `imports = [ inputs.sops-nix.nixosModules.sops ]`\
  ▶️ import the SOPS module for secrets management

---

- `sops.age.sshKeyPaths = map getKeyPath keys`\
  ▶️ configure SOPS to use the filtered list of SSH keys for decrypting age-encrypted secrets

# 🔗 SSH Configuration

- `services.openssh`
  - `enable = true`\
    ▶️ enable the OpenSSH daemon
  - `port = [2222]`\
    ▶️ configure SSH to listen on port `2222`
  - `settings`
    - `PasswordAuthentication = false`\
      ▶️ disable password authentication
    - `PermitRootLogin = no`\
      ▶️ disallow root login over SSH
    - `LogLevel = "VERBOSE"`\
      ▶️ logging verbosity
  - `hostKeys`\
    ▶️ specify the host key and its type + `type = "ed25519"`\
     ▶️ use the ed25519 key type + `path = "${lib.optionalString hasOptinPersistence "/persistent"}/etc/ssh/ssh_host_ed25519_key"`\`\
     ▶️ conditionally use a path under `/persist` if persistence is enabled
- `programs.ssh.knownHosts = lib.genAttrs hosts (hostname: {`\
  ▶️ configure known SSH host keys for each host in the deployment + `publicKeyFile = ../../hosts/${hostname}/ssh_host_ed25519_key.pub`\
   ▶️ reference the corresponding public key for each host + `extraHostNames = (lib.optional (hostname == config.networking.hostName) "localhost")`
  ▶️ add `localhost` as an alias if the hostname matches the current machine

# 🔋 Power Management

- `services.upower.enable = true`\
  ▶️ A power management daemon used for monitoring battery status and power devices
