{ lib, config, pkgs, inputs, outputs, ... }:
let username = "yc";
in {
  imports = [
    ./common.nix
    (import ../../common { inherit username lib config pkgs outputs inputs; })
    ../../feat/desktop
  ];

  #  -------  
  # | eDP-1 |
  #  ------- 
  monitors = [{
    name = "eDP-1";
    width = 1920;
    height = 1080;
    workspace = "1";
    primary = true;
    position = "0x0";
    scale = "1";
  }];

  wallpaper = pkgs.inputs.themes.wallpapers.pipes-drawing-light;
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
