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
      refreshRate = 240;
      workspace = "2";
      position = "auto-left";
    }
  ];

  wallpaper = inputs.themes.packages.${pkgs.system}.wallpapers.car-purple;
  fontProfiles = {
    enable = true;
    monospace = {
      name = "0xProtoMono Nerd Font";
      package = pkgs.nerd-fonts._0xproto;
    };
    regular = {
      name = "0xProto Sans";
      package = pkgs.nerd-fonts._0xproto;
    };
  };

}
