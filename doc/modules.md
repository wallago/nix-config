# 🎨 Color Scheme Configuration

+ `options.colorscheme`
    + `source = mkOption`
        + `type = types.either types.path hexColor`\
        ▶️ can be either a file path or a hex color code  
        + `default = if config.wallpaper != null then config.wallpaper else "#2B3975"`\
        ▶️ uses the wallpaper if defined, otherwise falls back to a default hex color
    + `mode`
      + `type = "dark" | "light"`\
      ▶️ choose between dark and light variants  
      + `default = "dark"`
    + `type`
        + `type = str`  
        ▶️ theme type identifier used for looking up colors in the generated scheme  
        + `default = "rainbow"`
    + `generatedDrv`\
    ▶️ generated derivation that produces the color scheme  
        + `type = package`  
        + `default = inputs.themes.packages.${pkgs.system}.generateColorscheme (config.colorscheme.source.name or "default") config.colorscheme.source
`\
        ▶️ calls `generateColorscheme` from the `themes` flake input, using the source
    + `rawColorscheme`\
    ▶️ raw attribute set imported from the generated derivation  
        + `type = attrs`  
        + `default = config.colorscheme.generatedDrv.imported.${config.colorscheme.type}`
    + `colors`\
    ▶️ the final color set used in the system  
        + `type = attrsOf hexColor`  
        + `readOnly = true`  
        + `default = config.colorscheme.rawColorscheme.colors.${config.colorscheme.mode}`\
        ▶️ selects the colors based on the selected mode (`dark` or `light`)

# 🖋️ Font Profiles

### 🔹 Variables / Functions

+ `mkFontOption = kind:`
    + `name = lib.mkOption`\
    ▶️ font family name
        + `type = lib.types.str`
        + `default = null`
        + `description = "Family name for ${kind} font profile"`
        + `example = "Fira Code"`
    + `package = lib.mkOption`\
    ▶️ font package to install 
        + `type = lib.types.package`
        + `default = null`
        + `description = "Package for ${kind} font profile"`
        + `example = "pkgs.nerd-fonts.fira-code"`
    + `size = lib.mkOption`\
    ▶️ font size in pixels
        + `type = lib.types.int`
        + `default = 12`
        + `description = "Size in pixels for ${kind} font profile"`
        + `example = "14"`

---

+ `options.fontProfiles`
    + `enable = lib.mkEnableOption "Whether to enable font profiles"`\
    ▶️ adds a standard `enable` boolean option with a helpful description
    + `monospace = mkFontOption "monospace"`\
    ▶️ configuration for monospace fonts
    + `regular = mkFontOption "regular"`\
    ▶️ configuration for regular fonts

+ `config = lib.mkIf cfg.enable`
    + `fonts.fontconfig.enable = true`\
    ▶️ enables Fontconfig (required for user font customization)
    + `home.packages = [ cfg.monospace.package cfg.regular.package ]`\
    ▶️ ensures both font packages are installed in the user environment

# 🖥️ Monitor Configuration

+ `options.monitors = mkOption`
    + `type = types.listOf (`
        + `options`
            + `name = mkOption`\
            ▶️ name of the monitor output
                + `type = types.str`  
                + `example = "DP-1"`
            + `primary = mkOption`\
            ▶️ whether this monitor is the primary display
                + `type = types.bool`  
                + `example = false`
            + `width = mkOption`\
            ▶️ width of the monitor in pixels
                + `type = types.int`  
                + `example = 1920`
            + `height = mkOption`\
            ▶️ height of the monitor in pixels
                + `type = types.int`  
                + `example = 1080`
            + `refreshRate = mkOption`\
            ▶️ refresh rate in Hz
                + `type = types.int`  
                + `example = 60`
            + `position = mkOption`\
            ▶️ placement of this monitor relative to others
                + `type = types.str`  
                + `example = "auto"`
            + `enabled = mkOption`\
            ▶️ whether the monitor is enabled
                + `type = types.bool`  
                + `example = true`
            + `workspace = mkOption`\
            ▶️ optional workspace to assign to this monitor
                + `type = types.nullOr types.str`  
                + `example = null`
+ `config.assertions`
    + ```nix
        assertion =
          ((lib.length config.monitors) != 0)
          -> ((lib.length (lib.filter (m: m.primary) config.monitors)) == 1);
        message = "Exactly one monitor must be set to primary.";
        ```
        ▶️ ensures there is one and only one primary monitor selected  

# 🖼️ Wallpaper Configuration

+ `options.wallpaper = lib.mkOption`\
    + `type = null or path`\
    ▶️ accepts either a filesystem path to an image, or `null` if no wallpaper is set
    + `default = null`\
    ▶️ no wallpaper will be used unless explicitly set
    + `description = "Wallpaper path"`\
