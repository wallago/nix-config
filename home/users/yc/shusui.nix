{
  lib,
  config,
  pkgs,
  inputs,
  outputs,
  ...
}:
let
  username = "yc";
in
{
  imports = [
    ./common.nix
    (import ../../common {
      inherit
        username
        lib
        config
        pkgs
        outputs
        inputs
        ;
    })
    ../../feat/desktop
  ];

  #  ------   ----------
  # | DP-1 | | HDMI-A-1 |
  #  ------   ----------
  monitors = [
    {
      name = "DP-1";
      width = 1920;
      height = 1080;
      refreshRate = 240;
      workspace = "2";
      position = "auto-left";
    }
    {
      name = "HDMI-A-1";
      width = 2560;
      height = 1440;
      workspace = "1";
      primary = true;
    }
  ];

  wallpaper = inputs.themes.packages.${pkgs.system}.wallpapers.car-purple;

  fontProfiles = {
    enable = true;
    monospace = {
      name = "0xProto Nerd Font Mono";
      package = pkgs.nerd-fonts.fira-mono;
    };
    regular = {
      name = "0xProto Sans";
      package = pkgs.nerd-fonts.fira-code;
    };
  };
}
