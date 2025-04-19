# 🏠 Home Manager Settings

+ `programs.home-manager.enable = true`\
▶️ enables Home Manager as a Nix module, allowing declarative user-level config management
+ `git.enable = true`\
▶️ enables Git 
+ `systemd.user.startServices = "sd-switch"`\
▶️ ensures user services managed by systemd are started or restarted automatically when switching configs with `home-manager switch`


# 🧱 Zellij Configuration

+ `programs.zellij`
    + `enable = true`\
    ▶️ enables the Zellij terminal multiplexer
    + `enableFishIntegration = true`\
    ▶️ enables shell integration for the Fish shell (e.g., auto-starting Zellij sessions)
    + `settings`
        + `show_startup_tips = false`\
        ▶️ disables startup tips in Zellij
        + `theme = "custom"`\
        ▶️ sets the active theme to a custom one defined in `themes.custom`
        + `themes.custom`\
        ▶️ defines a custom theme using colors from your `colorscheme` module

# 👤 Home Configuration

+ `home`
    + `username = "\${username}"`\
    ▶️ sets the system username for this Home Manager configuration
    + `homeDirectory = "/home/\${username}"`\
    ▶️ defines the home directory path
    + `sessionPath = [ "$HOME/.local/bin" ]`\
    ▶️ prepends custom directories to the session `$PATH` (useful for user-installed tools)
    + `sessionVariables`\
    ▶️ defines environment variables for the user session
        + `FLAKE = "$HOME/Documents/NixConfig"`\
        ▶️ variable pointing to the flake path
    + `persistence."/persistent/\${home.homeDirectory}"`\
    ▶️ sets up persistent directories with impermanence module
        + `defaultDirectoryMethod = "symlink"`\
        ▶️ uses symbolic links to restore persistent directories
        + `directories = [ Documents Downloads Pictures Videos .local/bin .local/share/nix ]`\
        ▶️ list of directories to persist across reboots:
    + `allowOther = true`\
    ▶️ allows other users to access the persisted directories (useful with FUSE)
    + `stateVersion = "25.05"`\
    ▶️ sets the Home Manager state version

# 🎨 Colorscheme and Theme Toggling

+ `colorscheme.mode = lib.mkOverride 1499 "dark"`\
▶️ override the default colorscheme mode to `"dark"` with high priority (1499)
+ `specialisation`\
▶️ define alternate specialised configurations that can be switched at runtime
  + `dark.configuration.colorscheme.mode = lib.mkOverride 1498 "dark"`\
  ▶️ dark specialisation sets the mode to "dark"
  + `light.configuration.colorscheme.mode = lib.mkOverride 1498 "light"`\
  ▶️ light specialisation sets the mode to "light"
+ `home.file."~/.colorscheme.json".text = builtins.toJSON config.colorscheme`\
▶️ export the current colorscheme configuration to a JSON file in the user's home directory
+ `home.packages = [ specialisation toggle-theme ]`\
▶️ provide utilities to list and toggle theme specialisations
    + `specialisation = pkgs.writeShellScriptBin "specialisation"`\
    ▶️ shell script to manage Home Manager specialisations
        + reads from `$HOME/.local/state/nix/profiles`
        + links the active or base profile appropriately
        + lists available specialisations
        + activates the selected one (or the base)
    + `toggle-theme = pkgs.writeShellScriptBin "toggle-theme"`\
    ▶️ script to switch between light and dark themes
        + reads current theme mode from ~/.colorscheme.json
        + activates the alternate theme using the specialisation script

# 🧰 Home Manager Flake Setup

This config should be included when using hm standalone

### 🔹 Variables / Functions

+ `flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs`\
▶️ filter inputs for flakes

---

+ `nix`
    + `package = pkgs.nix`\
    ▶️ use the Nix package provided by the current `pkgs` set
    + `settings.experimental-features = [ "nix-command" "flakes" "ca-derivations" ]`\
    ▶️ enable experimental features for flake and modern Nix workflows
    + `settings.warn-dirty = false`\
    ▶️ disable warnings when building from a dirty (uncommitted changes) working directory
    + `settings.flake-registry = ""`\
    ▶️ disable use of the global flake registry, for fully declarative input control
    + `registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs`\
    ▶️ map each flake input as a registry
+ `home.sessionVariables`\
▶️ defines environment variables for the user session
    + `NIX_PATH = "NIX_PATH = lib.concatStringsSep ":" (lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs)`\
    ▶️ variable from flake inputs
+ `nixpkgs`
    + `overlays = builtins.attrValues outputs.overlays`\
    ▶️ apply all flake overlays from `outputs.overlays`
    + `config`
        + `allowUnfree = true`\
        ▶️ allow installation of unfree packages globally
        + `allowUnfreePredicate = _: true`\
    ▶️ allow *any* unfree package by predicate (for finer control if needed)

