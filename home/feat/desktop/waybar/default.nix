{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
{
  programs.waybar = {
    enable = true;
    style = import ./style.nix { inherit lib config inputs; };
    systemd.enable = true;
    settings = {
      primary = {
        # layer = "top";
        # position = "top";
        # output = [
        #   "Primary"
        # ];
        # height = 30;
        # margin-top = 5;
        # margin-bottom = 0;
        # margin-left = 5;
        # margin-right = 5;
        exclusive = false;
        passthrough = false;
        height = 40;
        margin = "6";
        position = "top";
        modules-center = [
          "cpu"
          # "custom/gpu"
          # "memory"
          "clock"
          # "custom/unread-mail"
        ];

        modules-right = [
          # "tray"
          # "custom/rfkill"
          # "network"
          # "pulseaudio"
          # "battery"
          # "custom/hostname"
        ];
        clock = import ./modules/clock.nix;
        cpu = import ./modules/cpu.nix;
      };
    };
  };
}
