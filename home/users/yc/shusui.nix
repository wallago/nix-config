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
        # inputs
        ;
    })
    ../../feat/desktop
  ];

  monitors = [
    {
      name = "HDMI-A-1";
      width = 2560;
      height = 1440;
      workspace = "1";
      primary = true;
    }
    {
      name = "eDP-1";
      width = 1920;
      height = 1080;
      default = 60;
      workspace = "2";
      position = "auto-left";
    }
  ];

  wallpaper = inputs.themes.packages.${pkgs.system}.wallpapers.aenami-bright-planet;
}
