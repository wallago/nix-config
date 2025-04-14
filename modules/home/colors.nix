{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
let
  inherit (lib) types mkOption;
  hexColor = types.strMatching "#([0-9a-fA-F]{3}){1,2}";
in
{
  options.colorscheme = {
    source = mkOption {
      type = types.either types.path hexColor;
      default = if config.wallpaper != null then config.wallpaper else "#2B3975";
    };
    mode = mkOption {
      type = types.enum [
        "dark"
        "light"
      ];
      default = "dark";
    };
    type = mkOption {
      type = types.str;
      default = "rainbow";
    };

    generatedDrv = mkOption {
      type = types.package;
      default = inputs.themes.packages.${pkgs.system}.generateColorscheme (config.colorscheme.source.name
        or "default"
      ) config.colorscheme.source;
    };
    rawColorscheme = mkOption {
      type = types.attrs;
      default = config.colorscheme.generatedDrv.imported.${config.colorscheme.type};
    };

    colors = mkOption {
      readOnly = true;
      type = types.attrsOf hexColor;
      default = config.colorscheme.rawColorscheme.colors.${config.colorscheme.mode};
    };
  };
}
