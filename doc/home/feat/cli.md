# 🧱 Zellij Configuration

### 🔹 Variables / Functions

- `hash = builtins.hashString "md5" (builtins.toJSON colorscheme.colors)`\
  ▶️ generates a unique hash from the current `colorscheme.colors` to uniquely identify the theme

---

- `programs.zellij`
  - `enable = true`\
  - `enableFishIntegration = true`\
    ▶️ enables shell integration for the Fish shell (e.g., auto-starting Zellij sessions)
  - `settings`
    - `show_startup_tips = false`\
      ▶️ disables startup tips in Zellij
    - `theme = "nix-${hash}"`\
      ▶️ dynamically names the theme based on the hash of the color palette
    - `themes."nix-${hash}" = import ./theme.nix { inherit colorscheme; }`\
      ▶️ dynamically imports a theme module based on the current colorscheme

# 📜 BAT Configuration

- `programs.bat`
  - `enable = true`
  - `config`
    - `theme = "base16"`\
      ▶️ sets the syntax highlighting theme to `"base16"`

# 📂 Eza Configuration

- `programs.eza`
  - `enable = true`
  - `colors = "auto"`\
    ▶️ automatically enables colored output based on the terminal's capabilities
  - `icons = "auto"`\
    ▶️ automatically shows icons if the terminal/font supports them
  - `git = true`\
    ▶️ enables Git status indicators alongside file listings
  - `enableFishIntegration = true`\
    ▶️ enables shell completions and integration for the Fish shell

# 🔍 Fzf Configuration

- `programs.fzf`
  - `enable = true`
  - `defaultOptions`
    - `--color 16`\
      ▶️ 16-color terminal mode for compatibility
    - `--border`
    - `--height 40%`
  - `enableFishIntegration = true`\
    ▶️ enables shell completions and integration for the Fish shell

# 🔎 Ripgrep Configuration

- `programs.ripgrep`
  - `enable = true`

# 🔗 SSH Configuration

### 🔹 Variables / Functions

- `nixosConfigs = builtins.attrNames outputs.nixosConfigurations`\
  ▶️ gets the list of NixOS configuration names from the flake outputs
- `homeConfigs = map (n: lib.last (lib.splitString "@" n)) (builtins.attrNames outputs.homeConfigurations)`\
  ▶️ extracts usernames from home-manager configurations (format `username@hostname`) by splitting and keeping the last part
- `hostnames = lib.unique (homeConfigs ++ nixosConfigs)`\
  ▶️ combines home-manager and nixos configurations, deduplicated into a list of unique hostnames

---

- `programs.ssh`
  - `enable = true`\
    ▶️ enables the SSH client configuration management
  - `userKnownHostsFile = "${config.home.homeDirectory}/.ssh/known_hosts.d/hosts"`\
    ▶️ customizes the known hosts file location
  - `matchBlocks`
    - `net`
      - `host = lib.concatStringsSep " " (lib.flatten (map (host: [ host ]) hostnames))`\
        ▶️ defines a `Match` block in SSH for all known hosts dynamically
      - `remoteForwards`
        - `bind.address = "/%d/.gnupg-sockets/S.gpg-agent"`\
          ▶️ binds the local GPG agent socket for forwarding
        - `host.address = "/%d/.gnupg-sockets/S.gpg-agent.extra"`\
          ▶️ connects the remote GPG agent socket

# 💾 Impermanence

- `home.persistence."/persist/${config.home.homeDirectory}".directories = [ ".ssh/known_hosts.d" ]`\
  ▶️ persists the `known_hosts.d` directory through reboots, avoiding issues where SSH overwrites files unexpectedly

# 🔧 System Configuration

