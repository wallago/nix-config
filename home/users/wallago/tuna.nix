{ lib, config, pkgs, inputs, outputs, ... }:
let username = "wallago";
in {
  imports = [
    ./common.nix
    (import ../../common { inherit username lib config pkgs outputs inputs; })
    # ../../feat/desktop
  ];

  wallpaper = pkgs.inputs.themes.wallpapers.purple-night-porsche-drawing-dark;
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
