{ lib, config, pkgs, inputs, outputs, ... }:
let username = "wallago";
in {
  imports = [
    (import ../../common { inherit username lib config pkgs outputs inputs; })
    ../../feat/desktop
    ../../feat/pass.nix
    ../../feat/productivity
    ../../feat/games
    ./common.nix
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
  }];

  wallpaper = pkgs.inputs.themes.wallpapers.montain-light;
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
