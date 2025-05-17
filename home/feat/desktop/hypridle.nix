{ lib, config, pkgs, ... }:
let
  brightnessctl = lib.getExe pkgs.brightnessctl;
  hyprctl = lib.getExe' config.wayland.windowManager.hyprland.package "hyprctl";
  hyprlock = lib.getExe config.programs.hyprlock.package;
  loginctl = lib.getExe' pkgs.systemd "loginctl";
in lib.mkIf (config.programs.hyprlock.enable
  && config.wayland.windowManager.hyprland.enable) {
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "${hyprlock}";
          before_sleep_cmd = "${loginctl} lock-session";
          after_sleep_cmd = "${hyprctl} dispatch dpms on";
        };
        listener = [
          # Brightness control (10% after 2.5m)
          {
            timeout = 150;
            on-timeout = "${brightnessctl} -s set 10";
            on-resume = "${brightnessctl} -r";
          }
          # Lock screen (5m)
          {
            timeout = 300;
            on-timeout = "${loginctl} lock-session";
          }
          # DPMS off (5m10s)
          {
            timeout = 310;
            on-timeout = "${hyprctl} dispatch dpms off";
            on-resume = "${hyprctl} dispatch dpms on";
          }
        ];
      };
    };
  }

