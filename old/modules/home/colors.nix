{ lib, config, pkgs, ... }:
let
  inherit (lib) types mkOption;
  hexColor = types.strMatching "#([0-9a-fA-F]{3}){1,2}";
  cfg = config.colorscheme;
in {
  options.colorscheme = {
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
      default =
        pkgs.inputs.themes.selectColorscheme (config.wallpaper) cfg.type;
    };

    colors = mkOption {
      readOnly = true;
      type = types.attrsOf hexColor;
      default = cfg.generatedDrv.parsed.colors.${cfg.mode};
    };
  };
}
