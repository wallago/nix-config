# > Helix configuration

### 🔹 Variables / Functions

+ `hash = builtins.hashString "md5" (builtins.toJSON colorscheme.colors)`\
▶️ generates a unique hash from the current `colorscheme.colors` to uniquely identify the theme

---

+ `home.sessionVariables`\
▶️ defines editor-related environment variables
    + `EDITOR = "hx"`\
    ▶️ sets Helix as the default editor
    + `COLORTERM = "truecolor"`\
    ▶️ forces terminal to use full 24-bit color
+ `programs.helix`
    + `enable = true`\
    ▶️ enables Helix through Home Manager
    + `settings`
        + `theme = "nix-${hash}"`\
        ▶️ dynamically names the theme based on the hash of the color palette
        + `editor`
            + `soft-wrap.enable = true`\
            ▶️ enables word wrapping in text
            + `color-modes = true`\
            ▶️ uses separate colors for each mode (e.g. insert, normal)
            + `line-number = "relative"`\
            ▶️ shows relative line numbers for navigation
            + `bufferline = "multiple"`\
            ▶️ displays multiple open buffers
            + `indent-guides.render = true`\
            ▶️ shows indentation markers
            + `cursor-shape`\
            ▶️ different cursor shapes per mode:
                + `normal = "block"`
                + `insert = "bar"`
                + `select = "underline"`
    + `languages`
        + `language`
            + `name = "nix"`\
            ▶️ targets Nix files
            + `language-servers = [ nixd nil ]`\
            ▶️ enables two language servers: [`nixd`](https://github.com/nix-community/nixd) and [`nil`](https://github.com/oxalica/nil)
            + `formatter.command = alejandra`\
            ▶️ formats Nix code using [Alejandra](https://github.com/kamadorueda/alejandra)
        + `language-servers.nixd.command = "nixd"`\
        ▶️ defines `nixd` command path
    + `themes."nix-${hash}" = import ./theme.nix { inherit colorscheme; }`
    ▶️ dynamically imports a theme module based on the current colorscheme
+ `xdg.configFile."helix/config.toml".onChange = '' ... ''`\
▶️ triggers a reload of running `hx` processes whenever the config changes\
    + uses `pkill -USR1 hx` to notify all user-owned Helix instances
