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

  #  ------   ------   ----------
  # | DP-2 | | DP-1 | | HDMI-A-1 |
  #  ------   ------   ----------
  monitors = [
    {
      name = "DP-2";
      width = 1280;
      height = 768;
      workspace = "3";
      position = "0x0";
    }
    {
      name = "DP-1";
      width = 1920;
      height = 1080;
      refreshRate = 240;
      workspace = "2";
      position = "1280x0";
    }
    {
      name = "HDMI-A-1";
      width = 2560;
      height = 1440;
      workspace = "1";
      primary = true;
      position = "3200x0";
    }
  ];

  wallpaper = pkgs.inputs.themes.wallpapers.purple-night-porsche-drawing-dark;
  colorscheme.type = "content";

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