- `systemd.user
  - `tmpfiles.rules`
    - creates a **symbolic link** from `.ssh/known_hosts` ➔ `.ssh/known_hosts.d/hosts`\
      ▶️ ensures compatibility with programs (like `jujutsu`, `libssh2`, etc.) that hardcode reading `~/.ssh/known_hosts`
  - `services`
    - `link-gnupg-sockets`\
      ▶️ link gnupg sockets from `/run` to `/home`
    - `nix-index-database-sync`\
      ▶️ fetches the latest `nix-index-database` from GitHub
    - `nix-index-database-sync`\
      ▶️ link gnupg sockets from `/run` to `/home`
  - `timers.nix-index-database-sync`\
    ▶️ automatically fetches the `nix-index-database` from GitHub at regular intervals

# 📂 Nix-index Configuration

- `programs.nix-index.enable = true`  
  ▶️ enables the `nix-index` tool, which helps search for packages in the Nixpkgs repository.

# 🔐 GPG Configuration

- `services.gpg-agent`
  - `enable = true`\
    ▶️ enables the GPG agent (handles private keys, including SSH keys)
  - `enableSshSupport = true`\
    ▶️ allows the GPG agent to act as an SSH agent
  - `enableExtraSocket = true`\
    ▶️ creates an extra GPG agent socket (useful for multiple forwarding setups)
  - `enableFishIntegration = true`\
    ▶️ automatically sets up environment variables for the Fish shell
  - `sshKeys = [ "XXX" ]`\
    ▶️ specifies the GPG keygrip for SSH authentication (e.g., YubiKey)\
    ▶️ use `gpg --with-keygrip -K` to get auth key.
  - `pinentryPackage = pkgs.pinentry-tty`\
    ▶️ uses a terminal-based PIN entry program for GPG passphrases
- `programs.gpg`
  - `enable = true`\
    ▶️ enables GPG tooling for managing keys and signing/verifying
  - `settings.trust-model = "tofu+pgp"`\
    ▶️ configures GPG to use Trust On First Use + PGP Web of Trust model
  - `publicKeys`
    - imports public key from `../../pgp.asc`\
      ▶️ trusts the imported key with maximum trust (5)

# Bash shell

- `programs.bash.enable = true`

# 🐟 Fish Shell

- ` programs.fish`
  - `enable = true`
  - `loginShellInit = gpgconf --launch gpg-agent`\
    ▶️ ensures the GPG agent is started early when opening a Fish shell
  - `interactiveShellInit`\
    ▶️ shell script code called during interactive fish shell initialisation
  - `shellAbbrs`\
    ▶️ set of fish abbreviations
  - `shellAliases`\
    ▶️ set of aliases for fish shell, which overrides `environment.shellAliases`

# 📦 Home packages

- `home.packages`
  - `pkgs.pinentry-tty`\
    ▶️ GnuPG’s interface to passphrase input
  - `pkgs.git-fixup`\
    ▶️ a helper for quickly fixing old commits
  - `pkgs.wget`\
    ▶️ tool used for downloading files from the internet
  - `pkgs.comma`\
    ▶️ runs software without installing it with nix
  - `pkgs.bc`\
    ▶️ GNU software calculator
  - `pkgs.httpie`\
    ▶️ better curl
  - `pkgs.ncdu`\
    ▶️ disk usage analyzer with an ncurses interface
  - `pkgs.timer`\
    ▶️ `sleep` with progress
  - `pkgs.viddy`\
    ▶️ modern watch command, time machine and pager etc
  - `pkgs.nix-output-monitor`\
    ▶️ processes output of Nix commands to show helpful and pretty information
  - `pkgs.nixd`\
    ▶️ Nix language server interoperating
  - `pkgs.nix-diff`\
    ▶️explain why two Nix derivations differ
  - `pkgs.fishPlugins.fzf`\
    ▶️ mnemonic key bindings to efficiently find what you need using `fzf`
  - `pkgs.fishPlugins.hydro`\
    ▶️ minimalist prompt

# JQ Configuration

- `programs.jq.enable = true`

# FD Configuration

- `programs.fd.enable = true`

# Bottom Configuration

- `programs.bottom`
  - `enable = true`
  - `settings`
    - `flags`
      - `avg_cpu = true`
      - `temperature_type = "c"`
    - `colors`
      - `low_battery_color = "red"`

# 📂 Direnv Configuration

- `programs.direnv`
  - `enable = true`\
    ▶️ enables `direnv`, a shell extension that automatically loads environment variables when entering a directory
  - `nix-direnv.enable = true`\
    ▶️ enables `nix-direnv`, allowing seamless `.envrc` integration with Nix flakes and environments

# 📝 Git Configuration

- `programs.git`
  - `enable = true`
  - `package = pkgs.gitAndTools.gitFull`\
    ▶️ uses the full Git package with extras (credential helpers, etc.)
  - `aliases`
    - `p = "pull --ff-only"`\
      ▶️ pull with fast-forward only (no merge commits)
    - `ff = "merge --ff-only"`\
      ▶️ merge only if fast-forward is possible
    - `graph = "log --decorate --oneline --graph"`\
      ▶️ visualize commit history as a graph
    - `pushall = "!git remote | xargs -L1 git push --all"`\
      ▶️ push all branches to all remotes
  - `signing`
    - `format = "opengpg"`
    - `key = "XXX"`\
      ▶️ GPG key ID used for signing commits
    - `signByDefault = true`\
      ▶️ enforce GPG signing for all commits
    - `signer = "${config.programs.gpg.package}/bin/gpg2"`\
      ▶️ use the correct GPG2 binary
  - `extraConfig`
    - `init.defaultBranch = "main"`\
      ▶️ set "main" as the default branch
    - `merge.conflictStyle = "zdiff3"`\
      ▶️ improved conflict markers for merges
    - `commit.verbose = true`\
      ▶️ include the diff when committing
    - `diff.algorithm = "histogram"`\
      ▶️ better diff output using histogram algorithm
    - `log.date = "iso"`\
      ▶️ ISO format for Git logs
    - `column.ui = "auto"`\
      ▶️ automatically format output into columns
    - `branch.sort = "committerdate"`\
      ▶️ sort branches by most recent commit date
    - `push.autoSetupRemote = true`\
      ▶️ automatically set up tracking branches when pushing
    - `rerere.enabled = true`\
      ▶️ reuse resolved conflicts automatically during rebase/merge
  - `lfs.enable = true`\
    ▶️ enable Git Large File Storage (LFS) support
  - `ignores`\
    ▶️ ignore given pattern
    - `.direnv`
    - `result`
  - `diff-highlight.enable = true`\
    ▶️ syntax highlighter
