{ lib, config, ... }:

let
  inherit (lib) types mkOption;
  cfg = config.keymap;
in {
  options.keymap = {
    layout = mkOption {
      type = types.enum [ "us" "fr" "colemak-dh" ];
      default = "colemak-dh";
    };

    nav = mkOption {
      readOnly = true;
      type = types.attrsOf types.str;
      default = {
        us = {
          left = "h";
          down = "j";
          up = "k";
          right = "l";
        };
        fr = {
          left = "h";
          down = "j";
          up = "k";
          right = "l";
        };
        colemak-dh = {
          left = "n";
          down = "e";
          up = "i";
          right = "o";
        };
      }.${cfg.layout};
    };
  };
}
