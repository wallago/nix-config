{ lib, config, ... }:
let
  inherit (lib) types mkOption;
  cfg = config.keymap;

  layoutConfig = {
    us = {
      kb = {
        layout = "us";
        variant = "";
      };
      nav = {
        left = "h";
        down = "j";
        up = "k";
        right = "l";
      };
    };
    fr = {
      kb = {
        layout = "fr";
        variant = "";
      };
      nav = {
        left = "h";
        down = "j";
        up = "k";
        right = "l";
      };
    };
    colemak-dh = {
      kb = {
        layout = "us";
        variant = "colemak_dh";
      };
      nav = {
        left = "n";
        down = "e";
        up = "i";
        right = "o";
      };
    };
  };
in {
  options.keymap = {
    layout = mkOption {
      type = types.enum [ "us" "fr" "colemak-dh" ];
      default = "colemak-dh";
    };
    nav = mkOption {
      readOnly = true;
      type = types.attrsOf types.str;
      default = layoutConfig.${cfg.layout}.nav;
    };
    kb = mkOption {
      readOnly = true;
      type = types.attrsOf types.str;
      default = layoutConfig.${cfg.layout}.kb;
    };
  };
  config = { services.xserver.xkb = layoutConfig.${cfg.layout}.kb; };
}
