{ lib, config, pkgs, ... }:
let
  cfg = config.colorscheme;
  inherit (lib) types mkOption;
  hexColor = types.strMatching "#([0-9a-fA-F]{3}){1,2}";

  generatedDrv =
    pkgs.inputs.themes.generateColorscheme (cfg.source.name or "default")
    cfg.source;
  rawColorscheme = import (builtins.toString generatedDrv + "/colorscheme.nix");
  colors = rawColorscheme.colors.${cfg.mode};
in {
  options.colorscheme = {
    source = mkOption {
      type = types.either types.path hexColor;
      default =
        if config.wallpaper != null then config.wallpaper else "#2B3975";
    };
    mode = mkOption {
      type = types.enum [ "dark" "light" ];
      default = "dark";
    };
    type = mkOption {
      type = types.str;
      default = "rainbow";
    };

    generatedDrv = mkOption {
      type = types.package;
      default = null;
      description = "Generated colorscheme derivation";
    };

    rawColorscheme = mkOption {
      type = types.attrs;
      default = { };
      description = "Raw colorscheme data imported from generatedDrv";
    };

    colors = mkOption {
      type = types.attrsOf hexColor;
      default = { };
      description = "Colors extracted from rawColorscheme";
    };
  };

  config = lib.mkIf true { # always apply (or add your condition)
    # Compute the generatedDrv path using resolved options:
    colorscheme = let
      # Resolve source, fallback to "default" string if no name attr
      sourceName = if (config.colorscheme.source != null)
      && (builtins.isAttrs config.colorscheme.source)
      && (config.colorscheme.source.name != null) then
        config.colorscheme.source.name
      else
        "default";

      drv = pkgs.inputs.themes.generateColorscheme sourceName
        config.colorscheme.source;
      raw = import (builtins.toString drv + "/colorscheme.nix");
      colors = raw.colors.${config.colorscheme.mode};
    in {
      generatedDrv = drv;
      rawColorscheme = raw;
      colors = colors;
    };
  };
}
