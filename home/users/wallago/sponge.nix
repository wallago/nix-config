{ lib, config, pkgs, inputs, outputs, ... }:
let username = "wallago";
in {
  imports = [
    (import ../../common { inherit username lib config pkgs outputs inputs; })
    ../../feat/desktop
    ../../feat/pass.nix
    ./common.nix
  ];

  #  ------   ----------   ------ 
  # | DP-1 | | HDMI-A-1 | | DP-2 |
  #  ------   ----------   ------
  monitors = [
    {
      name = "DP-2";
      width = 1280;
      height = 768;
      workspace = "3";
      position = "4480x0";
    }
    {
      name = "DP-1";
      width = 1920;
      height = 1080;
      refreshRate = 240;
      workspace = "2";
      position = "0x0";
      scale = "1";
    }
    {
      name = "HDMI-A-1";
      width = 2560;
      height = 1440;
      workspace = "1";
      primary = true;
      position = "1920x0";
    }
  ];

  wallpaper = "purple-night-porsche-drawing-dark";
  colorscheme.type = "fidelity";

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

  # Paris
  services.wlsunset = {
    latitude = 48.8575;
    longitude = 2.3514;
  };
}
