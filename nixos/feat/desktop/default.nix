{ pkgs, ... }:
{
  services = {
    xserver = {
      enable = true;
      displayManager = {
        gdm = {
          enable = true;
          wayland = true;
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    wayland # ------> Core Wayland protocol libraries.
    xwayland # -----> Required if you want to run X11 apps under Wayland.
    wl-clipboard # -> Clipboard utilities for Wayland (copy/paste support).
  ];

  programs.hyprland.enable = true;
}
