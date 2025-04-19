# 🧱 Zellij Configuration

### 🔹 Variables / Functions

+ `hash = builtins.hashString "md5" (builtins.toJSON colorscheme.colors)`\
▶️ generates a unique hash from the current `colorscheme.colors` to uniquely identify the theme

---

+ `programs.zellij`
    + `enable = true`\
    ▶️ enables the Zellij terminal multiplexer
    + `enableFishIntegration = true`\
    ▶️ enables shell integration for the Fish shell (e.g., auto-starting Zellij sessions)
    + `settings`
        + `show_startup_tips = false`\
        ▶️ disables startup tips in Zellij
        + `theme = "nix-${hash}"`\
        ▶️ dynamically names the theme based on the hash of the color palette
        + `themes."nix-${hash}" = import ./theme.nix { inherit colorscheme; }`
        ▶️ dynamically imports a theme module based on the current colorscheme
